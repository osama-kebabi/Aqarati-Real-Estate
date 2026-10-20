<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Property;
use Illuminate\Http\Request;

class OwnerNotificationController extends Controller
{
    // GET /api/owner/notifications/property-status
    public function propertyStatus(Request $request)
    {
        $ownerId = $request->user()->id;

        $items = Property::where('owner_id', $ownerId)
            ->whereIn('status', ['approved', 'rejected'])
            ->whereNull('owner_notified_at')
            ->orderByDesc('approved_at')
            ->get(['id', 'title', 'status', 'approved_at']);

        // علّمهم كمشاهَدين
        Property::where('owner_id', $ownerId)
            ->whereIn('status', ['approved', 'rejected'])
            ->whereNull('owner_notified_at')
            ->update(['owner_notified_at' => now()]);

        return response()->json([
            'count' => $items->count(),
            'data'  => $items,
        ]);
    }
    // ✅ FIX #4: حذفنا القوس الزيادة } اللي كان هنا ويسبب Parse Error
}
