<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UniversityController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ContactRequestController;
use App\Http\Controllers\Api\PropertyController;
use App\Http\Controllers\Api\AdminPropertyController;
use App\Http\Controllers\Api\OwnerPropertyController;
use App\Http\Middleware\EnsureAdmin;
use App\Http\Middleware\EnsureOwner;
use App\Http\Controllers\Api\OwnerPropertyImageController;
use App\Http\Controllers\Api\OwnerNotificationController;
use App\Http\Controllers\Api\BookingController;

// ─────────────────────────────────────────────
// Public Routes (لا تحتاج auth)
// ─────────────────────────────────────────────

// جامعات
Route::get('/universities', [UniversityController::class, 'index']);

// Auth
Route::prefix('auth')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login',    [AuthController::class, 'login']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me',      [AuthController::class, 'me']);
        Route::post('/logout', [AuthController::class, 'logout']);
          Route::put('/profile', [App\Http\Controllers\Api\AuthController::class, 'updateProfile']);
    });
  
});

// عقارات عامة (approved فقط)
Route::get('/properties',      [PropertyController::class, 'index']);
Route::get('/properties/{id}', [PropertyController::class, 'show']);

// ─────────────────────────────────────────────
// ✅ FIX #2: حذفنا /admin/ping المكرر خارج الـ group
// Admin Routes (يحتاج auth + admin role)
// ─────────────────────────────────────────────
Route::prefix('admin')
    ->middleware(['auth:sanctum', EnsureAdmin::class])
    ->group(function () {
        Route::get('/ping',                               fn() => response()->json(['message' => 'admin ok']));
        Route::get('/properties/pending-count',           [AdminPropertyController::class, 'pendingCount']);
        Route::get('/properties',                         [AdminPropertyController::class, 'index']);
        Route::patch('/properties/{id}/approve',          [AdminPropertyController::class, 'approve']);
        Route::patch('/properties/{id}/reject',           [AdminPropertyController::class, 'reject']);
        Route::get('/properties/{id}',                    [AdminPropertyController::class, 'show']);
        Route::get('/users',                        [AdminPropertyController::class, 'users']);
        Route::get('/contact-requests',             [AdminPropertyController::class, 'contactRequests']);
        Route::delete('/contact-requests/{id}',     [AdminPropertyController::class, 'deleteContact']);
        Route::patch('/users/{id}/ban',   [AdminPropertyController::class, 'banUser']);
        Route::patch('/users/{id}/unban', [AdminPropertyController::class, 'unbanUser']);
        Route::delete('/properties/{id}', [AdminPropertyController::class, 'destroy']);

    });

// ─────────────────────────────────────────────
// ✅ FIX #2: حذفنا POST /owner/properties المكرر خارج الـ group
// Owner Routes (يحتاج auth + owner role)
// ─────────────────────────────────────────────
// Route::middleware('auth:sanctum')
// ->post('owner/properties',         [OwnerPropertyController::class, 'store']);

Route::prefix('owner')
    ->middleware(['auth:sanctum', EnsureOwner::class])
    ->group(function () {
        // عقارات المالك
        Route::get('/properties',          [OwnerPropertyController::class, 'index']);
        Route::post('/properties',       [OwnerPropertyController::class, 'store']);
        Route::get('/properties/{id}',     [OwnerPropertyController::class, 'show']);
        Route::put('/properties/{id}',     [OwnerPropertyController::class, 'update']);
        Route::post('/properties/{id}',     [OwnerPropertyController::class, 'update']);

        // Route::match(['put', 'post'], 'owner/properties/{id}', [OwnerPropertyController::class,'update']);
        Route::delete('/properties/{id}',  [OwnerPropertyController::class, 'destroy']);

        // صور العقارات
        Route::post('/properties/{propertyId}/images',                          [OwnerPropertyImageController::class, 'store']);
        Route::patch('/properties/{propertyId}/images/{imageId}/make-main',     [OwnerPropertyImageController::class, 'makeMain']);
        Route::delete('/properties/{propertyId}/images/{imageId}',              [OwnerPropertyImageController::class, 'destroy']);

        // طلبات التواصل
        Route::get('/contact-requests',               [ContactRequestController::class, 'ownerIndex']);
        Route::get('/contact-requests/unread-count',  [ContactRequestController::class, 'ownerUnreadCount']);

        // إشعارات المالك
        Route::get('/notifications/property-status',  [OwnerNotificationController::class, 'propertyStatus']);
         Route::get('/bookings', [BookingController::class, 'ownerIndex']);
        Route::patch('/bookings/{id}/accept', [BookingController::class, 'accept']);
        Route::patch('/bookings/{id}/reject', [BookingController::class, 'reject']);
        Route::patch('/bookings/{id}/remove', [BookingController::class, 'remove']);
    });

// ─────────────────────────────────────────────
// Tenant Routes (يحتاج auth)
// ─────────────────────────────────────────────
Route::get('/student/properties', [PropertyController::class, 'studentIndex']);
Route::middleware('auth:sanctum')->group(function () {
    // عقارات الطلاب (tenant type = student)

    // إرسال طلب تواصل (tenant فقط)
    Route::post('/contact-requests',  [ContactRequestController::class, 'store']);
});
Route::middleware('auth:sanctum')->group(function () {
    // المستأجر
    Route::post('/bookings', [BookingController::class, 'store']);
    Route::patch('/bookings/{id}/cancel', [BookingController::class, 'cancel']);

     // ✅ جديد
    Route::get('/tenant/bookings', [BookingController::class, 'tenantIndex']);
    Route::get('/tenant/contact-requests', [ContactRequestController::class, 'tenantIndex']);
    Route::post('/contact-requests/{id}/reply', [ContactRequestController::class, 'reply']);
});
