<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ContactRequest;
use App\Models\Property;
use Illuminate\Http\Request;

class ContactRequestController extends Controller
{

    public function ownerIndex(Request $request)

    {
        $user = $request->user();

        if (!$user || $user->role !== 'owner')  {
            return response()->json(['message' => 'Only owners'], 403);
            }
       $requests = ContactRequest::with([
    'property:id,title',
    'tenant:id,name,email,phone',
])
        ->where('owner_id', $user->id)
        ->latest()
        ->get();
        // mark all as read when owner opens the page
        ContactRequest::where('owner_id', $user->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);
 
            return response()->json(['data' => $requests]);
    }

     public function ownerUnreadCount(Request $request)

    {
        $user = $request->user();
        //  $user =auth()->user();

        if ($user->role !== 'owner') {
            return response()->json(['count' => 0]);
        }

    $count = ContactRequest::where('owner_id', $user->id)
        ->where('is_read', false)
        ->count();

    return response()->json(['count' => $count]);
     }

   
    public function store(Request $request)
{
    $user = $request->user();

    // ❌ admin لا يرسل طلبات تواصل
    if ($user->role === 'admin') {
        return response()->json(['message' => 'المدير لا يمكنه إرسال طلبات تواصل'], 403);
    }

    $validated = $request->validate([
        'property_id' => ['required', 'exists:properties,id'],
        'name'        => ['required'],
        'phone'       => ['required'],
        'message'     => ['required'],
    ]);

    $property = Property::where('id', $validated['property_id'])
        ->where('status', 'approved')
        ->first();

    if (!$property) {
        return response()->json(['message' => 'العقار غير موجود'], 404);
    }

    // ❌ صاحب العقار لا يرسل لنفسه
    if ($property->owner_id === $user->id) {
        return response()->json(['message' => 'لا يمكنك إرسال طلب تواصل لعقارك الخاص'], 403);
    }

    // ❌ منع التكرار
    $exists = ContactRequest::where('property_id', $validated['property_id'])
        ->where('tenant_id', $user->id)
        ->exists();

    if ($exists) {
        return response()->json(['message' => 'أرسلت طلباً لهذا العقار مسبقاً'], 422);
    }

    $contactRequest = ContactRequest::create([
        'property_id' => $property->id,
        'tenant_id'   => $user->id,
        'owner_id'    => $property->owner_id,
        'name'        => $validated['name'],
        'phone'       => $validated['phone'],
        'message'     => $validated['message'],
    ]);

    return response()->json(['data' => $contactRequest], 201);
}

// ✅ جديد: المالك يرد على طلب تواصل
public function reply(Request $request, $id)
{
    $user = $request->user();

    $contactRequest = ContactRequest::where('id', $id)
        ->where('owner_id', $user->id)
        ->firstOrFail();

    $request->validate([
        'reply' => ['required', 'string', 'max:1000'],
    ], [
        'reply.required' => 'نص الرد مطلوب',
    ]);

    $contactRequest->update([
        'reply'       => $request->reply,
        'replied_at'  => now(),
    ]);

    return response()->json(['message' => 'تم إرسال الرد بنجاح']);
}

// ✅ جديد: المستأجر يشوف طلبات تواصله
public function tenantIndex(Request $request)
{
    $user = $request->user();

    $requests = ContactRequest::with([
        'property:id,title,city,region',
    ])
    ->where('tenant_id', $user->id)
    ->latest()
    ->get();

    return response()->json(['data' => $requests]);
}
}

