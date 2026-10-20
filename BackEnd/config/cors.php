<?php

// ✅ FIX #6: إضافة CORS configuration - بدونه الفرونت يُحجب كلياً
// ضع هذا الملف في: config/cors.php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    // ✅ غيّر هذا لـ origin الفرونت الحقيقي في الإنتاج
    'allowed_origins' => [
        'http://localhost:5500',     // VSCode Live Server
        'http://127.0.0.1:5500',
        'http://localhost:3000',     // إذا استخدمت React/Vite
        'http://localhost:8080',
        'null',                      // file:// protocol (فتح HTML مباشرة)
    ],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    // ✅ مهم جداً للـ Sanctum cookie-based auth
    // لكن مع token-based (الذي نستخدمه) يمكن تركه false
    'supports_credentials' => false,

];
