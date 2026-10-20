<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Property;
use App\Models\PropertyImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;

class OwnerPropertyImageController extends Controller
{
    // POST /api/owner/properties/{propertyId}/images
    public function store(Request $request, $propertyId)

    {
        // 1) تأكد العقار للمالك الحالي
        $property = Property::where('id', $propertyId)
            ->where('owner_id', $request->user()->id)
            ->firstOrFail();

        // max 10 images per property
        if ($property->images()->count() >= 10) {
            return response()->json([
                'message' => 'Maximum 10 images allowed for this property'
            ], 422);
        }
        // 2) تحقق من الملف
        $validated = $request->validate([
            'image' => ['required', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'is_main' => ['nullable', 'boolean'],
        ]);

        // 3) خزّن الملف فعلياً
        $path = $validated['image']->store("properties/{$property->id}", 'public');

        // 4) حدد الرئيسية: أول صورة تلقائياً رئيسية
        $makeMain = (bool)($validated['is_main'] ?? false);
        if (!$property->images()->exists()) {
            $makeMain = true;
        }

        if ($makeMain) {
            $property->images()->update(['is_main' => false]);
        }

        // 5) احفظ في DB
        $img = PropertyImage::create([
            'property_id' => $property->id,
            'image_path' => $path,
            'is_main' => $makeMain,
        ]);

        // 6) رجّع رابط جاهز للفرونت
        return response()->json([
            'data' => [
                'id' => $img->id,
                'property_id' => $img->property_id,
                'is_main' => $img->is_main,
                'image_path' => $img->image_path,
                'image_url' => Storage::disk('public')->url($img->image_path),
            ]
        ], 201);
    }
    // PATCH /api/owner/properties/{propertyId}/images/{imageId}/make-main
    public function makeMain(Request $request, $propertyId, $imageId)
    {
        // تأكد العقار للمالك
        $property = Property::where('id', $propertyId)
            ->where('owner_id', $request->user()->id)
            ->firstOrFail();

        // تأكد الصورة تابعة لنفس العقار
        $img = PropertyImage::where('id', $imageId)
            ->where('property_id', $property->id)
            ->firstOrFail();

        DB::transaction(function () use ($property, $img) {
            $property->images()->update(['is_main' => false]);
            $img->is_main = true;
            $img->save();
        });

        return response()->json(['message' => 'OK']);
    }

    // DELETE /api/owner/properties/{propertyId}/images/{imageId}
    public function destroy(Request $request, $propertyId, $imageId)
    {
        // تأكد العقار للمالك
        $property = Property::where('id', $propertyId)
            ->where('owner_id', $request->user()->id)
            ->firstOrFail();

        // تأكد الصورة تابعة لنفس العقار
        $img = PropertyImage::where('id', $imageId)
            ->where('property_id', $property->id)
            ->firstOrFail();

        $wasMain = (bool) $img->is_main;

        // احذف الملف من التخزين
        Storage::disk('public')->delete($img->image_path);

        // احذف من قاعدة البيانات
        $img->delete();

        // إذا كانت الرئيسية وانحذفت: خلي أول صورة متبقية رئيسية
        if ($wasMain) {
            $newMain = $property->images()->orderBy('id')->first();
            if ($newMain) {
                $newMain->is_main = true;
                $newMain->save();
            }
        }

         return response()->json(['message' => 'Deleted']);
    }
}