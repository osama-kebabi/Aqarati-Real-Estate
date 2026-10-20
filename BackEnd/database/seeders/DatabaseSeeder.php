<?php

// namespace Database\Seeders;

// use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
// use Illuminate\Database\Seeder;

// class DatabaseSeeder extends Seeder
// {
//     use WithoutModelEvents;

//     /**
//      * Seed the application's database.
//      */
//     public function run(): void
//     {
//         // User::factory(10)->create();

//         User::factory()->create([
//             'name' => 'Test User',
//             'email' => 'test@example.com',
//         ]);
//     }
// }

// ✅ FIX #8: Seeders للأدمن والجامعات
// ضع هذا الملف في: database/seeders/DatabaseSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\University;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // ── Admin User ──────────────────────────────────────
        User::updateOrCreate(
            ['email' => 'admin@eskan.com'],
            [
                'name'     => 'مدير النظام',
                'password' => Hash::make('Admin@123456'),
                'phone'    => '0500000000',
                'role'     => 'admin',
            ]
        );

        // ── Universities ─────────────────────────────────────
        $universities = [
            ['name' => 'جامعة الملك عبدالعزيز',        'city' => 'جدة'],
            ['name' => 'جامعة الملك سعود',              'city' => 'الرياض'],
            ['name' => 'جامعة الملك فهد للبترول والمعادن', 'city' => 'الظهران'],
            ['name' => 'جامعة أم القرى',                'city' => 'مكة المكرمة'],
            ['name' => 'جامعة الملك عبدالله',            'city' => 'ثول'],
            ['name' => 'جامعة الملك خالد',              'city' => 'أبها'],
            ['name' => 'جامعة القصيم',                  'city' => 'بريدة'],
            ['name' => 'جامعة الطائف',                  'city' => 'الطائف'],
            ['name' => 'جامعة حائل',                    'city' => 'حائل'],
            ['name' => 'جامعة تبوك',                    'city' => 'تبوك'],
            ['name' => 'جامعة الجوف',                   'city' => 'سكاكا'],
            ['name' => 'جامعة نجران',                   'city' => 'نجران'],
            ['name' => 'جامعة الباحة',                  'city' => 'الباحة'],
            ['name' => 'جامعة جازان',                   'city' => 'جازان'],
            ['name' => 'جامعة الأمير سطام بن عبدالعزيز','city' => 'الخرج'],
            ['name' => 'جامعة شقراء',                   'city' => 'شقراء'],
            ['name' => 'جامعة المجمعة',                 'city' => 'المجمعة'],
            ['name' => 'جامعة بيشة',                    'city' => 'بيشة'],
            ['name' => 'جامعة الأمير مقرن',             'city' => 'المدينة المنورة'],
            ['name' => 'جامعة الإمام عبدالرحمن بن فيصل','city' => 'الدمام'],
        ];

        foreach ($universities as $uni) {
            University::firstOrCreate(['name' => $uni['name']], $uni);
        }

        $this->command->info('✅ تم إنشاء الأدمن والجامعات بنجاح');
        $this->command->info('   Admin Email: admin@eskan.com');
        $this->command->info('   Admin Pass:  Admin@123456');
    }
}
