<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Property;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class OwnerPropertyController extends Controller
{
    private function ensureOwner(Request $request)
{
    $user = $request->user();
    if (!$user || !in_array($user->role, ['owner', 'admin'])) {
        return response()->json(['message' => 'Forbidden'], 403);
    }
    return null;
}
   

    

    // GET /api/owner/properties
    public function index(Request $request)
    {
        if ($resp = $this->ensureOwner($request)) return $resp;

        $properties = Property::with([
                'images' => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
            ])
            ->where('owner_id', $request->user()->id)
            ->orderByDesc('id')
            ->paginate(10);

        return response()->json($properties);
    }

    // GET /api/owner/properties/{id}
    // public function show(Request $request, $id)
    // {
    //     if ($resp = $this->ensureOwner($request)) return $resp;

    //     $property = Property::with([
    //         'images'     => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
    //         'university:id,name,city',
    //     ])
    //     ->where('id', $id)
    //     ->where('owner_id', $request->user()->id)
    //     ->firstOrFail();

    //     $property->images->each(function ($img) {
    //         $img->image_url = Storage::disk('public')->url($img->image_path);
    //     });

    //     return response()->json(['data' => $property]);
    // }
public function show($id)
{
 $property = Property::with([
 'images' => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
 'university:id,name,city',
 'owner:id,name,phone,email',
 ])->findOrFail($id);

 $property->images->each(function ($img) {
 $img->image_url =  asset('storage/' . $img->image_path);
 });
 return response()->json(['data' => $property]);
}

    // POST /api/owner/properties
    public function store(Request $request)
            {
      // ✅ أي مستخدم مسجّل يقدر يضيف عقار ويتحول تلقائياً لـ owner
        $user = $request->user();

        //  if ($user->role !== 'owner') {
        // $user->role = 'owner';
        // $user->save();
        // }
         if ($user->role === 'tenant') {
        $user->role = 'owner';
        $user->save();
    }
      $validated = $request->validate([
    'title' => ['required', 'string', 'max:255'],
    'description' => ['required', 'string', 'max:5000'],
    'property_type' => ['required', 'string', 'max:50'],
    'city' => ['required', 'string', 'max:100'],
    'region' => ['required', 'string', 'max:100'],
    'address' => ['required', 'string', 'max:255'],
    'latitude' => ['nullable', 'numeric'],
    'longitude' => ['nullable', 'numeric'],
    'rooms_count' => ['required', 'integer', 'min:1'],
    // 'bathrooms_count' => ['required', 'integer', 'min:1'],
    'price' => ['required', 'numeric', 'min:0'],
    // 💡 تعديل الحقول لتصبح nullable أو استخدام دالة الدمج بالفرونت آند لحل مشكلة الـ boolean
    'is_available' => ['nullable'],
    'is_student_friendly' => ['nullable'],
    'has_student_discount' => ['nullable'],
    'student_discount_percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
    'university_id' => ['nullable', 'integer', 'exists:universities,id'],
    'area' => ['nullable', 'numeric', 'min:0'],
    'district' => ['nullable', 'string', 'max:100'],
    'bedrooms' => ['nullable', 'integer', 'min:0'],
    // 'bathrooms' => ['nullable', 'integer', 'min:0'],
    'images' => ['nullable', 'array'],
    'images.*' => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],

    'amenities'   => ['nullable', 'array'],
    'amenities.*' => ['nullable', 'string'],

    'division_accept' => ['nullable', 'string'],
    'division_count'  => ['nullable'],
],$this->arabicValidationMessages());

    $isAdmin = $user->role === 'admin';

// 💡 تأمين تعيين القيم المنطقية قبل الإدخال في قاعدة البيانات
$property = Property::create([
    'owner_id' => $user->id,
    'university_id' => $validated['university_id'] ?? null,
    'title' => $validated['title'],
    'description' => $validated['description'],
    'property_type' => $validated['property_type'],
    'city' => $validated['city'],
    'region' => $validated['region'],
    'address' => $validated['address'],
    'latitude' => $validated['latitude'] ?? null,
    'longitude' => $validated['longitude'] ?? null,
    'rooms_count' => $validated['rooms_count'],
    // 'bathrooms_count' => $validated['bathrooms_count'],
    'price' => $validated['price'],
    'is_available' => $request->has('is_available') ? filter_var($request->is_available, FILTER_VALIDATE_BOOLEAN) : true,
    'is_student_friendly' => $request->has('is_student_friendly') ? filter_var($request->is_student_friendly, FILTER_VALIDATE_BOOLEAN) : false,
    // 'has_student_discount' => $request->has('has_student_discount') ? filter_var($request->has('has_student_discount'), FILTER_VALIDATE_BOOLEAN) : false,
    'has_student_discount' => filter_var($request->input('has_student_discount', false), FILTER_VALIDATE_BOOLEAN),
    'student_discount_percentage' => $request->has('has_student_discount') ? ($validated['student_discount_percentage'] ?? 0) : null,
    'district' => $validated['district'] ?? null,
    'area' => $validated['area'] ?? null,
    'status' => 'pending', // العقار ينشأ معلقاً دائماً بانتظار الأدمن
    'amenities' => $validated['amenities'] ?? [],
    'division_accept' => $request->input('division_accept', 'no'),
    'division_count'  => $request->input('division_count', null),
    'payment_method' => $request->input('payment_method', null),
    'status'      => $isAdmin ? 'approved' : 'pending',
        'approved_by' => $isAdmin ? $user->id  : null,
        'approved_at' => $isAdmin ? now()       : null,
]);

        // رفع الصور
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $index => $image) {
                $path = $image->store("properties/{$property->id}", 'public');
                \App\Models\PropertyImage::create([
                    'property_id' => $property->id,
                    'image_path'  => $path,
                    'is_main'     => $index === 0,
                ]);
            }
        }

        $property->load('images');

        return response()->json(['data' => $property], 201);
    }

    // PUT /api/owner/properties/{id}
    public function update(Request $request, $id)
    {
        if ($resp = $this->ensureOwner($request)) return $resp;

        $property = $this->findOwnerPropertyOrFail($request, $id);

        // ✅ FIX #3: إصلاح validation - كانت فيها ['required|numeric'] خطأ
        $validated = $request->validate([
            'title'                       => ['required', 'string', 'max:255'],
            'description'                 => ['required', 'string', 'max:5000'],
            'property_type'               => ['required', 'string', 'max:50'],
            'city'                        => ['required', 'string', 'max:100'],
            'region'                      => ['required', 'string', 'max:100'],
            'address'                     => ['required', 'string', 'max:255'],
            'area'                        => ['nullable', 'numeric', 'min:0'],  // ✅ إصلاح: كان ['required|numeric']
            'latitude'                    => ['nullable', 'numeric'],
            'longitude'                   => ['nullable', 'numeric'],
            'bedrooms'                    => ['nullable', 'integer', 'min:0'],  // ✅ إصلاح: كان 'required|integer'
            // 'bathrooms'                   => ['nullable', 'integer', 'min:0'],  // ✅ إصلاح: كان 'required|integer'
            'rooms_count'                 => ['required', 'integer', 'min:1'],
            // 'bathrooms_count'             => ['required', 'integer', 'min:1'],
            'price'                       => ['required', 'numeric', 'min:0'],
            'district'                    => ['nullable', 'string', 'max:100'], // ✅ إصلاح: كان 'required|string'
            'is_available'                => ['required', 'boolean'],
            'is_student_friendly'         => ['required', 'boolean'],
            'has_student_discount'        => ['required', 'boolean'],
            'student_discount_percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'university_id'               => ['nullable', 'integer', 'exists:universities,id'],
            'images.*'                    => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp'],
            'amenities'                   => ['nullable', 'array'],
            'amenities.*'                 => ['nullable', 'string'],
            'payment_method'              => ['nullable', 'string'],
        ], $this->arabicValidationMessages());

        if (($validated['has_student_discount'] ?? false) && empty($validated['student_discount_percentage'])) {
            return response()->json([
                'message' => 'student_discount_percentage is required when has_student_discount=1'
            ], 422);
        }

        $property->update([
            'university_id'               => $validated['university_id'] ?? null,
            'title'                       => $validated['title'],
            'description'                 => $validated['description'],
            'property_type'               => $validated['property_type'],
            'city'                        => $validated['city'],
            'region'                      => $validated['region'],
            'address'                     => $validated['address'],
            'latitude'                    => $validated['latitude'] ?? null,
            'longitude'                   => $validated['longitude'] ?? null,
            'rooms_count'                 => $validated['rooms_count'],
            // 'bathrooms_count'             => $validated['bathrooms_count'],
            'price'                       => $validated['price'],
            'district'                    => $validated['district'] ?? null,
            'area'                        => $validated['area'] ?? null,
            'bedrooms'                    => $validated['bedrooms'] ?? null,
            // 'bathrooms'                   => $validated['bathrooms'] ?? null,
            'is_available'                => $validated['is_available'],
            'is_student_friendly'         => $validated['is_student_friendly'],
            'has_student_discount'        => $validated['has_student_discount'],
            'student_discount_percentage' => $validated['has_student_discount']
                ? ($validated['student_discount_percentage'] ?? 0)
                : null,
            // أي تعديل يعيد العقار لـ pending
            'status'      => 'pending',
            'approved_by' => null,
            'approved_at' => null,
            'amenities'      => $request->input('amenities', []),
            'division_accept'=> $request->input('division_accept', 'no'),
            'division_count' => $request->input('division_count', null),
            'payment_method' => $request->input('payment_method', null),
            
            'status'         => 'pending',
            'approved_by'    => null,
            'approved_at'    => null,
        ], $this->arabicValidationMessages());
        // ── تحديث الصور إن أُرسلت جديدة ──
if ($request->hasFile('images')) {
    // احذف القديمة من الـ storage والـ DB
    foreach ($property->images as $oldImg) {
        if ($oldImg->image_path) {
            Storage::disk('public')->delete($oldImg->image_path);
        }
        $oldImg->delete();
    }

    // أضف الجديدة
    $isFirst = true;
    foreach ($request->file('images') as $imageFile) {
        $path = $imageFile->store("properties/{$property->id}", 'public');
        \App\Models\PropertyImage::create([
            'property_id' => $property->id,
            'image_path'  => $path,
            'is_main'     => $isFirst,
        ]);
        $isFirst = false;
    }
}

        $property->refresh()->load('images');

        return response()->json(['data' => $property]);
    }

    public function destroy(Request $request, $id)
    {
        if ($resp = $this->ensureOwner($request)) return $resp;

        $property = $this->findOwnerPropertyOrFail($request, $id);
        $property->delete();

        return response()->json(['message' => 'Deleted']);
    }

    private function findOwnerPropertyOrFail(Request $request, $id)
    {
        return Property::where('id', $id)
            ->where('owner_id', $request->user()->id)
            ->firstOrFail();
    }
   
private function arabicValidationMessages(): array
{
    return [
        'title.required'        => 'عنوان العقار مطلوب',
        'title.max'              => 'عنوان العقار طويل جداً (الحد الأقصى 255 حرف)',
        'description.required'  => 'وصف العقار مطلوب',
        'description.max'       => 'وصف العقار طويل جداً (الحد الأقصى 5000 حرف)',
        'property_type.required'=> 'نوع العقار مطلوب',
        'city.required'         => 'المدينة مطلوبة',
        'region.required'       => 'المنطقة/الحي مطلوب',
        'address.required'      => 'العنوان التفصيلي مطلوب',
        'rooms_count.required'  => 'عدد الغرف مطلوب',
        'rooms_count.integer'   => 'عدد الغرف يجب أن يكون رقماً صحيحاً',
        'rooms_count.min'       => 'يجب أن يكون عدد الغرف 1 على الأقل',
        'price.required'        => 'السعر مطلوب',
        'price.numeric'         => 'السعر يجب أن يكون رقماً',
        'price.min'             => 'السعر لا يمكن أن يكون سالباً',
        'area.numeric'          => 'المساحة يجب أن تكون رقماً',
        'area.min'              => 'المساحة لا يمكن أن تكون سالبة',
        'student_discount_percentage.numeric' => 'نسبة الخصم يجب أن تكون رقماً',
        'student_discount_percentage.min'     => 'نسبة الخصم لا يمكن أن تكون أقل من 0',
        'student_discount_percentage.max'     => 'نسبة الخصم لا يمكن أن تكون أكثر من 100',
        'university_id.exists'  => 'الجامعة المختارة غير موجودة',
        'images.*.image'        => 'الملف المرفوع يجب أن يكون صورة',
        'images.*.mimes'        => 'صيغة الصورة غير مدعومة (jpg, jpeg, png, webp فقط)',
        'images.*.max'          => 'حجم الصورة كبير جداً (الحد الأقصى 5MB)',
        'is_available.required'        => 'حالة التوفر مطلوبة',
        'is_student_friendly.required' => 'حقل "مرتبط بالجامعة" مطلوب',
        'has_student_discount.required'=> 'حقل "خصم الطلاب" مطلوب',
    ];
}
}


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