<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة تحكم الإدارة - موقع العقارات</title>
    <link rel="stylesheet" href="../eskan4/style/admin-dash.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/site.css">
    <style>
        /* ── إصلاح السكرول الطويل ── */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .admin-container {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            height: 100vh;
            overflow-y: auto;
            flex-shrink: 0;
        }
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
            min-width: 0;
        }
        .topbar {
            flex-shrink: 0;
        }
        .content-area {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
        }
        .section-panel {
            display: none;
        }
        .section-panel.active {
            display: block;
        }

        /* ── إصلاح الريسبونس ── */
        .table-responsive-wrapper {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .admin-table {
            width: 100%;
            min-width: 500px;
            border-collapse: collapse;
        }

        /* ── إصلاح بوب‌أب العقار ── */
        #propertyDetailOverlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            z-index: 99999;
            align-items: center;
            justify-content: center;
            padding: 16px;
            box-sizing: border-box;
        }
        #propertyDetailOverlay.open {
            display: flex !important;
        }
        .property-detail-box {
            background: #fff;
            border-radius: 16px;
            width: 100%;
            max-width: 600px;
            max-height: 85vh;
            overflow-y: auto;
            padding: 30px;
            position: relative;
            box-sizing: border-box;
        }

        /* ── صورة العقار في البوب‌أب ── */
        .prop-detail-img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 16px;
            display: block;
            background: #f0f0f0;
        }
        .prop-detail-img-placeholder {
            width: 100%;
            height: 180px;
            background: #f5f5f5;
            border-radius: 10px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #bbb;
            font-size: 2rem;
        }
        /* صور متعددة thumbnail strip */
        .prop-img-strip {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }
        .prop-img-strip img {
            width: 80px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: border-color .2s;
        }
        .prop-img-strip img.active-thumb {
            border-color: #8B7FD2;
        }

        /* ── ريسبونس موبايل ── */
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                right: -260px;
                top: 0;
                width: 240px;
                z-index: 1000;
                transition: right .3s;
            }
            .sidebar.active {
                right: 0;
            }
            .topbar-actions .profile-chip span,
            .topbar-actions .profile-chip small {
                display: none;
            }
            .grid-cards {
                grid-template-columns: 1fr !important;
            }
        }
        #propertyDetailContent .property-features {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-bottom: 25px;
    padding: 20px;
    background: #f8f9ff;
    border-radius: 15px;
}
#propertyDetailContent .feature-item {
    display: flex;
    align-items: center;
    gap: 10px;
}
#propertyDetailContent .feature-item i {
    width: 35px;
    height: 35px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
}
#propertyDetailContent .feature-item span {
    color: #555;
    font-size: 0.9rem;
}
#propertyDetailContent .amenities-section {
    margin-bottom: 25px;
}
#propertyDetailContent .amenities-section h4,
#propertyDetailContent .contact-section h4 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.1rem;
}
#propertyDetailContent .amenities-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}
#propertyDetailContent .amenity-tag {
    background: #f0f2ff;
    color: #667eea;
    padding: 8px 15px;
    border-radius: 25px;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    gap: 8px;
}
#propertyDetailContent .amenity-tag i {
    color: #27ae60;
}
#propertyDetailContent .contact-section {
    background: #f8f9ff;
    padding: 20px;
    border-radius: 15px;
    margin-bottom: 10px;
    margin-top: 14px;
}
#propertyDetailContent .contact-info {
    display: flex;
    flex-direction: column;
    gap: 12px;
}
#propertyDetailContent .contact-item {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #555;
}
#propertyDetailContent .contact-item i {
    width: 35px;
    height: 35px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}
    </style>
</head>
<body>
<div class="admin-container">

    <!-- القائمة الجانبية -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h3>لوحة الإدارة</h3>
            <p class="sidebar-description">تابع الموقع بسهولة.</p>
        </div>
        <nav class="sidebar-nav">
            <a href="../eskan4/home.html" class="return-site-btn" title="العودة للموقع"><i class="fas fa-arrow-right"></i> العودة للموقع</a>
            <a href="#" class="active" data-section="dashboard"><i class="fas fa-tachometer-alt"></i> لوحة التحكم</a>
            <a href="#" data-section="users"><i class="fas fa-users"></i> المستخدمين</a>
            <a href="#" data-section="properties"><i class="fas fa-building"></i> العقارات</a>
            <a href="#" data-section="messages"><i class="fas fa-envelope"></i> طلبات مراسلة</a>
        </nav>
        <div class="sidebar-footer">
            <p style="color:#ccc;font-size:12px;text-align:center;">إسكان 2026 &copy;</p>
        </div>
    </aside>

    <!-- المحتوى الرئيسي -->
    <main class="main-content">
        <header class="topbar">
            <div class="hamburger" id="adminHamburger">
                <span></span><span></span><span></span>
            </div>
            <h1>لوحة المشرف</h1>
            <div class="topbar-actions">
                <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> تسجيل الخروج</button>
                <div class="profile-chip">
                    <img id="adminAvatar" src="https://ui-avatars.com/api/?name=Admin&background=8B7FD2&color=fff" alt="avatar">
                    <div class="profile-text">
                        <span id="adminName">مشرف النظام</span>
                        <small>الإدارة العامة</small>
                    </div>
                </div>
            </div>
        </header>

        <section class="content-area">

            <!-- لوحة التحكم الرئيسية -->
            <section class="section-panel active" id="dashboard">
                <div class="grid-cards">
                    <div class="card-panel pointer-card" id="cardActiveProps" style="cursor:pointer;">
                        <div><h2>العقارات المفعلة</h2><p>عدد العقارات المنشورة حالياً</p></div>
                        <span class="stat-value" id="statActive">0</span>
                    </div>
                    <div class="card-panel pointer-card" id="cardPendingProps" style="cursor:pointer;">
                        <div><h2>بانتظار الموافقة</h2><p>العقارات التي تحتاج تحركك</p></div>
                        <span class="stat-value" id="statPending">0</span>
                    </div>
                    <div class="card-panel pointer-card" id="cardMessages" style="cursor:pointer;">
                        <div><h2>طلبات المراسلة</h2><p>الرسائل والاستفسارات الحالية</p></div>
                        <span class="stat-value" id="statMessages">0</span>
                    </div>
                </div>
            </section>

            <!-- قسم المستخدمين -->
            <section class="section-panel" id="users">
                <div class="table-panel">
                    <h3>إدارة المستخدمين</h3>
                    <div class="table-responsive-wrapper">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>رقم المستخدم (ID)</th>
                                    <th>اسم المستخدم</th>
                                    <th>البريد الإلكتروني</th>
                                    <th>رقم الهاتف</th>
                                    <th>الدور</th>
                                    <th>الإجراءات</th>
                                </tr>
                            </thead>
                            <tbody id="usersTableBody">
                                <tr><td colspan="6" style="text-align:center;padding:20px;color:#777;">جاري التحميل...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- قسم العقارات -->
            <section class="section-panel" id="properties">
                <div class="table-panel">
                    <h3>مراجعة العقارات</h3>
                    <div class="table-responsive-wrapper">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>العقار</th>
                                    <th>المالك</th>
                                    <th>السعر</th>
                                    <th>الحالة</th>
                                    <th>الإجراءات</th>
                                </tr>
                            </thead>
                            <tbody id="propertiesTableBody">
                                <tr><td colspan="5" style="text-align:center;padding:20px;color:#777;">جاري التحميل...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- قسم طلبات المراسلة -->
            <section class="section-panel" id="messages">
                <div class="table-panel">
                    <h3>طلبات المراسلة والاستفسارات</h3>
                    <p style="margin-bottom:15px;color:#777;">اسحب الجدول يميناً أو يساراً للتصفح الكامل من الموبايل.</p>
                    <div class="table-responsive-wrapper">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>العقار</th>
                                    <th>مالك العقار</th>
                                    <th>رقم المالك</th>
                                    <th>تاريخ الطلب</th>
                                    <th>حساب الزبون</th>
                                    <th>رقم الزبون</th>
                                    <th>الرسالة</th>
                                    <th>الاجراءات</th>
                                </tr>
                            </thead>
                            <tbody id="contactRequestsBody">
                                <tr><td colspan="7" style="text-align:center;padding:20px;color:#777;">جاري التحميل...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

        </section>
    </main>
</div>

<!-- بوب آب تفاصيل العقار -->
<div id="propertyDetailOverlay">
    <div class="property-detail-box">
        <button onclick="closePropertyDetail()" style="position:absolute;top:15px;left:15px;background:none;border:none;font-size:1.4rem;cursor:pointer;color:#666;">&times;</button>
        <div id="propertyDetailContent"></div>
    </div>
</div>

<script>
const API = 'http://localhost:8000/api';

function getToken() { return localStorage.getItem('authToken'); }

async function apiFetch(endpoint, options = {}) {
    const token = getToken();
    const headers = { 'Accept': 'application/json', ...(token ? { 'Authorization': `Bearer ${token}` } : {}), ...options.headers };
    if (options.body && !(options.body instanceof FormData) && typeof options.body === 'object') {
        headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(options.body);
    }
    const res = await fetch(`${API}${endpoint}`, { method: 'GET', ...options, headers });
    if (res.status === 401) { localStorage.clear(); window.location.href = 'home.html'; throw new Error('انتهت الجلسة'); }
    if (res.status === 403) throw new Error('غير مصرح');
    if (!res.ok) { const e = await res.json().catch(() => ({})); throw new Error(e.message || `HTTP ${res.status}`); }
    return res.json();
}

// ── auth guard ───────────────────────────────────────────────
function checkAdminAuth() {
    const token = getToken();
    const user  = JSON.parse(localStorage.getItem('user') || 'null');
    if (!token || !user) { alert('يجب تسجيل الدخول كمدير'); window.location.href = 'home.html'; return false; }
    if (user.role !== 'admin') { alert('غير مصرح لك'); window.location.href = 'home.html'; return false; }
    const firstLetter = encodeURIComponent((user.name || 'A').trim().charAt(0));
    document.getElementById('adminAvatar').src = `https://ui-avatars.com/api/?name=${firstLetter}&background=8B7FD2&color=fff`;
    document.getElementById('adminName').textContent = user.name || 'مشرف النظام';
    return true;
}

// ── section switching ─────────────────────────────────────────
function switchSection(sectionId) {
    document.querySelectorAll('.sidebar-nav a[data-section]').forEach(a => a.classList.toggle('active', a.dataset.section === sectionId));
    document.querySelectorAll('.section-panel').forEach(p => p.classList.toggle('active', p.id === sectionId));
    if (sectionId === 'users')      loadUsers();
    if (sectionId === 'properties') loadProperties('pending');
    if (sectionId === 'messages')   loadMessages();
}
window.switchSection = switchSection;

// ── status badge ──────────────────────────────────────────────
function statusBadge(status) {
    if (status === 'approved') return `<span class="status-badge status-active">نشط</span>`;
    if (status === 'rejected') return `<span class="status-badge status-rejected">مرفوض</span>`;
    return `<span class="status-badge status-pending">بانتظار</span>`;
}

// ── استخراج رابط الصورة بشكل موثوق ──────────────────────────
// function resolveImageUrl(imgObj) {
//     if (!imgObj) return null;
//     // أولاً image_url (يُضافها Laravel عبر accessor)
//     if (imgObj.image_url)  return imgObj.image_url;
//     // ثانياً image_path مع storage prefix
//     if (imgObj.image_path) return `http://localhost:8000/storage/${imgObj.image_path}`;
//     // ثالثاً url مباشر
//     if (imgObj.url)        return imgObj.url;
//     // رابعاً path
//     if (imgObj.path)       return imgObj.path;
//     return null;
// }
// ── استخراج رابط الصورة بشكل موثوق مع كسر الكاش ──────────────────────────
function resolveImageUrl(imgObj) {
    if (!imgObj) return null;
    
    let finalUrl = null;
    // أولاً image_url (يُضافها Laravel عبر accessor)
    if (imgObj.image_url)  finalUrl = imgObj.image_url;
    // ثانياً image_path مع storage prefix
    else if (imgObj.image_path) finalUrl = `http://localhost:8000/storage/${imgObj.image_path}`;
    // ثالثاً url مباشر
    else if (imgObj.url)        finalUrl = imgObj.url;
    // رابعاً path
    else if (imgObj.path)       finalUrl = imgObj.path;
    
    // خدعة منع الكاش: إضافة طابع زمني للرابط لإجبار المتصفح على تحميل الصورة الجديدة
    if (finalUrl) {
        const separator = finalUrl.includes('?') ? '&' : '?';
        return `${finalUrl}${separator}t=${new Date().getTime()}`;
    }
    
    return null;
}

// ── load dashboard stats ──────────────────────────────────────
async function loadStats() {
    try {
        const [approved, pending, msgs] = await Promise.all([
            apiFetch('/admin/properties?status=approved&per_page=1'),
            apiFetch('/admin/properties?status=pending&per_page=1'),
            apiFetch('/admin/contact-requests?per_page=1').catch(() => ({ total: 0 }))
        ]);
        document.getElementById('statActive').textContent   = approved.total || 0;
        document.getElementById('statPending').textContent  = pending.total  || 0;
        document.getElementById('statMessages').textContent = msgs.total     || 0;
    } catch (e) { console.error('فشل تحميل الإحصائيات:', e); }
}

// ── load users ────────────────────────────────────────────────
async function loadUsers() {
    const tbody = document.getElementById('usersTableBody');
    tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:20px;"><i class="fas fa-spinner fa-spin"></i> جاري التحميل...</td></tr>';
    try {
        const data  = await apiFetch('/admin/users?per_page=100');
        const users = data.data || [];
        if (users.length === 0) { tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:20px;color:#777;">لا يوجد مستخدمون</td></tr>'; return; }
        tbody.innerHTML = users.map(u => `
            <tr>
                <td><strong>#${u.id}</strong></td>
                <td>${u.name || '—'}</td>
                <td>${u.email}</td>
                <td>${u.phone || '—'}</td>
                <td>${u.role === 'admin' ? 'مدير' :
                    u.role === 'owner' ? 'مالك' :
                    (u.tenant_type === 'student' ? 'مستأجر - طالب' : 'مستأجر')}</td>
                <td class="actions">
                    ${u.role !== 'admin' ? `
                        ${u.is_banned
                            ? `<span style="background:#e53935;color:#fff;padding:4px 10px;border-radius:6px;font-size:0.85rem;"><i class="fas fa-ban"></i> محظور</span>
                               <button class="btn-approve" onclick="unbanUser(${u.id})"><i class="fas fa-check"></i> إلغاء الحظر</button>`
                            : `<button class="btn-ban" onclick="banUser(${u.id}, '${(u.name||'').replace(/'/g,"\\'")}')"><i class="fas fa-ban"></i> حظر</button>
                               <button class="btn-approve" onclick="unbanUser(${u.id})"><i class="fas fa-check"></i> إلغاء الحظر</button>`
                        }` : '<span style="color:#999;">—</span>'}
                </td>
            </tr>`).join('');
    } catch (e) {
        tbody.innerHTML = `<tr><td colspan="6" style="text-align:center;padding:20px;color:#e74c3c;">خطأ: ${e.message}</td></tr>`;
    }
}

async function banUser(id, name) {
    if (!confirm(`هل تريد حظر: ${name}؟`)) return;
    try {
        await apiFetch(`/admin/users/${id}/ban`, { method: 'PATCH' });
        showToast('تم حظر المستخدم وحذف عقاراته ✓', 'success');
        loadUsers();
    } catch(e) { showToast('فشل الحظر: ' + e.message, 'error'); }
}

async function unbanUser(id) {
    if (!confirm('هل تريد إلغاء الحظر؟')) return;
    try {
        await apiFetch(`/admin/users/${id}/unban`, { method: 'PATCH' });
        showToast('تم إلغاء الحظر ✓', 'success');
        loadUsers();
    } catch(e) { showToast('فشل إلغاء الحظر: ' + e.message, 'error'); }
}

// ── load properties ───────────────────────────────────────────
// async function loadProperties(status = 'pending') {
//     const tbody = document.getElementById('propertiesTableBody');
//     tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;padding:20px;"><i class="fas fa-spinner fa-spin"></i> جاري التحميل...</td></tr>';
//     try {
//         const data  = await apiFetch(`/admin/properties?status=${status}&per_page=100`);
//         const props = data.data || [];
//         if (props.length === 0) {
//             tbody.innerHTML = `<tr><td colspan="5" style="text-align:center;padding:20px;color:#777;">لا توجد عقارات (${status})</td></tr>`;
//             return;
//         }
//         tbody.innerHTML = props.map(p => `
//             <tr data-id="${p.id}">
//                 <td>${p.title}</td>
//                 <td>${p.owner ? p.owner.name : '—'}</td>
//                 <td>${Number(p.price).toLocaleString('ar-SY')} ل.س</td>
//                 <td>${statusBadge(p.status)}</td>
//                 <td class="actions">
//                     <button class="btn-view"    onclick="showPropertyDetail(${p.id})"><i class="fas fa-eye"></i> عرض</button>
//                     <button class="btn-approve" onclick="approveProperty(${p.id})"><i class="fas fa-check"></i> موافقة</button>
//                     <button class="btn-reject"  onclick="rejectProperty(${p.id})"><i class="fas fa-times"></i> رفض</button>
//                 </td>
//             </tr>`).join('');
//     } catch (e) {
//         tbody.innerHTML = `<tr><td colspan="5" style="text-align:center;padding:20px;color:#e74c3c;">خطأ: ${e.message}</td></tr>`;
//     }
// }
// window.loadProperties = loadProperties;
// ── load properties ───────────────────────────────────────────
async function loadProperties(status = 'pending') {
    const tbody = document.getElementById('propertiesTableBody');
    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;padding:20px;"><i class="fas fa-spinner fa-spin"></i> جاري التحميل...</td></tr>';
    try {
        const data  = await apiFetch(`/admin/properties?status=${status}&per_page=100`);
        const props = data.data || [];
        if (props.length === 0) {
            tbody.innerHTML = `<tr><td colspan="5" style="text-align:center;padding:20px;color:#777;">لا توجد عقارات (${status})</td></tr>`;
            return;
        }
        tbody.innerHTML = props.map(p => `
            <tr data-id="${p.id}">
                <td>${p.title}</td>
                <td>${p.owner ? p.owner.name : '—'}</td>
                <td>${Number(p.price).toLocaleString('ar-SY')} ل.س</td>
                <td>${statusBadge(p.status)}</td>
                <td class="actions">
                    <button class="btn-view" onclick="showPropertyDetail(${p.id})"><i class="fas fa-eye"></i> عرض</button>
                    ${p.status === 'approved' 
                        ? `<button class="btn-delete" onclick="deleteAdminProperty(${p.id}, '${status}')" style="background:#e53935;color:white;border:none;padding:5px 10px;border-radius:4px;cursor:pointer;"><i class="fas fa-trash-alt"></i> حذف</button>`
                        : `<button class="btn-approve" onclick="approveProperty(${p.id})"><i class="fas fa-check"></i> موافقة</button>
                           <button class="btn-reject"  onclick="rejectProperty(${p.id})"><i class="fas fa-times"></i> رفض</button>`
                    }
                </td>
            </tr>`).join('');
    } catch (e) {
        tbody.innerHTML = `<tr><td colspan="5" style="text-align:center;padding:20px;color:#e74c3c;">خطأ: ${e.message}</td></tr>`;
    }
}
window.loadProperties = loadProperties;

async function approveProperty(id) {
    if (!confirm('هل تريد قبول هذا العقار؟')) return;
    try {
        await apiFetch(`/admin/properties/${id}/approve`, { method: 'PATCH' });
        showToast('تم قبول العقار بنجاح ✓', 'success');
        loadProperties('pending');
        loadStats();
    } catch (e) { showToast('فشل القبول: ' + e.message, 'error'); }
}
async function rejectProperty(id) {
    if (!confirm('هل تريد رفض هذا العقار؟')) return;
    try {
        await apiFetch(`/admin/properties/${id}/reject`, { method: 'PATCH' });
        showToast('تم رفض العقار', 'success');
        loadProperties('pending');
        loadStats();
    } catch (e) { showToast('فشل الرفض: ' + e.message, 'error'); }
}
async function deleteAdminProperty(id, currentStatus) {
    if (!confirm('هل أنت متأكد من حذف هذا العقار بشكل نهائي من النظام؟')) return;
    try {
        await apiFetch(`/admin/properties/${id}`, { method: 'DELETE' });
        showToast('تم حذف العقار بنجاح ✓', 'success');
        loadProperties(currentStatus); // تحديث الجدول بناءً على التبويب الحالي
        loadStats();
    } catch (e) { 
        showToast('فشل الحذف: ' + e.message, 'error'); 
    }
}
window.deleteAdminProperty = deleteAdminProperty;
window.approveProperty = approveProperty;
window.rejectProperty  = rejectProperty;

// ── property detail popup ─────────────────────────────────────
// async function showPropertyDetail(id) {
//     const overlay = document.getElementById('propertyDetailOverlay');
//     const content = document.getElementById('propertyDetailContent');
//     overlay.classList.add('open');
//     content.innerHTML = '<div style="text-align:center;padding:40px;"><i class="fas fa-spinner fa-spin fa-2x" style="color:#8B7FD2;"></i></div>';
//     try {
//         const data = await apiFetch(`/admin/properties/${id}`);
//         const p = data.data || data;
//         const images = Array.isArray(p.images) ? p.images : [];

//         // إيجاد الصورة الرئيسية بشكل موثوق
//         const mainImgObj = images.find(i => i.is_main) || images[0] || null;
//         const mainSrc    = resolveImageUrl(mainImgObj);

//         // بناء شريط الصور المصغرة إن وُجدت أكثر من صورة
//         let stripHTML = '';
//         if (images.length > 1) {
//             const thumbs = images.map((img, idx) => {
//                 const src = resolveImageUrl(img);
//                 return src ? `<img src="${src}" class="${idx === 0 ? 'active-thumb' : ''}" onclick="switchDetailImg(this, '${src}')" onerror="this.style.display='none'">` : '';
//             }).filter(Boolean).join('');
//             if (thumbs) stripHTML = `<div class="prop-img-strip">${thumbs}</div>`;
//         }

//         // الصورة الرئيسية أو placeholder
//         const imgHTML = mainSrc
//             ? `<img id="propDetailMainImg" class="prop-detail-img" src="${mainSrc}" alt="${p.title}" onerror="this.parentNode.replaceChild(Object.assign(document.createElement('div'),{className:'prop-detail-img-placeholder',innerHTML:'<i class=\\'fas fa-image\\'></i>'}),this)">`
//             : `<div class="prop-detail-img-placeholder"><i class="fas fa-image"></i></div>`;

//         // content.innerHTML = `
//         //     ${imgHTML}
//         //     ${stripHTML}
//         //     <h2 style="color:#333;margin-bottom:8px;">${p.title}</h2>
//         //     <p style="color:#666;margin-bottom:6px;"><i class="fas fa-map-marker-alt" style="color:#e74c3c;"></i> ${p.city || ''}${p.region ? ' - ' + p.region : ''}</p>
//         //     <p style="color:#8B7FD2;font-size:1.2rem;font-weight:700;margin-bottom:12px;">${Number(p.price).toLocaleString('ar-SY')} ل.س</p>
//         //     <p style="color:#555;line-height:1.7;">${p.description || 'لا يوجد وصف'}</p>
//         //     <div style="margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;">
//         //         <button class="btn-approve" onclick="approveProperty(${p.id});closePropertyDetail()"><i class="fas fa-check"></i> موافقة</button>
//         //         <button class="btn-reject"  onclick="rejectProperty(${p.id});closePropertyDetail()"><i class="fas fa-times"></i> رفض</button>
//         //     </div>`;
//         content.innerHTML = `
//             ${imgHTML}
//             ${stripHTML}
//             <h2 style="color:#333;margin-bottom:8px;">${p.title}</h2>
//             <p style="color:#666;margin-bottom:6px;"><i class="fas fa-map-marker-alt" style="color:#e74c3c;"></i> ${p.city || ''}${p.region ? ' - ' + p.region : ''}</p>
//             <p style="color:#8B7FD2;font-size:1.2rem;font-weight:700;margin-bottom:12px;">${Number(p.price).toLocaleString('ar-SY')} ل.س</p>
//             <p style="color:#555;line-height:1.7;">${p.description || 'لا يوجد وصف'}</p>
//             <div style="margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;">
//                 ${p.status === 'approved' 
//                     ? `<button class="btn-delete" onclick="deleteAdminProperty(${p.id}, '${p.status}'); closePropertyDetail()" style="background:#e53935;color:white;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;"><i class="fas fa-trash-alt"></i> حذف العقار</button>`
//                     : `<button class="btn-approve" onclick="approveProperty(${p.id});closePropertyDetail()"><i class="fas fa-check"></i> موافقة</button>
//                        <button class="btn-reject"  onclick="rejectProperty(${p.id});closePropertyDetail()"><i class="fas fa-times"></i> رفض</button>`
//                 }
//             </div>`;
//     } catch (e) {
//         content.innerHTML = `<p style="color:#e74c3c;text-align:center;">فشل تحميل التفاصيل: ${e.message}</p>`;
//     }
// }
// ── property detail popup ─────────────────────────────────────
// async function showPropertyDetail(id) {
//     const overlay = document.getElementById('propertyDetailOverlay');
//     const content = document.getElementById('propertyDetailContent');
//     overlay.classList.add('open');
//     content.innerHTML = '<div style="text-align:center;padding:40px;"><i class="fas fa-spinner fa-spin fa-2x" style="color:#8B7FD2;"></i></div>';
    
//     try {
//         // إضافة وقت عشوائي في نهاية طلب الـ API لمنع المتصفح من عرض البيانات القديمة (Cache Busting)
//         const timestamp = new Date().getTime();
//         const data = await apiFetch(`/admin/properties/${id}?_t=${timestamp}`);
//         const p = data.data || data;
//         const images = Array.isArray(p.images) ? p.images : [];

//         // إيجاد الصورة الرئيسية بشكل موثوق
//         const mainImgObj = images.find(i => i.is_main) || images[0] || null;
//         const mainSrc    = resolveImageUrl(mainImgObj);

//         // بناء شريط الصور المصغرة إن وُجدت أكثر من صورة
//         let stripHTML = '';
//         if (images.length > 1) {
//             const thumbs = images.map((img, idx) => {
//                 const src = resolveImageUrl(img);
//                 return src ? `<img src="${src}" class="${idx === 0 ? 'active-thumb' : ''}" onclick="switchDetailImg(this, '${src}')" onerror="this.style.display='none'">` : '';
//             }).filter(Boolean).join('');
//             if (thumbs) stripHTML = `<div class="prop-img-strip">${thumbs}</div>`;
//         }

//         // الصورة الرئيسية أو placeholder
//         const imgHTML = mainSrc
//             ? `<img id="propDetailMainImg" class="prop-detail-img" src="${mainSrc}" alt="${p.title}" onerror="this.parentNode.replaceChild(Object.assign(document.createElement('div'),{className:'prop-detail-img-placeholder',innerHTML:'<i class=\\'fas fa-image\\'></i>'}),this)">`
//             : `<div class="prop-detail-img-placeholder"><i class="fas fa-image"></i></div>`;

//         content.innerHTML = `
//             ${imgHTML}
//             ${stripHTML}
//             <h2 style="color:#333;margin-bottom:8px;">${p.title}</h2>
//             <p style="color:#666;margin-bottom:6px;"><i class="fas fa-map-marker-alt" style="color:#e74c3c;"></i> ${p.city || ''}${p.region ? ' - ' + p.region : ''}</p>
//             <p style="color:#8B7FD2;font-size:1.2rem;font-weight:700;margin-bottom:12px;">${Number(p.price).toLocaleString('ar-SY')} ل.س</p>
//             <p style="color:#555;line-height:1.7;">${p.description || 'لا يوجد وصف'}</p>
//             <div style="margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;">
//                 ${p.status === 'approved' 
//                     ? `<button class="btn-delete" onclick="deleteAdminProperty(${p.id}, '${p.status}'); closePropertyDetail()" style="background:#e53935;color:white;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;"><i class="fas fa-trash-alt"></i> حذف العقار</button>`
//                     : `<button class="btn-approve" onclick="approveProperty(${p.id});closePropertyDetail()"><i class="fas fa-check"></i> موافقة</button>
//                        <button class="btn-reject"  onclick="rejectProperty(${p.id});closePropertyDetail()"><i class="fas fa-times"></i> رفض</button>`
//                 }
//             </div>`;
//     } catch (e) {
//         content.innerHTML = `<p style="color:#e74c3c;text-align:center;">فشل تحميل التفاصيل: ${e.message}</p>`;
//     }
// }
const amenitiesTranslation = {
    'parking': 'موقف سيارات', 'elevator': 'مصعد', 'security': 'أمن وحراسة',
    'garden': 'حديقة', 'pool': 'مسبح', 'gym': 'صالة رياضية',
    'balcony': 'شرفة', 'furnished': 'مفروش'
};
const amenitiesIcons = {
    'parking': 'fa-car', 'elevator': 'fa-elevator', 'security': 'fa-shield-alt',
    'garden': 'fa-tree', 'pool': 'fa-swimming-pool', 'gym': 'fa-dumbbell',
    'balcony': 'fa-building', 'furnished': 'fa-couch'
};
 async function showPropertyDetail(id) {
    const overlay = document.getElementById('propertyDetailOverlay');
    const content = document.getElementById('propertyDetailContent');
    overlay.classList.add('open');
    content.innerHTML = '<div style="text-align:center;padding:40px;"><i class="fas fa-spinner fa-spin fa-2x" style="color:#8B7FD2;"></i></div>';

    try {
        const timestamp = new Date().getTime();
        const data = await apiFetch(`/admin/properties/${id}?_t=${timestamp}`);
        const p = data.data || data;
        const images = Array.isArray(p.images) ? p.images : [];

        const mainImgObj = images.find(i => i.is_main)|| images[0] || null;
        const mainSrc = resolveImageUrl(mainImgObj);

        let stripHTML = '';
        if (images.length > 1) {
            const thumbs = images.map((img, idx) => {
                const src = resolveImageUrl(img);
                return src ? `<img src="${src}" class="${idx === 0 ? 'active-thumb' : ''}" onclick="switchDetailImg(this, '${src}')" onerror="this.style.display='none'">` : '';
            }).filter(Boolean).join('');
            if (thumbs) stripHTML = `<div class="prop-img-strip">${thumbs}</div>`;
        }

        const imgHTML = mainSrc
            ? `<img id="propDetailMainImg" class="prop-detail-img" src="${mainSrc}" alt="${p.title}" onerror="this.parentNode.replaceChild(Object.assign(document.createElement('div'),{className:'prop-detail-img-placeholder',innerHTML:'<i class=\\'fas fa-image\\'></i>'}),this)">`
            : `<div class="prop-detail-img-placeholder"><i class="fas fa-image"></i></div>`;

        // السعر مع/بدون خصم
        const price = parseFloat(p.price);
        let priceHTML;
        if (p.has_student_discount && p.student_discount_percentage > 0) {
            const discounted = price * (1 - p.student_discount_percentage / 100);
            priceHTML =`
                <span style="text-decoration:line-through;color:#aaa;font-size:1rem;margin-left:8px;">${price.toLocaleString('ar-SY')} ل.س</span>
                <span style="color:#27ae60;">${discounted.toLocaleString('ar-SY')} ل.س <small>(خصم ${p.student_discount_percentage}%)</small></span>`;
        } else {
            priceHTML = `${price.toLocaleString('ar-SY')} ل.س` ;
        }

        // المرافق
        let amenitiesHTML = '';
        if (p.amenities && p.amenities.length > 0) {
            const list = p.amenities.map(a => `
                <span class="amenity-tag">
                    <i class="fas ${amenitiesIcons[a] || 'fa-check'}"></i>
                    ${amenitiesTranslation[a] || a}
                </span>`).join('');
            amenitiesHTML = `<div class="amenities-section"><h4>المرافق والخدمات</h4><div class="amenities-list">${list}</div></div>`;
        }

        // الميزات (مساحة، غرف، تقسيم)
        const features = [];
        if (p.area) features.push(`<div class="feature-item"><i class="fas fa-vector-square"></i><span>${p.area} م²</span></div>`);
        if (p.rooms_count) features.push(`<div class="feature-item"><i class="fas fa-bed"></i><span>${p.rooms_count} غرف</span></div>`);
        if (p.division_accept === 'yes') {
            features.push(`<div class="feature-item"><i class="fas fa-layer-group"></i><span>يقبل التقسيم${p.division_count ?`  لـ ${p.division_count} أفراد `: ''}</span></div>`);
        }
        const featuresHTML = features.length ? `<div class="property-features">${features.join('')}</div>` : '';

        // معلومات المالك
        const ownerHTML = p.owner ? `
            <div class="contact-section">
                <h4>معلومات المالك</h4>
                <div class="contact-info">
                    <div class="contact-item"><i class="fas fa-user"></i><span>${p.owner.name || '—'}</span></div>
                    <div class="contact-item"><i class="fas fa-phone"></i><span dir="ltr" style="direction:ltr;">${p.owner.phone || '—'}</span></div>
                   ${p.owner.email ? `<div class="contact-item"><i class="fas fa-envelope"></i><span>${p.owner.email}</span></div>` : ''}
                </div>
            </div>` : '';

        content.innerHTML = `
            ${imgHTML}
            ${stripHTML}
            <h2 style="color:#333;margin-bottom:8px;">${p.title}</h2>
            <p style="color:#666;margin-bottom:6px;"><i class="fas fa-map-marker-alt" style="color:#e74c3c;"></i> ${p.city || ''}${p.region ? ' - ' + p.region : ''}${p.address ? ' - ' + p.address : ''}</p>
            <p style="color:#8B7FD2;font-size:1.2rem;font-weight:700;margin-bottom:12px;">${priceHTML}</p>
            ${featuresHTML}
            <p style="color:#555;line-height:1.7;margin-top:12px;">${p.description || 'لا يوجد وصف'}</p>
            ${amenitiesHTML}
            ${ownerHTML}
            <div style="margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;">
                ${p.status === 'approved'
                    ?  `<button class="btn-delete" onclick="deleteAdminProperty(${p.id}, '${p.status}'); closePropertyDetail()" style="background:#e53935;color:white;border:none;padding:8px 16px;border-radius:6px;cursor:pointer;"><i class="fas fa-trash-alt"></i> حذف العقار</button>`
                    :` <button class="btn-approve" onclick="approveProperty(${p.id});closePropertyDetail()"><i class="fas fa-check"></i> موافقة</button>
                       <button class="btn-reject"  onclick="rejectProperty(${p.id});closePropertyDetail()"><i class="fas fa-times"></i> رفض</button>`
                }
            </div>`;
    } catch (e) {
        content.innerHTML = `<p style="color:#e74c3c;text-align:center;">فشل تحميل التفاصيل: ${e.message}</p>`;
    }
}
// تبديل الصورة الرئيسية عند النقر على thumbnail
function switchDetailImg(thumb, src) {
    const mainImg = document.getElementById('propDetailMainImg');
    if (mainImg) mainImg.src = src;
    document.querySelectorAll('.prop-img-strip img').forEach(t => t.classList.remove('active-thumb'));
    thumb.classList.add('active-thumb');
}
window.switchDetailImg = switchDetailImg;

function closePropertyDetail() {
    document.getElementById('propertyDetailOverlay').classList.remove('open');
}
window.showPropertyDetail  = showPropertyDetail;
window.closePropertyDetail = closePropertyDetail;

// ── load messages ─────────────────────────────────────────────
async function loadMessages() {
    const tbody = document.getElementById('contactRequestsBody');
    tbody.innerHTML = '<tr><td colspan="8" style="text-align:center;padding:20px;"><i class="fas fa-spinner fa-spin"></i> جاري التحميل...</td></tr>';
    try {
        const data = await apiFetch('/admin/contact-requests?per_page=100');
        const reqs = data.data || [];
        if (reqs.length === 0) { tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;padding:20px;color:#777;">لا توجد طلبات تواصل حالياً</td></tr>'; return; }
        tbody.innerHTML = reqs.map(r => {
            const propTitle  = r.property ? r.property.title : '—';
            const ownerName  = r.owner    ? r.owner.name     : '—';
            const ownerPhone = r.owner    ? (r.owner.phone || '—') : '—';
            const date       = r.created_at ? new Date(r.created_at).toLocaleString('ar-SY') : '—';
            return `
                <tr>
                    <td>${propTitle}</td>
                    <td>${ownerName}</td>
                    <td>${ownerPhone}</td>
                    <td>${date}</td>
                    <td>${r.name || '—'}</td>
                    <td>${r.phone || '—'}</td>
                    <td>${r.message || 'لا توجد رسالة'}</td>
                    <td class="actions">
                        <button class="btn-delete" onclick="deleteContactReq(${r.id})"><i class="fas fa-trash-alt"></i> حذف</button>
                    </td>
                </tr>`;
        }).join('');
    } catch (e) {
        tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;padding:20px;color:#e74c3c;">خطأ: ${e.message}</td></tr>`;
    }
}

async function deleteContactReq(id) {
    if (!confirm('هل تريد حذف طلب التواصل هذا؟')) return;
    try {
        await apiFetch(`/admin/contact-requests/${id}`, { method: 'DELETE' });
        showToast('تم الحذف', 'success');
        loadMessages();
        loadStats();
    } catch (e) { showToast('فشل الحذف: ' + e.message, 'error'); }
}
window.deleteContactReq = deleteContactReq;

// ── toast ─────────────────────────────────────────────────────
function showToast(msg, type) {
    const t = document.createElement('div');
    t.textContent = msg;
    t.style.cssText = `position:fixed;top:20px;left:50%;transform:translateX(-50%);background:${type==='success'?'#4caf50':'#e53935'};color:#fff;padding:12px 24px;border-radius:8px;box-shadow:0 4px 12px rgba(0,0,0,.2);z-index:99999;font-size:.95rem;transition:opacity .3s;`;
    document.body.appendChild(t);
    setTimeout(() => { t.style.opacity = '0'; setTimeout(() => t.remove(), 300); }, 3000);
}

// ── init ──────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {
    if (!checkAdminAuth()) return;

    document.querySelectorAll('.sidebar-nav a[data-section]').forEach(link => {
        link.addEventListener('click', function (e) {
            if (this.classList.contains('return-site-btn')) return;
            e.preventDefault();
            switchSection(this.dataset.section);
        });
    });

    document.getElementById('cardActiveProps').addEventListener('click',  () => { switchSection('properties'); loadProperties('approved'); });
    document.getElementById('cardPendingProps').addEventListener('click', () => { switchSection('properties'); loadProperties('pending'); });
    document.getElementById('cardMessages').addEventListener('click',     () => switchSection('messages'));

    document.querySelector('.logout-btn').addEventListener('click', function () {
        if (confirm('هل أنت متأكد من رغبتك في تسجيل الخروج من لوحة الإدارة؟')) {
            ['authToken','user','userData','userEmail','userType','isLoggedIn'].forEach(k => localStorage.removeItem(k));
            window.location.href = '../eskan4/home.html';
        }
    });

    const hamburger = document.getElementById('adminHamburger');
    const sidebar   = document.querySelector('.sidebar');
    if (hamburger && sidebar) {
        hamburger.addEventListener('click', e => { e.stopPropagation(); hamburger.classList.toggle('active'); sidebar.classList.toggle('active'); });
        document.addEventListener('click', e => { if (!sidebar.contains(e.target) && !hamburger.contains(e.target)) { hamburger.classList.remove('active'); sidebar.classList.remove('active'); } });
    }

    document.getElementById('propertyDetailOverlay').addEventListener('click', function (e) {
        if (e.target === this) closePropertyDetail();
    });

    loadStats();
});
</script>
</body>
</html>