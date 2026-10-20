<?php

// use Illuminate\Foundation\Application;
// use Illuminate\Foundation\Configuration\Exceptions;
// use Illuminate\Foundation\Configuration\Middleware;

// return Application::configure(basePath: dirname(__DIR__))
//    ->withRouting(
//     web: __DIR__.'/../routes/web.php',
//     api: __DIR__.'/../routes/api.php',
//     commands: __DIR__.'/../routes/console.php',
//     health: '/up',
// )
//     ->withMiddleware(function (Middleware $middleware): void {
//         //
//     })
//     ->withExceptions(function (Exceptions $exceptions): void {
//         //
//     })->create();




// ✅ FIX #9: تسجيل الـ Middleware في Laravel 11
// ضع هذا الملف في: bootstrap/app.php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        // ✅ تسجيل الـ Middleware الخاصة
        $middleware->alias([
            'ensure.admin' => \App\Http\Middleware\EnsureAdmin::class,
            'ensure.owner' => \App\Http\Middleware\EnsureOwner::class,
        ]);

        // ✅ تفعيل CORS لكل طلبات API
        $middleware->api(prepend: [
            \Illuminate\Http\Middleware\HandleCors::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();



    