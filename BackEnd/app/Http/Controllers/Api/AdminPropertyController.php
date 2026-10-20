<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Property;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
class AdminPropertyController extends Controller
{
    // GET /api/admin/properties?status=pending&page=1
    public function index(Request $request)
    {
        $status  = $request->query('status', 'pending');
        $perPage = $request->query('per_page', 15);

        $validStatuses = ['pending', 'approved', 'rejected'];
        if (!in_array($status, $validStatuses)) {
            return response()->json(['message' => 'Invalid status'], 422);
        }

        $properties = Property::with([
                'owner:id,name,email,phone',
                'images' => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
                'university:id,name,city',
            ])
            ->where('status', $status)
            ->orderByDesc('id')
            ->paginate($perPage);

        // إضافة image_url لكل صورة نرفعها
        $properties->getCollection()->each(function ($prop) {
            $prop->images->each(function ($img) {
               $img->image_url = isset($img->image_path) ? asset('storage/' . $img->image_path) : null;
            });
        });

        return response()->json($properties);
    }

    // GET /api/admin/properties/pending-count
    public function pendingCount()
    {
        $count = Property::where('status', 'pending')->count();
        return response()->json(['count' => $count]);
    }

    // PATCH /api/admin/properties/{id}/approve
    public function approve(Request $request, $id)
    {
        $property = Property::findOrFail($id);

        if ($property->status !== 'pending') {
            return response()->json(['message' => 'العقار ليس في حالة انتظار'], 422);
        }

        $property->update([
            'status'      => 'approved',
            'approved_by' => $request->user()->id,
            'approved_at' => now(),
        ]);

        return response()->json([
            'message' => 'تم قبول العقار بنجاح',
            'data'    => $property->fresh(),
        ]);
    }

    // PATCH /api/admin/properties/{id}/reject
    public function reject(Request $request, $id)
    {
        $property = Property::findOrFail($id);

        if ($property->status !== 'pending') {
            return response()->json(['message' => 'العقار ليس في حالة انتظار'], 422);
        }

        $property->update([
            'status'      => 'rejected',
            'approved_by' => $request->user()->id,
            'approved_at' => now(),
        ]);

        return response()->json([
            'message' => 'تم رفض العقار',
            'data'    => $property->fresh(),
        ]);
    }

// GET /api/admin/properties/{id}
public function show($id)
{
    $property = Property::with([
        'images'     => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
        'university:id,name,city',
        'owner:id,name,phone,email',
    ])->findOrFail($id); // بدون فلتر status - الادمن يشوف كل الحالات

    $property->images->each(function ($img) {
        $img->image_url = $img->image_path
            ? Storage::disk('public')->url($img->image_path)
            : null;
    });

    return response()->json(['data' => $property]);
}

public function contactRequests(Request $request)
{
    $reqs = \App\Models\ContactRequest::with([
        'property:id,title',
        'owner:id,name,phone',
    ])
    ->orderByDesc('id')
    ->paginate(50);

    return response()->json($reqs);
}
public function users(Request $request)
{
    $users = \App\Models\User::orderBy('id')->paginate(50);
    return response()->json($users);
}

public function deleteContact($id)
{
    \App\Models\ContactRequest::findOrFail($id)->delete();
    return response()->json(['message' => 'Deleted']);
}
public function banUser(Request $request, $id)
{
    $user = \App\Models\User::findOrFail($id);
    if ($user->role === 'admin') {
        return response()->json(['message' => 'لا يمكن حظر المدير'], 403);
    }
    $user->update(['is_banned' => true]);
    // حذف عقاراته
    \App\Models\Property::where('owner_id', $id)->delete();
    return response()->json(['message' => 'تم الحظر']);
}

public function unbanUser(Request $request, $id)
{
    $user = \App\Models\User::findOrFail($id);
    $user->update(['is_banned' => false]);
    return response()->json(['message' => 'تم إلغاء الحظر']);
}
public function destroy($id)
{
    $property = Property::findOrFail($id);
    $property->delete();
    return response()->json(['message' => 'تم حذف العقار بنجاح']);
}

}
