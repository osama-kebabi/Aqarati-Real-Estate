
const ADD_PROP_API = 'http://localhost:8000/api';
// ─────────────────────────────────────────────────────
// تحميل قائمة الجامعات
// ─────────────────────────────────────────────────────
async function loadUniversitiesForForm() {
    const select = document.getElementById('university_id') ||
                   document.getElementById('university');
    if (!select) return;

    try {
        const res  = await fetch(`${ADD_PROP_API}/universities`, {
            headers: { 'Accept': 'application/json' }
        });
        const data = await res.json();
        const unis = data.data || [];

        // احتفظ بالخيار الأول (اختر جامعة...)
        const placeholder = select.querySelector('option[value=""]') ||
                            select.querySelector('option:first-child');

        select.innerHTML = '';
        if (placeholder) select.appendChild(placeholder);

        unis.forEach(u => {
            const opt = document.createElement('option');
            opt.value       = u.id;          // ← رقم الجامعة (مش الاسم!)
            opt.textContent = `${u.name} - ${u.city}`;
            select.appendChild(opt);
        });
    } catch (e) {
        console.warn('فشل تحميل الجامعات:', e.message);
    }
}

// ─────────────────────────────────────────────────────
// التحقق من تسجيل الدخول كـ owner
// ─────────────────────────────────────────────────────
const ADD_PROP_API = 'http://localhost:8000/api';
function checkOwnerAuth() {
    const token = localStorage.getItem('authToken');
    const user  = JSON.parse(localStorage.getItem('user') || 'null');

    if (!token || !user) {
        alert('يجب تسجيل الدخول أولاً لإضافة عقار');
        if (window.openLoginPopup) openLoginPopup();
        return false;
    }
}

// ─────────────────────────────────────────────────────
// قراءة الحقول وبناء FormData صحيح
// ─────────────────────────────────────────────────────
const ADD_PROP_API = 'http://localhost:8000/api';
function buildPropertyFormData(form) {
    const fd = new FormData();

    // ── دالة مساعدة ──
    const get = (name, fallbackId = null) => {
        const el = form.querySelector(`[name="${name}"]`) ||
                   (fallbackId ? document.getElementById(fallbackId) : null);
        return el ? el.value.trim() : '';
    };

    const getChecked = (name) => {
        const el = form.querySelector(`[name="${name}"]`);
        return el ? (el.type === 'checkbox' ? (el.checked ? '1' : '0') : el.value) : '0';
    };

    // ── الحقول المطلوبة ──────────────────────────────
    // title
    fd.append('title', get('title') || document.getElementById('property-title')?.value || '');
    const propType = get('property_type') || get('type') ||
     document.getElementById('property-type')?.value || '';
    fd.append('property_type', propType);

    // description
    fd.append('description', get('description') || '');

    // city
    fd.append('city', get('city') || '');

    const region = get('region') || get('city') || '';
    fd.append('region', region);

    // address
    fd.append('address', get('address') || '');

    // district
    const district = get('district') || '';
    if (district) fd.append('district', district);

    // price
    fd.append('price', get('price') || document.getElementById('property-price')?.value || '');

    // area
    const area = get('area') || document.getElementById('property-area')?.value || '';
    if (area) fd.append('area', area);

    const rooms = get('rooms_count') || get('bedrooms') ||
                  document.getElementById('rooms')?.value || '1';
    fd.append('rooms_count', rooms);

    // latitude / longitude
    const lat = get('latitude'); if (lat) fd.append('latitude', lat);
    const lng = get('longitude'); if (lng) fd.append('longitude', lng);

    // university_id
    const uniId = get('university_id') || get('university') ||
                  document.getElementById('university')?.value || '';
    if (uniId && !isNaN(uniId)) fd.append('university_id', uniId);

    // ── Boolean fields ─────────
    // is_available
    const isAvail = form.querySelector('[name="is_available"]');
    fd.append('is_available', isAvail ? (isAvail.checked ? '1' : '0') : '1');

    // is_student_friendly
    const studentFriendly = form.querySelector('[name="is_student_friendly"]') ||
                            form.querySelector('#is_student_friendly');
    const isStudentFriendly = studentFriendly
        ? (studentFriendly.type === 'checkbox' ? (studentFriendly.checked ? '1' : '0') : studentFriendly.value)
        : (uniId ? '1' : '0');
    fd.append('is_student_friendly', isStudentFriendly);

    // has_student_discount
    const discountCheckbox = form.querySelector('[name="has_student_discount"]');
    const hasDiscount = discountCheckbox ? (discountCheckbox.checked ? '1' : '0') : '0';
    fd.append('has_student_discount', hasDiscount);

    // student_discount_percentage
    if (hasDiscount === '1') {
        const pct = get('student_discount_percentage');
        if (pct) fd.append('student_discount_percentage', pct);
    }

    return fd;
}

// ─────────────────────────────────────────────────────
// رفع الصور
// ─────────────────────────────────────────────────────
const ADD_PROP_API = 'http://localhost:8000/api';
function appendImagesToFormData(fd, fileInput) {
    if (!fileInput || !fileInput.files) return;
    Array.from(fileInput.files).forEach(file => {
        fd.append('images[]', file);
    });
}

// ─────────────────────────────────────────────────────
// Submit Handler الحقيقي
// ─────────────────────────────────────────────────────
const ADD_PROP_API = 'http://localhost:8000/api';
async function submitPropertyToAPI(event) {
    event.preventDefault();

    // ✅ التحقق من Auth
    if (!checkOwnerAuth()) return;

    const form      = event.target.closest('form') || document.getElementById('property-form');
    const submitBtn = form?.querySelector('[type="submit"], .btn-submit, .btn-preview');
    const token     = localStorage.getItem('authToken');

    if (submitBtn) {
        submitBtn.disabled   = true;
        submitBtn.innerHTML  = '<i class="fas fa-spinner fa-spin"></i> جاري الإرسال...';
    }

    try {
        // بناء FormData مع التصحيحات
        const fd = buildPropertyFormData(form);

        // إضافة الصور
        const fileInput = document.getElementById('property-images') ||
                          form.querySelector('input[type="file"]');
        appendImagesToFormData(fd, fileInput);

        // الإرسال للـ API
        const response = await fetch(`${ADD_PROP_API}/owner/properties`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Accept':        'application/json',
            },
            body: fd,
        });

        const data = await response.json();

        if (!response.ok) {
            // عرض أخطاء الـ validation
            if (response.status === 422 && data.errors) {
                const msgs = Object.values(data.errors).flat().join('\n');
                throw new Error('أخطاء في البيانات:\n' + msgs);
            }
            throw new Error(data.message || `HTTP ${response.status}`);
        }
        const savedUser = JSON.parse(localStorage.getItem('user') || 'null');
if (savedUser && savedUser.role !== 'owner') {
    savedUser.role = 'owner';
    localStorage.setItem('user', JSON.stringify(savedUser));
}

        // ✅ نجح الإرسال
        alert('✅ تم إرسال عقارك بنجاح!\nسيتم مراجعته من قِبل الإدارة وإشعارك بالنتيجة.');
        form.reset();

        // إعادة التوجيه
        setTimeout(() => {
            window.location.href = 'pending-approval.html';
        }, 1000);

    } catch (e) {
        console.error('خطأ في إرسال العقار:', e);
        alert('❌ ' + e.message);

    } finally {
        if (submitBtn) {
            submitBtn.disabled  = false;
            submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> إرسال العقار';
        }
    }
    const savedUser = JSON.parse(localStorage.getItem('user') || 'null');
    if(savedUser && savedUser.role !== 'owner'){
        savedUser.role= 'owner';
        localStorage.setItem('user',JSON.stringify(savedUser));
    }
}

// ─────────────────────────────────────────────────────
// ربط الـ Submit Button
// ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
    // تحميل الجامعات في الـ form
    await loadUniversitiesForForm();

    // ربط زر الإرسال الحقيقي
    const form = document.getElementById('property-form');
    if (form) {
        // استبدل أي submit handler قديم
        const submitBtn = form.querySelector('[type="submit"], .btn-submit');
        if (submitBtn) {
            // إذا كان الزر "معاينة" سابقاً، نضيف submit حقيقي
            const realSubmitBtn = document.createElement('button');
            realSubmitBtn.type      = 'button';
            realSubmitBtn.className = 'btn-submit';
            realSubmitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> إرسال العقار للمراجعة';
            realSubmitBtn.style.cssText = `
                background: #8B7FD2; color: #fff; padding: 14px 32px;
                border: none; border-radius: 10px; font-size: 1rem;
                cursor: pointer; width: 100%; margin-top: 16px;
                display: flex; align-items: center; justify-content: center; gap: 8px;`;
            realSubmitBtn.onclick = submitPropertyToAPI;

            // أضفه بعد زر المعاينة
            submitBtn.parentElement.appendChild(realSubmitBtn);
        } else {
            form.addEventListener('submit', submitPropertyToAPI);
        }
    }

    // تحقق من تسجيل الدخول عند فتح الصفحة
    const token = localStorage.getItem('authToken');
    const user  = JSON.parse(localStorage.getItem('user') || 'null');

    if (!token || !user) {
        const formArea = document.querySelector('.form-container, .add-property-form, form');
        if (formArea) {
            const notice = document.createElement('div');
            notice.style.cssText = `
                background:#fff3cd; border:1px solid #ffc107; border-radius:10px;
                padding:16px; margin-bottom:20px; text-align:center;`;
            notice.innerHTML = `
                <i class="fas fa-exclamation-triangle" style="color:#ffc107;margin-left:8px;"></i>
                يجب <a href="#" onclick="openLoginPopup()" style="color:#8B7FD2;">تسجيل الدخول</a> كمالك لإرسال العقار.`;
            formArea.prepend(notice);
        }
    }
});

window.submitPropertyToAPI = submitPropertyToAPI;
