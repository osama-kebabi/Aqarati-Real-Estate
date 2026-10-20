<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Property;
use Illuminate\Http\Request;

class BookingController extends Controller
{

    // ── المستأجر يرسل طلب حجز ──
    public function store(Request $request)
    {
        $user = $request->user();

        if ($user->role === 'admin') {
            return response()->json(['message' => 'غير مسموح'], 403);
        }

        $validated = $request->validate([
            'property_id' => ['required', 'exists:properties,id'],
            'note'        => ['nullable', 'string', 'max:500'],
        ]);

        $property = Property::findOrFail($validated['property_id']);

        if ($property->owner_id === $user->id) {
            return response()->json(['message' => 'لا يمكنك حجز عقارك الخاص'], 403);
        }

        // التحقق من الطالب
        if ($property->is_student_friendly && $user->tenant_type !== 'student') {
            return response()->json(['message' => 'هذا العقار مخصص للطلاب فقط'], 403);
        }

        $maxOccupants = $property->division_accept === 'yes'
            ? (int)($property->division_count ?? 1)
            : 1;

        $currentOccupants = Booking::where('property_id', $property->id)
            ->where('status', 'accepted')
            ->count();

        if ($currentOccupants >= $maxOccupants) {
            return response()->json(['message' => 'العقار ممتلئ - لا توجد أماكن متاحة'], 422);
        }

        $exists = Booking::where('property_id', $property->id)
            ->where('tenant_id', $user->id)
            ->whereIn('status', ['pending', 'accepted'])
            ->exists();

        if ($exists) {
            return response()->json(['message' => 'لديك طلب حجز سابق لهذا العقار'], 422);
        }

        $booking = Booking::create([
            'property_id' => $property->id,
            'tenant_id'   => $user->id,
            'owner_id'    => $property->owner_id,
            'status'      => 'pending',
            'note'        => $validated['note'] ?? null,
        ]);

        return response()->json([
            'message' => 'تم إرسال طلب الحجز بنجاح، بانتظار موافقة المالك',
            'data'    => $booking
        ], 201);
    }

    // ── المالك يشوف طلبات الحجز ──
    public function ownerIndex(Request $request)
    {
        $user = $request->user();
        if ($user->role !== 'owner') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $bookings = Booking::with([
            'property:id,title,division_count',
            'tenant:id,name,phone,email',
        ])
        ->where('owner_id', $user->id)
        ->latest()
        ->get()
        ->map(function ($b) {
            $b->current_occupants = Booking::where('property_id', $b->property_id)
                ->where('status', 'accepted')
                ->count();
            return $b;
        });

        return response()->json(['data' => $bookings]);
    }

    // ── المالك يقبل الحجز مع تحديد المدة ──
    public function accept(Request $request, $id)
    {
        $user    = $request->user();
        $booking = Booking::where('id', $id)
            ->where('owner_id', $user->id)
            ->where('status', 'pending')
            ->firstOrFail();

        $request->validate([
            'start_date' => ['required', 'date'],
            'end_date'   => ['required', 'date', 'after:start_date'],
        ], [
            'start_date.required' => 'تاريخ البداية مطلوب',
            'end_date.required'   => 'تاريخ النهاية مطلوب',
            'end_date.after'      => 'تاريخ النهاية يجب أن يكون بعد تاريخ البداية',
        ]);

        $property = Property::findOrFail($booking->property_id);

        $currentOccupants = Booking::where('property_id', $property->id)
            ->where('status', 'accepted')
            ->count();

        $maxOccupants = (int)($property->division_count ?? 1);

        if ($currentOccupants >= $maxOccupants) {
            return response()->json(['message' => 'العقار ممتلئ'], 422);
        }

        $booking->update([
            'status'     => 'accepted',
            'start_date' => $request->start_date,
            'end_date'   => $request->end_date,
        ]);

        if ($currentOccupants + 1 >= $maxOccupants) {
            $property->update(['is_available' => false]);
        }

        return response()->json(['message' => 'تم قبول الحجز', 'data' => $booking]);
    }

    // ── المالك يرفض الحجز ──
    public function reject(Request $request, $id)
    {
        $user    = $request->user();
        $booking = Booking::where('id', $id)
            ->where('owner_id', $user->id)
            ->where('status', 'pending')
            ->firstOrFail();

        $booking->update(['status' => 'rejected']);

        $property = Property::findOrFail($booking->property_id);
        if (!$property->is_available) {
            $property->update(['is_available' => true]);
        }

        return response()->json(['message' => 'تم رفض الحجز', 'data' => $booking]);
    }

    // ── المالك يزيل مستأجراً مقبولاً (إخلاء العقار) ──
    public function remove(Request $request, $id)
    {
        $user    = $request->user();
        $booking = Booking::where('id', $id)
            ->where('owner_id', $user->id)
            ->where('status', 'accepted')
            ->firstOrFail();

        $booking->update(['status' => 'rejected']);

        $property = Property::findOrFail($booking->property_id);
        if (!$property->is_available) {
            $property->update(['is_available' => true]);
        }

        return response()->json(['message' => 'تم إخلاء المستأجر بنجاح']);
    }

    // ── المستأجر يلغي حجزه ──
    public function cancel(Request $request, $id)
    {
        $user    = $request->user();
        $booking = Booking::where('id', $id)
            ->where('tenant_id', $user->id)
            ->whereIn('status', ['pending', 'accepted'])
            ->firstOrFail();

        $wasAccepted = $booking->status === 'accepted';
        $booking->update(['status' => 'rejected']);

        if ($wasAccepted) {
            $property = Property::findOrFail($booking->property_id);
            $property->update(['is_available' => true]);
        }

        return response()->json(['message' => 'تم إلغاء الحجز']);
    }

    // ── المستأجر يشوف حجوزاته ──
    public function tenantIndex(Request $request)
    {
        $user = $request->user();

        $bookings = Booking::with([
            'property:id,title,city,region,price',
        ])
        ->where('tenant_id', $user->id)
        ->latest()
        ->get();

        return response()->json(['data' => $bookings]);
    }
}
