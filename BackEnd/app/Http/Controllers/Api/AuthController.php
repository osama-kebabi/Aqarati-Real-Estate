<?php
namespace App\Http\Controllers\Api;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validated = $request->validate([
            'name' => ['required','string','max:255'],
            'email' => ['required','email','max:255','unique:users,email'],
            'password' => ['required','string','min:6'],

            'phone' => ['nullable','string','max:30'],

            // 'role' => ['required', Rule::in(['tenant','owner'])],
            'tenant_type' => ['nullable', Rule::in(['normal','student'])],
            'university_id' => ['nullable','integer','exists:universities,id'],
        ]);

        // لتجنب خطأ "Undefined array key"
        $tenantType   = $validated['tenant_type'] ?? null;
        $universityId = $validated['university_id'] ?? null;
        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'phone' => $validated['phone'] ?? null,
            // 'role' => $validated['role'],
            'role' => 'tenant',
            'tenant_type' => $tenantType,
            'university_id' => $universityId,
        ]);

         $token = $user->createToken('api-token')->plainTextToken;

            return response()->json([
            'user' => $user,
            'token' => $token
            ], 201);
    }

    public function login(Request $request)
    {
        
        $validated = $request->validate([
            'email' => ['required','email'],
            'password' => ['required','string'],
        ]);
        $user = User::where('email', $validated['email'])->first();
        if (!$user || !Hash::check($validated['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid credentials'
            ], 401);
        }
        if ($user->is_banned) {
        return response()->json(['message' => 'حسابك محظور. تواصل مع الإدارة.'], 403);
        }
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
        'user' => $user,
        'token' => $token
        ]);
    }
    public function logout(Request $request)
    {
        $token = $request->user()?->currentAccessToken();
        if ($token) $token->delete();

        return response()->json(['message' => 'Logged out']);
    }
    public function me(Request $request)
    {
        return response()->json([
            'user' => $request->user()
        ]);
    }
    public function updateProfile(Request $request)
{
    $user = $request->user();

    $validated = $request->validate([
        'name'         => ['required', 'string', 'max:255'],
        'phone'        => ['nullable', 'string', 'max:30'],
        'email'        => ['required', 'email', 'max:255', 'unique:users,email,' . $user->id],
        'old_password' => ['nullable', 'string'],
        'new_password' => ['nullable', 'string', 'min:6'],
        'tenant_type'  => ['nullable', 'in:normal,student'],
    ], [
        'name.required'        => 'الاسم مطلوب',
        'email.required'       => 'البريد الإلكتروني مطلوب',
        'email.unique'         => 'البريد الإلكتروني مستخدم من حساب آخر',
        'new_password.min'     => 'كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل',
    ]);

    // التحقق من كلمة المرور القديمة إذا أراد تغييرها
    if (!empty($validated['new_password'])) {
        if (empty($validated['old_password'])) {
            return response()->json(['message' => 'أدخل كلمة المرور القديمة أولاً'], 422);
        }
        if (!Hash::check($validated['old_password'], $user->password)) {
            return response()->json(['message' => 'كلمة المرور القديمة غير صحيحة'], 422);
        }
    }

    $user->name  = $validated['name'];
    $user->email = $validated['email'];
    $user->phone = $validated['phone'] ?? $user->phone;

    if ($user->role === 'tenant' && isset($validated['tenant_type'])) {
        $user->tenant_type = $validated['tenant_type'];
    }

    if (!empty($validated['new_password'])) {
        $user->password = Hash::make($validated['new_password']);
    }

    $user->save();

    return response()->json([
        'message' => 'تم تحديث البيانات بنجاح',
        'user'    => $user
    ]);
}
}
