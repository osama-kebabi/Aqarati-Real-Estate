
 const API_BASE = 'http://localhost:8000/api';

// // ─────────────────────────────────────────────────────────────
// // Helper: طلب مصادق (مع Bearer Token)
// // ─────────────────────────────────────────────────────────────
async function apiFetch(endpoint, options = {}) {
    const token = localStorage.getItem('authToken');

    const headers = {
        'Accept': 'application/json',
        ...(token ? { 'Authorization': `Bearer ${token}` } : {}),
        ...options.headers,
    };

    // إذا الـ body مش FormData نضيف Content-Type
    if (options.body && !(options.body instanceof FormData)) {
        headers['Content-Type'] = 'application/json';
        if (typeof options.body === 'object') {
            options.body = JSON.stringify(options.body);
        }
    }

    const response = await fetch(`${API_BASE}${endpoint}`, {
        method: 'GET',
        ...options,
        headers,
    });

    if (!response.ok) {
        let errMsg = `HTTP ${response.status}`;
        try {
            const err = await response.json();
            errMsg = err.message || errMsg;
        } catch (_) {}
        throw new Error(errMsg);
    }

    return response.json();
}
// ─────────────────────────────────────────────────────────────
// Auth Helpers
// ─────────────────────────────────────────────────────────────
function getAuthToken()   { return localStorage.getItem('authToken'); }
// function isLoggedIn()     { return !!getAuthToken(); }
function getCurrentUser() {
    const u = localStorage.getItem('user');
    return u ? JSON.parse(u) : null;
}
function getUserRole() { return getCurrentUser()?.role || null; }

// ─────────────────────────────────────────────────────────────
// Universities API
// ─────────────────────────────────────────────────────────────
async function fetchUniversities() {
    const data = await apiFetch('/universities');
    return data.data || [];
}

// ─────────────────────────────────────────────────────────────
// Properties Public API
// ─────────────────────────────────────────────────────────────
 async function fetchProperties(filters = {}) {
    const params = new URLSearchParams();
    Object.entries(filters).forEach(([k, v]) => {
        if (v !== null && v !== undefined && v !== '') params.append(k, v);
    });
    const qs = params.toString();
    return apiFetch(`/properties${qs ? '?' + qs : ''}`);
}

async function fetchPropertyById(id) {
    return apiFetch(`/properties/${id}`);
}

async function fetchStudentProperties(filters = {}) {
    const params = new URLSearchParams();
    Object.entries(filters).forEach(([k, v]) => {
        if (v !== null && v !== undefined && v !== '') params.append(k, v);
    });
    const qs = params.toString();
    return apiFetch(`/student/properties${qs ? '?' + qs : ''}`);
}

// ─────────────────────────────────────────────────────────────
// Owner Properties API
// ─────────────────────────────────────────────────────────────
async function fetchOwnerProperties(page = 1) {
    return apiFetch(`/owner/properties?page=${page}`);
}

async function fetchOwnerPropertyById(id) {
    return apiFetch(`/owner/properties/${id}`);
}

async function createProperty(formData) {
    return apiFetch('/owner/properties', {
        method: 'POST',
        body: formData,
    });
}

async function updateProperty(id, formData) {
    formData.append('_method', 'PUT');
    return apiFetch(`/owner/properties/${id}`, {
        method: 'POST',
        body: formData,
    });
}

async function deleteProperty(id) {
    return apiFetch(`/owner/properties/${id}`, { method: 'DELETE' });
}

// ─────────────────────────────────────────────────────────────
// Owner Notifications API
// ─────────────────────────────────────────────────────────────
async function fetchOwnerNotifications() {
    return apiFetch('/owner/notifications/property-status');
}
 // ─────────────────────────────────────────────────────────────
// Owner Contact Requests API
// ─────────────────────────────────────────────────────────────
async function fetchOwnerContactRequests() {
    return apiFetch('/owner/contact-requests');
}

async function fetchOwnerUnreadCount() {
    const data = await apiFetch('/owner/contact-requests/unread-count');
    return data.count || 0;
}

// ─────────────────────────────────────────────────────────────
// Contact Request (Tenant)
// ─────────────────────────────────────────────────────────────
async function sendContactRequest(payload) {
    return apiFetch('/contact-requests', {
        method: 'POST',
        body: payload,
    });
}

// ─────────────────────────────────────────────────────────────
// Admin API
// ─────────────────────────────────────────────────────────────
async function fetchAdminProperties(status, page) {
    status = status || 'pending';
    page   = page   || 1;
    return apiFetch(`/admin/properties?status=${status}&page=${page}`);
}

async function fetchPendingCount() {
    const data = await apiFetch('/admin/properties/pending-count');
    return data.count || 0;
}

async function approveProperty(id) {
    return apiFetch(`/admin/properties/${id}/approve`, { method: 'PATCH' });
}

async function rejectProperty(id) {
    return apiFetch(`/admin/properties/${id}/reject`, { method: 'PATCH' });
}

// ─────────────────────────────────────────────────────────────
// UI Helpers
// ─────────────────────────────────────────────────────────────
function showLoading(containerId, msg) {
    msg = msg || 'جاري التحميل...';
    const el = document.getElementById(containerId);
    if (el) {
        el.innerHTML = '<div style="text-align:center;padding:40px;color:#888;">'
            + '<i class="fas fa-spinner fa-spin fa-2x"></i>'
            + '<p style="margin-top:12px;">' + msg + '</p>'
            + '</div>';
    }
}

function showError(containerId, msg) {
    msg = msg || 'حدث خطأ في التحميل';
    const el = document.getElementById(containerId);
    if (el) {
        el.innerHTML = '<div style="text-align:center;padding:40px;color:#e74c3c;">'
            + '<i class="fas fa-exclamation-triangle fa-2x"></i>'
            + '<p style="margin-top:12px;">' + msg + '</p>'
            + '<button onclick="location.reload()" style="margin-top:12px;padding:8px 20px;'
            // + 'background:#8B7FD2;color:#fff;border:none;border-radius:8px;cursor:pointer;">'
            // + 'إعادة المحاولة</button></div>';
    }
}

function formatPrice(price) {
    const num = parseFloat(price);
    if (isNaN(num)) return 'غير محدد';
    return num.toLocaleString('ar-SA');
}

function statusLabel(status) {
    var map = {
        'pending':  { text: 'قيد المراجعة', cls: 'status-pending',  icon: 'fa-clock' },
        'approved': { text: 'مقبول',         cls: 'status-approved', icon: 'fa-check-circle' },
        'rejected': { text: 'مرفوض',         cls: 'status-rejected', icon: 'fa-times-circle' },
    };
    return map[status] || { text: status, cls: '', icon: 'fa-question' };
}

function getImageUrl(path) {
    var placeholder = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg"'
        + ' width="300" height="200"><rect fill="%23f0f0f0" width="300" height="200"/>'
        + '<text fill="%23999" x="50%" y="50%" text-anchor="middle"'
        + ' dominant-baseline="middle" font-size="14">لا توجد صورة</text></svg>';
    if (!path) return placeholder;
    if (path.startsWith('http')) return path;
    return 'http://localhost:8000/storage/' + path;
}

// ─────────────────────────────────────────────────────────────
// Property Card Renderer
// ─────────────────────────────────────────────────────────────
function renderPropertyCard(p) {
    var images  = p.images || [];
    var mainImg = null;
    for (var i = 0; i < images.length; i++) {
        if (images[i].is_main) { mainImg = images[i]; break; }
    }
    if (!mainImg && images.length > 0) mainImg = images[0];

    var imgSrc = mainImg
        ? (mainImg.image_url || getImageUrl(mainImg.image_path))
        : getImageUrl(null);
var discountBadge = '';
    if (p.has_student_discount && p.student_discount_percentage) {
        discountBadge = '<span style="background:#4caf50;color:#fff;padding:2px 8px;'
            + 'border-radius:10px;font-size:0.75rem;">خصم ' + p.student_discount_percentage + '%</span>';
    }

    var studentBadge = '';
    if (p.is_student_friendly) {
        studentBadge = '<span style="background:#8B7FD2;color:#fff;padding:2px 8px;'
            + 'border-radius:10px;font-size:0.75rem;">طلابي</span>';
    }

    var rooms    = p.rooms_count   ||  p.bedrooms  ||    '-';
    // var bathrooms = p.bathrooms_count || p.bathrooms   || '-';
    var areaHtml = p.area
        ? '<span><i class="fas fa-ruler-combined"></i> ' + p.area + ' م²</span>'
        : '';

    return '<article class="property-card" style="background:#fff;border-radius:14px;'
        + 'overflow:hidden;box-shadow:0 2px 16px rgba(0,0,0,0.09);transition:transform .2s;">'
        + '<div style="position:relative;">'
        + '<img src="' + imgSrc + '" alt="' + p.title + '"'
        + ' style="width:100%;height:200px;object-fit:cover;"'
        + ' onerror="this.src=\'' + getImageUrl(null) + '\'">'
        + '<div style="position:absolute;top:10px;right:10px;display:flex;gap:6px;">'
        + studentBadge + discountBadge
        + '</div></div>'
        + '<div style="padding:16px;">'
        + '<h3 style="margin:0 0 6px;font-size:1rem;">' + p.title + '</h3>'
        + '<p style="margin:0 0 6px;color:#666;font-size:0.85rem;">'
        + '<i class="fas fa-map-marker-alt"></i> ' + p.city + ' - ' + (p.region || '') + '</p>'
        + '<p style="margin:0 0 12px;color:#8B7FD2;font-weight:700;font-size:1.05rem;">'
        + formatPrice(p.price)
        + ' <span style="font-weight:400;font-size:0.8rem;color:#999;">/ شهر</span></p>'
        + '<div style="display:flex;gap:12px;font-size:0.82rem;color:#888;margin-bottom:14px;">'
        + '<span><i class="fas fa-bed"></i> ' + rooms + ' غرف</span>'
        // + '<span><i class="fas fa-bath"></i> ' + bathrooms + ' حمام</span>'
        + areaHtml
        + '</div>'
        + '<a href="property-card.html?id=' + p.id + '"'
        + ' style="display:block;text-align:center;padding:8px;background:#8B7FD2;'
        + 'color:#fff;border-radius:8px;text-decoration:none;font-size:0.9rem;">'
        + 'عرض التفاصيل</a>'
        + '</div></article>';
}

// ─────────────────────────────────────────────────────────────
// Delete Handler
// ─────────────────────────────────────────────────────────────
async function handleDeleteProperty(id) {
    if (!confirm('هل أنت متأكد من حذف هذا العقار؟')) return;
    try {
        await deleteProperty(id);
        alert('تم حذف العقار بنجاح');
        location.reload();
    } catch (e) {
        alert('فشل الحذف: ' + e.message);
    }
}

// ─────────────────────────────────────────────────────────────
// Owner Property Card HTML
// ─────────────────────────────────────────────────────────────
function buildOwnerPropertyCard(p) {
    var s       = statusLabel(p.status);
    var images  = p.images || [];
    var mainImg = null;
    for (var i = 0; i < images.length; i++) {
        if (images[i].is_main) { mainImg = images[i]; break; }
    }
    if (!mainImg && images.length > 0) mainImg = images[0];
    var imgSrc = mainImg ? getImageUrl(mainImg.image_path) : getImageUrl(null);

    var bgColor    = p.status === 'approved' ? '#e8f5e9' : p.status === 'rejected' ? '#fdecea' : '#fff3e0';
    var textColor  = p.status === 'approved' ? '#2e7d32' : p.status === 'rejected' ? '#c62828' : '#e65100';

    return '<div style="background:#fff;border-radius:14px;overflow:hidden;'
        + 'box-shadow:0 2px 12px rgba(0,0,0,0.09);margin-bottom:20px;'
        + 'display:flex;flex-direction:row;">'
        + '<img src="' + imgSrc + '" alt="' + p.title + '"'
 + ' style="width:200px;height:160px;object-fit:cover;flex-shrink:0;"'
        + ' onerror="this.src=\'' + getImageUrl(null) + '\'">'
        + '<div style="padding:16px;flex:1;">'
        + '<div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:8px;">'
        + '<h3 style="margin:0;font-size:1.05rem;">' + p.title + '</h3>'
        + '<span style="padding:4px 12px;border-radius:20px;font-size:0.8rem;'
        + 'background:' + bgColor + ';color:' + textColor + ';">'
        + '<i class="fas ' + s.icon + '"></i> ' + s.text + '</span>'
        + '</div>'
        + '<p style="margin:0 0 8px;color:#666;font-size:0.9rem;">'
        + '<i class="fas fa-map-marker-alt"></i> ' + p.city + ' - ' + (p.region || '') + '</p>'
        + '<p style="margin:0 0 12px;color:#8B7FD2;font-weight:600;">'
        + formatPrice(p.price) + ' / شهر</p>'
        + '<div style="display:flex;gap:10px;">'
        + '<a href="add-properties.html?edit=' + p.id + '"'
        + ' style="padding:6px 16px;background:#8B7FD2;color:#fff;border-radius:8px;'
        + 'text-decoration:none;font-size:0.85rem;">'
        + '<i class="fas fa-edit"></i> تعديل</a>'
        + '<button onclick="handleDeleteProperty(' + p.id + ')"'
        + ' style="padding:6px 16px;background:#e53935;color:#fff;border:none;'
        + 'border-radius:8px;cursor:pointer;font-size:0.85rem;">'
        + '<i class="fas fa-trash"></i> حذف</button>'
        + '</div></div></div>';
}

// ─────────────────────────────────────────────────────────────
// PAGE INIT: pending-approval.html
// ─────────────────────────────────────────────────────────────
async function initPendingApprovalPage() {

    // لازم يكون مسجّل دخول
    if (!isLoggedIn()) {
        window.location.href = 'home.html';
        return;
    }

    var role = getUserRole();
    var propertiesContainer = document.getElementById('propertiesContainer')
        || document.getElementById('properties-list');
    var notifContainer = document.getElementById('notificationsContainer')
        || document.getElementById('notifications-list');
    var unreadBadge = document.getElementById('unreadBadge')
        || document.getElementById('unread-count');

    // ── إذا مش owner: اعرض زر إضافة عقار فقط ──────────────
    if (role !== 'owner') {
        if (propertiesContainer) {
            propertiesContainer.innerHTML =
                '<div style="text-align:center;padding:60px;color:#888;">'
                + '<i class="fas fa-home fa-3x" style="margin-bottom:16px;color:#8B7FD2;opacity:0.6;"></i>'
                + '<h3 style="color:#333;margin-bottom:12px;">مرحباً بك!</h3>'
                + '<p style="color:#666;margin-bottom:24px;">'
                + 'أضف عقارك الأول وسيتحول حسابك تلقائياً إلى مالك عقار</p>'
                + '<a href="add-properties.html"'
                + ' style="display:inline-block;padding:14px 32px;background:#8B7FD2;'
                + 'color:#fff;border-radius:10px;text-decoration:none;font-weight:600;">'
                + '<i class="fas fa-plus-circle"></i> إضافة عقار جديد</a>'
                + '</div>';
        }
        return;
    }

    // ── من هون للـ owner فقط ────────────────────────────────

    // 1) إشعارات
    try {
        var notifData = await fetchOwnerNotifications();
        if (notifContainer && notifData.count > 0) {
            var notifHtml = '';
            for (var i = 0; i < notifData.data.length; i++) {
                var item = notifData.data[i];
                var s    = statusLabel(item.status);
                var bg   = item.status === 'approved' ? '#e8f5e9' : '#fdecea';
                var br   = item.status === 'approved' ? '#4caf50' : '#e53935';
                var ic   = item.status === 'approved' ? '#4caf50' : '#e53935';
                notifHtml +=
 '<div style="padding:14px 18px;margin-bottom:10px;border-radius:10px;'
                    + 'background:' + bg + ';border-right:4px solid ' + br + ';'
                    + 'display:flex;align-items:center;gap:12px;">'
                    + '<i class="fas ' + s.icon + '" style="font-size:1.3rem;color:' + ic + ';"></i>'
                    + '<div><strong>' + item.title + '</strong>'
                    + '<span style="font-size:0.85rem;color:#666;margin-right:8px;">' + s.text + '</span>'
                    + '</div></div>';
            }
            notifContainer.innerHTML = notifHtml;
        } else if (notifContainer) {
            notifContainer.innerHTML =
                '<p style="color:#888;text-align:center;padding:20px;">لا توجد إشعارات جديدة</p>';
        }
    } catch (e) {
        if (notifContainer) {
            notifContainer.innerHTML = '<p style="color:#e74c3c;">فشل تحميل الإشعارات</p>';
        }
    }

    // 2) عدد الرسائل غير المقروءة
    try {
        var count = await fetchOwnerUnreadCount();
        if (unreadBadge) {
            unreadBadge.textContent  = count;
            unreadBadge.style.display = count > 0 ? 'inline-block' : 'none';
        }
    } catch (_) {}

    // 3) عقارات المالك
    if (!propertiesContainer) return;

    showLoading('propertiesContainer', 'جاري تحميل عقاراتك...');

    try {
        var data       = await fetchOwnerProperties();
        var properties = data.data || [];

        if (properties.length === 0) {
            propertiesContainer.innerHTML =
                '<div style="text-align:center;padding:60px;color:#888;">'
                + '<i class="fas fa-home fa-3x" style="margin-bottom:16px;opacity:0.4;"></i>'
                + '<h3>لم تضف أي عقارات بعد</h3>'
                + '<a href="add-properties.html"'
                + ' style="display:inline-block;margin-top:16px;padding:10px 24px;'
                + 'background:#8B7FD2;color:#fff;border-radius:8px;text-decoration:none;">'
                + 'أضف عقارك الأول</a></div>';
            return;
        }

        var html = '';
        for (var j = 0; j < properties.length; j++) {
            html += buildOwnerPropertyCard(properties[j]);
        }
        propertiesContainer.innerHTML = html;

    } catch (e) {
        showError('propertiesContainer', 'فشل تحميل العقارات: ' + e.message);
    }
}

// ─────────────────────────────────────────────────────────────
// PAGE INIT: properties_university.html
// ─────────────────────────────────────────────────────────────
async function initUniversityPropertiesPage() {
    var grid      = document.getElementById('propertiesGrid');
    var loadingEl = document.getElementById('loadingState');
    var emptyEl   = document.getElementById('emptyState');

    function showGrid()  { if (grid)      grid.style.display      = 'grid'; }
    function hideGrid()  { if (grid)      grid.style.display      = 'none'; }
    function showLoader(){ if (loadingEl) loadingEl.style.display = 'flex'; }
    function hideLoader(){ if (loadingEl) loadingEl.style.display = 'none'; }
    function showEmpty() { if (emptyEl)   emptyEl.style.display   = 'block'; }
    function hideEmpty() { if (emptyEl)   emptyEl.style.display   = 'none'; }

    async function loadProperties() {
        var qEl      = document.getElementById('q');
        var cityEl   = document.getElementById('city');
        var regionEl = document.getElementById('region');
        var typeEl   = document.getElementById('type');
        var roomsEl  = document.getElementById('rooms');
        var minEl    = document.getElementById('min_price');
        var maxEl    = document.getElementById('max_price');

        var filters = {
            q:             qEl      ? qEl.value.trim()  : '',
            city:          cityEl   ? cityEl.value       : '',
 region:        regionEl ? regionEl.value     : '',
            property_type: typeEl   ? typeEl.value       : '',
            rooms_count:   roomsEl  ? roomsEl.value      : '',
            min_price:     minEl    ? minEl.value        : '',
            max_price:     maxEl    ? maxEl.value        : '',
        };

        hideGrid(); showLoader(); hideEmpty();

        try {
            var data;
            var user = getCurrentUser();

            if (isLoggedIn() && user && user.tenant_type === 'student') {
                data = await fetchStudentProperties(filters);
            } else {
                filters.is_student_friendly = 1;
                data = await fetchProperties(filters);
            }

            hideLoader();
            var properties = data.data || [];

            if (!grid) return;

            if (properties.length === 0) {
                hideGrid();
                showEmpty();
                return;
            }

            showGrid();
            var html = '';
            for (var i = 0; i < properties.length; i++) {
                html += renderPropertyCard(properties[i]);
            }
            grid.innerHTML = html;

        } catch (e) {
            hideLoader();
            if (grid) {
                showGrid();
                grid.innerHTML =
                    '<div style="grid-column:1/-1;text-align:center;padding:40px;color:#e74c3c;">'
                    + '<i class="fas fa-exclamation-triangle fa-2x"></i>'
                    + '<p style="margin-top:12px;">فشل تحميل العقارات: ' + e.message + '</p>'
                    + '</div>';
            }
        }
    }

    // ربط الفلاتر
    var filterIds = ['q', 'city', 'region', 'type', 'rooms', 'min_price', 'max_price'];
    for (var i = 0; i < filterIds.length; i++) {
        (function(id) {
            var el = document.getElementById(id);
            if (!el) return;
            el.addEventListener('change', loadProperties);
            if (id === 'q') {
                el.addEventListener('input', debounce(loadProperties, 500));
            }
        })(filterIds[i]);
    }

    var searchBtn = document.getElementById('searchBtn');
    var resetBtn  = document.getElementById('resetBtn');

    if (searchBtn) searchBtn.addEventListener('click', loadProperties);

    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            for (var j = 0; j < filterIds.length; j++) {
                var el = document.getElementById(filterIds[j]);
                if (el) el.value = '';
            }
            loadProperties();
        });
    }

    await loadProperties();
}

// ─────────────────────────────────────────────────────────────
// Utility
// ─────────────────────────────────────────────────────────────
function debounce(fn, wait) {
    var t;
    return function() {
        var args = arguments;
        clearTimeout(t);
        t = setTimeout(function() { fn.apply(null, args); }, wait);
    };
}

// ─────────────────────────────────────────────────────────────
// Auto-init
// ─────────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function() {
     if (window.__pageHandled) return;
    var page = window.location.pathname.split('/').pop();

    if (page === 'pending-approval.html') {
        initPendingApprovalPage();
    }
    // if (page === 'properties_university.html') {
    //     initUniversityPropertiesPage();
    // }
});

// Expose
window.EskanAPI = {
    apiFetch, fetchProperties, fetchPropertyById, fetchStudentProperties,
    fetchOwnerProperties, createProperty, updateProperty, deleteProperty,
    fetchOwnerNotifications, fetchOwnerContactRequests, fetchOwnerUnreadCount,
    fetchAdminProperties, fetchPendingCount, approveProperty, rejectProperty,
    fetchUniversities, sendContactRequest,
    isLoggedIn, getCurrentUser, getUserRole,
    formatPrice, statusLabel, getImageUrl, renderPropertyCard,
    handleDeleteProperty,
};

window.handleDeleteProperty = handleDeleteProperty;