// js/auth-guard.js
const BASE_URL = 'http://127.0.0.1:8000/api'; 

async function checkAuthAndPopulateProfile() {
    const token = localStorage.getItem('token');
    const profileChip = document.querySelector('.profile-chip'); // تأكد أن الكلاس مطابقت لـ HTML لديك
    
    // تحديد إذا كانت الصفحة الحالية تتطلب تسجيل دخول إجباري
    const protectedPages = ['pending-approval.html', 'add-properties.html'];
    const currentPage = window.location.pathname.split('/').pop();

    if (!token) {
        // 1. حالة المستخدم غير مسجل (زائر)
        if (protectedPages.includes(currentPage)) {
            // إذا كانت الصفحة محمية، وجهه فوراً لتسجيل الدخول
            window.location.href = 'login.html';
            return;
        }
        
        // إذا كانت صفحة عامة (كالرئيسية)، اظهر وضع الزائر في الـ profile-chip
        if (profileChip) {
            profileChip.innerHTML = 
                <a href="login.html" style="text-decoration:none; color:inherit;">
                    <i class="fas fa-user-circle"></i> <span>تسجيل الدخول (زائر)</span>
                </a>;
        }
        return;
    }

    // 2. حالة وجود توكن (نحتاج للتأكد من صحته وجلب الاسم الحقيقي من الباك)
    try {
        const response = await fetch(`${BASE_URL}/auth/me`, {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Accept': 'application/json'
            }
        });

        if (response.ok) {
            const userData = await response.json(); // الباك إند يعيد كائن يحتوي على name و role
            
            // حفظ بيانات المستخدم مؤقتاً للاستفادة منها في الصفحات الأخرى
            localStorage.setItem('user_role', userData.role);
            localStorage.setItem('user_name', userData.name);

            // تحديث الـ profile-chip باسم المستخدم الحقيقي ديناميكياً
            if (profileChip) {
                profileChip.innerHTML = 
                    <div class="user-logged-in" style="display:flex; align-items:center; gap:8px;">
                        <i class="fas fa-user-check" style="color: #28a745;"></i>
                        <span>${userData.name}</span>
                        <button id="logoutBtn" style="background:none; border:none; color:red; cursor:pointer; font-size:12px; margin-right:10px;">خروج</button>
                    </div>;
                
                // تفعيل زر تسجيل الخروج
                document.getElementById('logoutBtn')?.addEventListener('click', () => {
                    localStorage.clear();
                    window.location.href = 'login.html';
                });
            }
        } else {
            // الـ Token منتهي الصلاحية أو غير صالح
            throw new Error('Token invalid');
        }

    } catch (error) {
        console.error('Auth Error:', error);
        localStorage.clear();
        if (protectedPages.includes(currentPage)) {
            window.location.href = 'login.html';
        }
    }
}

// تشغيل الفحص تلقائياً عند تحميل الصفحة
document.addEventListener('DOMContentLoaded', checkAuthAndPopulateProfile);