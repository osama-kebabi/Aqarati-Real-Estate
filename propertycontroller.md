<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Property;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PropertyController extends Controller
{
    // GET /api/properties  (عام - بدون auth)
    public function index(Request $request)
    {
        $query = Property::with([
                'images' => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
                'university:id,name,city',
            ])
            // ✅ صح - في index
->withCount([
    'bookings as current_occupants' => fn($q) => $q->where('status', 'accepted')
             ])
            ->where('status', 'approved')
            ->where('is_available', true)
            ->where('is_student_friendly', false);


        // ── Filters ─────────────────────────────────────────
        if ($q = $request->query('q')) {
            $query->where(fn($sub) =>
                $sub->where('title',       'like', "%{$q}%")
                    ->orWhere('description','like', "%{$q}%")
                    ->orWhere('address',    'like', "%{$q}%")
                    ->orWhere('city',       'like', "%{$q}%")
            );
        }

        if ($city = $request->query('city')) {
            $query->where('city', $city);
        }

        if ($region = $request->query('region')) {
            $query->where('region', $region);
        }

        if ($type = $request->query('property_type')) {
            $query->where('property_type', $type);
        }

        if ($rooms = $request->query('rooms_count')) {
            $query->where('rooms_count', '>=', (int)$rooms);
        }

        if ($minPrice = $request->query('min_price')) {
            $query->where('price', '>=', $minPrice);
        }

        if ($maxPrice = $request->query('max_price')) {
            $query->where('price', '<=', $maxPrice);
        }

        if ($request->query('is_student_friendly') !== null) {
            $query->where('is_student_friendly', filter_var($request->query('is_student_friendly'), FILTER_VALIDATE_BOOLEAN));
        }

        if ($request->query('has_student_discount') !== null) {
            $query->where('has_student_discount', filter_var($request->query('has_student_discount'), FILTER_VALIDATE_BOOLEAN));
        }

        if ($uniId = $request->query('university_id')) {
            $query->where('university_id', $uniId);
        }
       // ──────────────────────────────────────────────────────

        $perPage = min((int)($request->query('per_page', 12)), 50);
        $props   = $query->orderByDesc('id')->paginate($perPage);

        // إضافة image_url للرفع
        $props->getCollection()->each(function ($prop) {
            $prop->images->each(function ($img) {
                $img->image_url = isset($img->image_path) ? asset('storage/' . $img->image_path) : null;
            });
        });

        return response()->json($props);
    }

    // GET /api/properties/{id}  (عام)
    public function show($id)
    {
        $property = Property::with([
                'images'     => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
                'university:id,name,city',
                'owner:id,name,phone,email'
            ])
           // ✅ صح - في show
->withCount([
    'bookings as current_occupants' => fn($q) => $q->where('status', 'accepted')
])
            ->where('id', $id)
            ->where('status', 'approved')
            ->firstOrFail();

        // $property->images->each(function ($img) {
        //     $img->image_url = Storage::disk('public')->url($img->image_path);
                $property->images->each(function ($img) {
                $img->image_url = $img->image_path 
                    ? Storage::disk('public')->url($img->image_path)
                    : null;
            });
        return response()->json(['data' => $property]);
    }

    // GET /api/student/properties  (يحتاج auth - للطلاب)
    public function studentIndex(Request $request)
    {
        $user = $request->user();

        // يسمح لـ students أو owners أو admins بالمشاهدة
        $query = Property::with([
                'images' => fn($q) => $q->orderByDesc('is_main')->orderBy('id'),
                'university:id,name,city',
                'owner:id,name,phone,email',
            ])
             ->withCount([
             'bookings as current_occupants' => fn($q) => $q->where('status', 'accepted')   ])
            ->where('status', 'approved')
            ->where('is_student_friendly', true);

        // إذا كان الطالب عنده جامعة، نعطيه عقارات جامعته أولاً
        if ($user  && $user->tenant_type === 'student' && $user->university_id) {
            $query->orderByRaw("CASE WHEN university_id = {$user->university_id} THEN 0 ELSE 1 END")
                  ->orderByDesc('id');
        } else {
            $query->orderByDesc('id');
        }

        // نفس الفلاتر
        if ($q = $request->query('q')) {
            $query->where(fn($sub) =>
                $sub->where('title', 'like', "%{$q}%")
                    ->orWhere('city',  'like', "%{$q}%")
            );
        }
        if ($city      = $request->query('city'))          $query->where('city', $city);
        if ($uniId     = $request->query('university_id')) $query->where('university_id', $uniId);
        if ($minPrice  = $request->query('min_price'))     $query->where('price', '>=', $minPrice);
        if ($maxPrice  = $request->query('max_price'))     $query->where('price', '<=', $maxPrice);
        if ($rooms     = $request->query('rooms_count'))   $query->where('rooms_count', '>=', $rooms);

        $perPage = min((int)($request->query('per_page', 12)), 50);
        $props   = $query->paginate($perPage);

        $props->getCollection()->each(function ($prop) {
            $prop->images->each(function ($img) {
                $img->image_url = Storage::disk('public')->url($img->image_path);
            });
        });

        return response()->json($props);
    }
}
