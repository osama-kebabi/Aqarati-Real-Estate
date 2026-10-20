
// ─────────────────────────────────────────────────────────
// تحميل الجامعات في form التسجيل
// ─────────────────────────────────────────────────────────
async function loadUniversitiesInPopup() {
    const select = document.getElementById('studentUniversity');
    if (!select) return;

    try {
        const res  = await fetch('http://localhost:8000/api/universities', {
            headers: { 'Accept': 'application/json' }
        });
        const data = await res.json();
        const unis = data.data || [];

        select.innerHTML = '<option value="">-- اختر جامعتك --</option>';
        unis.forEach(u => {
            const opt = document.createElement('option');
            opt.value       = u.id;
            opt.textContent = `${u.name} - ${u.city}`;
            select.appendChild(opt);
        });
    } catch (e) {
        console.warn('فشل تحميل الجامعات:', e);
    }
}

// ─────────────────────────────────────────────────────────
// Toggle: إظهار/إخفاء حقول حسب نوع المستخدم
// ─────────────────────────────────────────────────────────
function handleRoleChange() {
    const roleSelect   = document.getElementById('registerRole');
    const studentGroup = document.getElementById('studentGroup');
    const ownerGroup   = document.getElementById('ownerGroup');

    if (!roleSelect) return;

    const role = roleSelect.value;

    if (studentGroup) studentGroup.style.display = role === 'student' ? 'block' : 'none';
    if (ownerGroup)   ownerGroup.style.display   = role === 'owner'   ? 'block' : 'none';
}

// ─────────────────────────────────────────────────────────
// Login Handler
// ─────────────────────────────────────────────────────────
async function handleLogin(event) {
    event.preventDefault();

    const email    = document.getElementById('loginEmail')?.value?.trim();
    const password = document.getElementById('loginPassword')?.value;

    if (!email || !password) {
        showPopupError('loginError', 'يرجى إدخال البريد الإلكتروني وكلمة المرور');
        return;
    }

    const submitBtn  = event.target.querySelector('button[type="submit"]');
    const origText   = submitBtn?.textContent;
    if (submitBtn) { submitBtn.disabled = true; submitBtn.textContent = 'جاري تسجيل الدخول...'; }

    try {
        const data = await AuthManager.login(email, password);

        // تحديث شريط التنقل
        if (window.updateAuthStatus) updateAuthStatus();

        // توجيه حسب الدور
        // closeLoginPopup();
        // const role = data.user?.role;

        // if (role === 'admin') {
        //     window.location.href = 'admin.html';
        // } else if (role === 'owner') {
        //     window.location.href = 'pending-approval.html';
        // } else if (data.user?.tenant_type === 'student') {
        //     window.location.href = 'properties_university.html';
        // } else {
        //     window.location.href = 'properties.html';
        // }
        // ✅ الجديد
closeLoginPopup();
const role     = data.user?.role;
const redirect = localStorage.getItem('afterLoginRedirect');
localStorage.removeItem('afterLoginRedirect');

if (role === 'admin') {
    window.location.href = 'admin.html';
} else if (role === 'owner') {
    // المالك: روّحه للإضافة فقط إذا هو اللي ضغط "إضافة عقار"
    window.location.href = redirect === 'add-properties.html'
        ? 'add-properties.html'
        : 'pending-approval.html';
} else if (data.user?.tenant_type === 'student') {
    window.location.href = redirect || 'properties_university.html';
} else {
    window.location.href = redirect || 'properties.html';
}

    } catch (e) {
        showPopupError('loginError', e.message || 'بيانات الدخول غير صحيحة');
    } finally {
        if (submitBtn) { submitBtn.disabled = false; submitBtn.textContent = origText; }
    }
}

// ─────────────────────────────────────────────────────────
// Register Handler (✅ FIXED)
// ─────────────────────────────────────────────────────────
async function handleRegister(event) {
    event.preventDefault();

    const email    = document.getElementById('registerEmail')?.value?.trim();
    const name     = document.getElementById('registerName')?.value?.trim();
    const phone    = document.getElementById('registerPhone')?.value?.trim();
    const password = document.getElementById('registerPassword')?.value;

    if (!email || !name || !password) {
        showPopupError('registerError', 'يرجى ملء جميع الحقول المطلوبة');
        return;
    }
    if (password.length < 6) {
        showPopupError('registerError', 'كلمة المرور يجب أن تكون 6 أحرف على الأقل');
        return;
    }
    if (phone && !/^\d{10}$/.test(phone)) {                                          
        showPopupError('registerError', 'رقم الهاتف يجب أن يتكون من 10 أرقام بالضبط'); 
        return;                                                                      
    }                                                                                 

    // شيك بوكس "أنا طالب" فقط
    const isStudent   = document.getElementById('studentCheck')?.checked || false;
    const role        = 'tenant';
    const tenantType  = isStudent ? 'student' : 'normal';

    const userData = { name, email, password, phone, role, tenant_type: tenantType };

    const submitBtn = event.target.querySelector('button[type="submit"]');
    const origText  = submitBtn?.textContent;
    if (submitBtn) { submitBtn.disabled = true; submitBtn.textContent = 'جاري إنشاء الحساب...'; }

    try {
        const data = await AuthManager.register(userData);
        if (window.updateAuthStatus) updateAuthStatus();
        closeLoginPopup();
        alert(`✅ أهلاً بك ${data.user.name}!\nتم إنشاء حسابك بنجاح.`);

        if (isStudent) {
            window.location.href = 'properties_university.html';
        } else {
            window.location.href = 'properties.html';
        }

    } catch (e) {
        showPopupError('registerError', e.message || 'فشل إنشاء الحساب');
    } finally {
        if (submitBtn) { submitBtn.disabled = false; submitBtn.textContent = origText; }
    }
}
// ─────────────────────────────────────────────────────────
// Popup Controls
// ─────────────────────────────────────────────────────────
function openLoginPopup() {
    const popup = document.getElementById('loginPopup');
    if (popup) popup.classList.add('active');
}

function closeLoginPopup() {
    const popup = document.getElementById('loginPopup');
    if (popup) popup.classList.remove('active');
    clearPopupErrors();
}

function showLoginForm() {
    document.getElementById('loginForm').style.display   = 'block';
    document.getElementById('registerForm').style.display = 'none';
    clearPopupErrors();
}

function showRegisterForm() {
    document.getElementById('loginForm').style.display   = 'none';
    document.getElementById('registerForm').style.display = 'block';
    clearPopupErrors();
    loadUniversitiesInPopup();
}

function showPopupError(elementId, msg) {
    const el = document.getElementById(elementId);
    if (el) {
        el.textContent   = msg;
        el.style.display = 'block';
        el.style.color   = '#e53935';
        el.style.padding = '8px 12px';
        el.style.background = '#fdecea';
        el.style.borderRadius = '8px';
        el.style.marginBottom = '12px';
        el.style.fontSize = '0.9rem';
    }
}

function clearPopupErrors() {
    ['loginError', 'registerError'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.style.display = 'none';
    });
}

// ─────────────────────────────────────────────────────────
// Expose globals
// ─────────────────────────────────────────────────────────
window.handleLogin      = handleLogin;
window.handleRegister   = handleRegister;
window.openLoginPopup   = openLoginPopup;
window.closeLoginPopup  = closeLoginPopup;
window.showLoginForm    = showLoginForm;
window.showRegisterForm = showRegisterForm;
window.handleRoleChange = handleRoleChange;
