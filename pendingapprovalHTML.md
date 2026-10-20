<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة تحكم العقارات</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- <link href="https://fonts.googleapis.com/css2?family=Cairo:wght=400;600;700;800&display=swap" rel="stylesheet"> -->
     <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/eskan4/style/pending-approval.css">
    <link rel="stylesheet" href="style/site.css">
</head>
<body>
    <div class="admin-container">
        <!-- القائمة الجانبية -->
        <aside class="sidebar">
            <div class="sidebar-header" style="margin-top:70px;">
                <h3>لوحة التحكم</h3>
                <p class="sidebar-description">إدارة متكاملة لعقاراتك المضافة.</p>
            </div>
            <nav class="sidebar-nav">
                <a href="home.html" class="return-site-btn" title="العودة للموقع الرئيسي">
                    <i class="fas fa-arrow-right"></i> العودة للموقع
                </a>
                <a href="#" class="active" data-section="dashboard"><i class="fas fa-tachometer-alt"></i> لوحة التحكم الرئيسية</a>
                <a href="#" data-section="messages"><i class="fas fa-envelope"></i> طلبات المراسلة
                    <span id="sidebarMessageCount" class="badge" style="background:#8B7FD2;color:#fff;padding:2px 6px;border-radius:50%;font-size:11px;margin-right:5px;display:none;">0</span>
                </a>
                <a href="#" data-section="bookings">
    <i class="fas fa-calendar-check"></i>
    طلبات الحجز
</a>
                <a href="#" data-section="properties"><i class="fas fa-building"></i> إدارة العقارات المضافة</a>
            </nav>
            <div class="sidebar-footer">
                <p style="color:#ccc;font-size:12px;text-align:center;">إسكان 2026 &copy;</p>
            </div>
        </aside>

        <!-- المحتوى الرئيسي -->
        <main class="main-content">
            <header class="topbar">
                <div class="topbar-right-box">
                    <div class="hamburger" id="adminHamburger">
                        <span></span><span></span><span></span>
                    </div>
                    <h1>لوحة تحكم العقارات</h1>
                </div>
                <div class="topbar-actions">
                    <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> تسجيل الخروج</button>
                    <div class="profile-chip">
                        <img id="userAvatar" src="https://ui-avatars.com/api/?name=مستخدم&background=8B7FD2&color=fff" alt="avatar">
                        <div class="profile-text">
                            <span id="topbarUserName">مستخدم المنصة</span>
                            <small id="topbarUserRole">حساب شخصي</small>
                        </div>
                    </div>
                </div>
            </header>

            <section class="content-area">
                <!-- رسالة للمستأجر الجديد -->
                <div id="tenantPlaceholder" style="display: none; text-align: center; padding: 50px; background: #f9f9f9; border-radius: 15px; border: 2px dashed #8B7FD2; margin-top: 20px;">
                    <i class="fas fa-home" style="font-size: 3rem; color: #8B7FD2; margin-bottom: 15px;"></i>
                    <h2 style="color: #333;">أضف عقارك الأول</h2>
                    <p style="color: #666; margin-bottom: 20px;">مرحباً بك! لكي تظهر لوحة التحكم الخاصة بك وتتمكن من متابعة الطلبات، يجب عليك إضافة عقارك الأول أولاً.</p>
                    <a href="add-properties.html" class="btn-primary" style="padding: 10px 25px; background: #8B7FD2; color: #fff; text-decoration: none; border-radius: 5px;">أضف عقار الآن</a>
                </div>
                <!-- شريط التنبيه -->
                <div class="urgent-alerts">
                    <div class="alert-card">
                        <div class="alert-icon"><i class="fas fa-bullhorn"></i></div>
                        <div class="alert-text-content">
                            <strong>مرحباً بك في مساحتك الخاصة</strong>
                            <p>من هنا يمكنك متابعة العقارات المفعلة، وتحديث العقارات المعلقة قيد المراجعة، ومتابعة طلبات المراسلة بسهولة.</p>
                        </div>
                    </div>
                </div>

                <!-- تبويب لوحة التحكم الرئيسي -->
                <section class="section-panel active" id="dashboard">
                    <div class="grid-cards">
                        <div class="card-panel pointer-card" id="cardActiveProperties">
                            <div class="card-info">
                                <h2>العقارات المنشورة والمفعلة</h2>
                                <p>العقارات المتاحة حالياً للعامة في الموقع</p>
                            </div>
                            <span class="stat-value" id="countActive">0</span>
                        </div>
                        <div class="card-panel pointer-card" id="cardPendingProperties">
                            <div class="card-info">
                                <h2>بانتظار موافقة الإدارة</h2>
                                <p>عقارات مضافة حديثاً وقيد المراجعة</p>
                            </div>
                            <span class="stat-value" id="countPending">0</span>
                        </div>
                        <div class="card-panel pointer-card" id="cardMessagesRequests">
                            <div class="card-info">
                                <h2>طلبات المراسلة والمهتمين</h2>
                                <p>رسائل استفسار مباشرة من زبائن محتملين</p>
                            </div>
                            <span class="stat-value" id="countMessages">0</span>
                        </div>
                        <div class="card-panel pointer-card" id="cardBookings">
                        <div class="card-info">
                            <h2>طلبات الحجز</h2>
                            <p>طلبات الحجز الواردة على عقاراتك</p>
                        </div>

                        <span class="stat-value" id="countBookings">0</span>
                    </div>
                    </div>

                    <!-- جدول العقارات المعلقة -->
                    <div class="table-panel">
                        <div class="table-panel-header">
                            <h3>قائمة العقارات المعلقة (قيد المراجعة الحالية)</h3>
                            <p>مراجعة سريعة لحالة العقارات التي تنتظر تأكيد الإدارة لتظهر في الموقع.</p>
                        </div>
                        <div class="table-responsive-wrapper">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>عنوان وتفاصيل العقار المضاف</th>
                                        <th>المحافظة</th>
                                        <th>السعر المطلوب</th>
                                        <th>حالة الطلب حالياً</th>
                                        <th>إجراءات التحكم السريعة</th>
                                    </tr>
                                </thead>
                                <tbody id="pendingTableBody"></tbody>
                            </table>
                        </div>
                        <div class="mobile-cards" id="pendingMobileCards"></div>
                    </div>
                </section>

                <!-- تبويب طلبات المراسلة -->
                <section class="section-panel" id="messages">
                    <div class="table-panel">
                        <div class="table-panel-header">
                            <h3>طلبات التواصل الواردة</h3>
                            <p>عرض طلبات تواصل الزبائن الخاصة بعقاراتك.</p>
                        </div>
                        <div class="table-responsive-wrapper">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>العقار</th>
                                        <th>تاريخ طلب التواصل</th>
                                        <th>البريد الإلكتروني للزبون</th>
                                        <th>رقم الزبون</th>
                                        <th>الرسالة</th
                                    </tr>
                                </thead>
                                <tbody id="ownerContactRequestsBody"></tbody>
                            </table>
                        </div>
                    </div>
                </section>
                   <section class="section-panel" id="bookings">

    <div class="table-panel">

        <div class="table-panel-header">
            <h3>طلبات الحجز</h3>
            <p>عرض طلبات الحجز الواردة على عقاراتك</p>
        </div>

        <div class="table-responsive-wrapper">

            <table class="admin-table">

                <thead>

                    <tr>
                        <th>العقار</th>
                        <th>المستأجر</th>
                        <th>الهاتف</th>
                        <th>الحالة</th>
                        <th>الإجراءات</th>
                    </tr>

                </thead>

                <tbody id="bookingsTableBody"></tbody>

            </table>

        </div>

    </div>

</section>

                <!-- تبويب إدارة عقاراتي -->
                <section class="section-panel" id="properties">
                    <div class="table-panel">
                        <div class="table-panel-header">
                            <h3>أرشيف وإدارة جميع العقارات المضافة</h3>
                            <p>تحكم كامل بجميع العقارات التي قمت بإنشائها على المنصة مع ميزة التعديل السريع والحذف.</p>
                        </div>
                        <div class="table-responsive-wrapper">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>اسم وعنوان العقار</th>
                                        <th>حالة النشر والقبول</th>
                                        <th>السعر والطلب</th>
                                        <th>الموقع بالتفصيل</th>
                                        <th>إجراءات الإدارة والتحكم</th>
                                    </tr>
                                </thead>
                                <tbody id="myPropertiesTableBody"></tbody>
                            </table>
                        </div>
                        <div class="mobile-cards" id="myPropertiesMobileCards"></div>
                    </div>
                </section>
            </section>
        </main>
    </div>

    <script>
    const API = 'http://localhost:8000/api';

    // ── helpers ──────────────────────────────────────────────────
    function getToken() { return localStorage.getItem('authToken'); }

    function getStatusMarkup(status) {
        if (!status) return `<span class="status-badge status-pending"><i class="fas fa-clock"></i> قيد المراجعة</span>`;
        if (status === 'approved') return `<span class="status-badge status-active"><i class="fas fa-check-circle"></i> عقار مفعل ومنشور</span>`;
        if (status === 'rejected') return `<span class="status-badge status-rejected"><i class="fas fa-times-circle"></i> مرفوض</span>`;
        return `<span class="status-badge status-pending"><i class="fas fa-clock"></i> قيد المراجعة</span>`;
    }

    async function apiFetch(endpoint, options = {}) {
        const token = getToken();
        const headers = { 'Accept': 'application/json', ...(token ? { 'Authorization': `Bearer ${token}` } : {}), ...options.headers };
        const res = await fetch(`${API}${endpoint}`, { method: 'GET', ...options, headers });
        if (!res.ok) { const e = await res.json().catch(() => ({})); throw new Error(e.message || `HTTP ${res.status}`); }
        return res.json();
    }

    // ── auth guard ───────────────────────────────────────────────
    function checkAuth() {
        const token = getToken();
        const user = JSON.parse(localStorage.getItem('user') || 'null');
        if (!token || !user) {
            alert('عذراً، يجب تسجيل الدخول أولاً للوصول إلى هذه الصفحة.');
            window.location.href = 'home.html';
            return false;
        }
        return user;
    }

    // ── profile ──────────────────────────────────────────────────
    function renderProfile(user) {
        const name = user.name || 'مستخدم المنصة';
        const email = user.email || '';
        // نوع المستخدم: إذا كان tenant_type = student نعرض "مستأجر - طالب"
        let roleLabel = 'مستخدم';
            if (user.role === 'admin')  roleLabel = 'مدير النظام'; 
        if (user.role === 'owner') roleLabel = 'مالك عقار';
        else if (user.role === 'tenant' && user.tenant_type === 'student') roleLabel = 'مستأجر - طالب';
        else if (user.role === 'tenant') roleLabel = 'مستأجر';

        // أول حرف من الاسم للأفاتار
        const firstLetter = encodeURIComponent(name.trim().charAt(0) || 'م');
        document.getElementById('userAvatar').src = `https://ui-avatars.com/api/?name=${firstLetter}&background=8B7FD2&color=fff`;
        document.getElementById('topbarUserName').innerText = name;
        document.getElementById('topbarUserRole').innerText = roleLabel;
    }

    // ── counters ─────────────────────────────────────────────────
    function updateCounters(properties, messagesCount) {
        const activeCount  = properties.filter(p => p.status === 'approved').length;
        const pendingCount = properties.filter(p => p.status === 'pending').length;

        document.getElementById('countActive').innerText   = activeCount;
        document.getElementById('countPending').innerText  = pendingCount;
       document.getElementById('countMessages').innerText = messagesCount;

        // الـ badge يظهر فقط عند فتح الصفحة للمرة الأولى
        // وتُصفَّر بعد فتح قسم الرسائل
        const badge = document.getElementById('sidebarMessageCount');
        const wasRead = sessionStorage.getItem('messagesRead') === 'true';
        if (messagesCount > 0 && !wasRead) { 
            badge.innerText = messagesCount; 
            badge.style.display = 'inline-block'; 
        } else { 
            badge.style.display = 'none'; 
        }
    }
    // ── delete property ──────────────────────────────────────────
    async function deleteProperty(id) {
        if (!confirm('هل أنت متأكد من حذف هذا العقار؟')) return;
        try {
            await apiFetch(`/owner/properties/${id}`, { method: 'DELETE' });
            alert('تم حذف العقار بنجاح');
            loadDashboard();
        } catch (e) { alert('فشل الحذف: ' + e.message); }
    }
    window.deleteProperty = deleteProperty;

    // ── render pending table (dashboard tab) ─────────────────────
    function renderPendingTable(pendingItems) {
        const tbody  = document.getElementById('pendingTableBody');
        const mobile = document.getElementById('pendingMobileCards');
        if (!tbody) return;

        if (pendingItems.length === 0) {
            tbody.innerHTML  = '<tr><td colspan="5" style="text-align:center;padding:30px;color:#777;font-weight:600;">لا توجد أي عقارات معلقة حالياً</td></tr>';
            mobile.innerHTML = '<p style="text-align:center;padding:20px;color:#777;">لا توجد عقارات معلقة</p>';
            return;
        }

        tbody.innerHTML  = '';
        mobile.innerHTML = '';
        pendingItems.forEach(item => {
            const price = Number(item.price).toLocaleString('ar-SY');
            tbody.innerHTML += `
                <tr>
                    <td><strong class="prop-table-title">${item.title}</strong></td>
                    <td><span class="location-text"><i class="fas fa-map-marker-alt"></i> ${item.city}</span></td>
                    <td><strong class="price-text-style">${price} ل.س</strong></td>
                    <td>${getStatusMarkup(item.status)}</td>
                    <td>
                        <div class="actions">
                            <button class="btn-delete" onclick="deleteProperty(${item.id})"><i class="fas fa-trash-alt"></i> حذف</button>
                        </div>
                    </td>
                </tr>`;
            mobile.innerHTML += `
                <div class="property-card-mobile">
                    <h4>${item.title}</h4>
                    <p><i class="fas fa-map-marker-alt"></i> <strong>المحافظة:</strong> ${item.city}</p>
                    <p><i class="fas fa-money-bill-wave"></i> <strong>السعر:</strong> ${price} ل.س</p>
                    <div style="margin:15px 0;">${getStatusMarkup(item.status)}</div>
                    <div class="actions">
                        <button class="btn-delete" onclick="deleteProperty(${item.id})"><i class="fas fa-trash-alt"></i> حذف</button>
                    </div>
                </div>`;
        });
    }

    // ── render all-properties table (properties tab) ─────────────
    function renderAllProperties(list) {
        const tbody  = document.getElementById('myPropertiesTableBody');
        const mobile = document.getElementById('myPropertiesMobileCards');
        if (!tbody) return;

        if (list.length === 0) {
            tbody.innerHTML  = '<tr><td colspan="5" style="text-align:center;padding:30px;color:#777;font-weight:600;">لا توجد عقارات مضافة حالياً</td></tr>';
            mobile.innerHTML = '<p style="text-align:center;padding:20px;color:#777;">لا توجد عقارات</p>';
            return;
        }

        tbody.innerHTML  = '';
        mobile.innerHTML = '';
        list.forEach(item => {
            const price = Number(item.price).toLocaleString('ar-SY');
            tbody.innerHTML += `
                <tr>
                    <td><strong class="prop-table-title">${item.title}</strong></td>
                    <td>${getStatusMarkup(item.status)}</td>
                    <td><strong class="price-text-style">${price} ل.س</strong></td>
                    <td><span class="location-text"><i class="fas fa-map-marked-alt"></i> ${item.city}${item.district ? ' - ' + item.district : ''}</span></td>
                    <td>
                        <div class="actions">
                            <button class="btn-edit" onclick="window.location.href='add-properties.html?edit=${item.id}'"><i class="fas fa-edit"></i> تعديل</button>
                            <button class="btn-delete" onclick="deleteProperty(${item.id})"><i class="fas fa-trash-alt"></i> حذف</button>
                        </div>
                    </td>
                </tr>`;
            mobile.innerHTML += `
                <div class="property-card-mobile">
                    <h4>${item.title}</h4>
                    <p><i class="fas fa-map-marked-alt"></i> <strong>الموقع:</strong> ${item.city}${item.district ? ' - ' + item.district : ''}</p>
                    <p><i class="fas fa-money-bill-wave"></i> <strong>السعر:</strong> ${price} ل.س</p>
                    <div style="margin:15px 0;">${getStatusMarkup(item.status)}</div>
                    <div class="actions">
                        <button class="btn-edit" onclick="window.location.href='add-properties.html?edit=${item.id}'"><i class="fas fa-edit"></i> تعديل</button>
                        <button class="btn-delete" onclick="deleteProperty(${item.id})"><i class="fas fa-trash-alt"></i> حذف</button>
                    </div>
                </div>`;
        });
    }
    function renderContactRequests(requests) {
    const tbody = document.getElementById('ownerContactRequestsBody');
    if (!tbody) return;
    if (requests.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;padding:20px;color:#777;">لا توجد طلبات تواصل حالياً</td></tr>';
        return;
    }
    tbody.innerHTML = '';
    requests.forEach(r => {
        const date      = r.created_at ? new Date(r.created_at).toLocaleString('ar-SY') : '—';
        const propTitle = r.property ? r.property.title : '—';
        const row = document.createElement('tr');
        row.innerHTML = `
            <td><strong>${propTitle}</strong></td>
            <td>${date}</td>
            <td>${r.name || '—'}</td>
            <td>${r.phone || '—'}</td>
            <td>${r.message || 'لا توجد رسالة'}</td>`;
        tbody.appendChild(row);
    });
}
// function renderBookings(bookings) {

//     const tbody =
//         document.getElementById('bookingsTableBody');

//     if (!tbody) return;

//     if (bookings.length === 0) {

//         tbody.innerHTML =
//         '<tr><td colspan="5" style="text-align:center">لا توجد طلبات حجز</td></tr>';

//         return;
//     }

//     tbody.innerHTML = '';

//     bookings.forEach(item => {

//         tbody.innerHTML += `

//         <tr>

//             <td>${item.property?.title || '-'}</td>

//             <td>${item.tenant?.name || '-'}</td>

//             <td>${item.tenant?.phone || '-'}</td>

//            <td>${{'pending':'قيد الانتظار','accepted':'مقبول','rejected':'مرفوض'}[item.status] || item.status}</td>
            

//             <td>

//                 ${
//                     item.status === 'pending'
//                     ? `
//                     <button onclick="acceptBooking(${item.id})">
//                         قبول
//                     </button>

//                     <button onclick="rejectBooking(${item.id})">
//                         رفض
//                     </button>`
                    
//                     : '-'
//                 }

//             </td>

//         </tr>

//         `;
//     });

//     document.getElementById('countBookings').innerText =
//         bookings.filter(x => x.status === 'pending').length;
// }
function renderBookings(bookings) {
    const tbody = document.getElementById('bookingsTableBody');
    if (!tbody) return;

    if (!bookings.length) {
        tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:30px;color:#777;">لا توجد طلبات حجز</td></tr>';
        document.getElementById('countBookings').innerText = 0;
        return;
    }

    tbody.innerHTML = '';
    bookings.forEach(item => {
        const statusMap = { pending: 'قيد الانتظار', accepted: 'مقبول', rejected: 'مرفوض' };
        const statusClass = { pending: 'status-pending', accepted: 'status-active', rejected: 'status-rejected' };

        let actionsHTML;
        if (item.status === 'pending') {
            actionsHTML = `
                <button class="btn-approve" onclick="acceptBooking(${item.id})"
                    style="background:linear-gradient(135deg,#27ae60,#2ecc71);color:#fff;
                           border:none;padding:7px 14px;border-radius:8px;cursor:pointer;
                           font-size:.85rem;margin-left:5px;">
                    <i class="fas fa-check"></i> قبول
                </button>
                <button class="btn-reject" onclick="rejectBooking(${item.id})"
                    style="background:linear-gradient(135deg,#e53935,#ef5350);color:#fff;
                           border:none;padding:7px 14px;border-radius:8px;cursor:pointer;font-size:.85rem;">
                    <i class="fas fa-times"></i> رفض
                </button>`;
        } else if (item.status === 'accepted') {
            actionsHTML = `
                <button onclick="openTenantsManager(${item.property_id})"
                    style="background:linear-gradient(135deg,#ff9800,#ffc107);color:#fff;
                           border:none;padding:7px 14px;border-radius:8px;cursor:pointer;font-size:.85rem;">
                    <i class="fas fa-users-cog"></i> إدارة المستأجرين
                </button>`;
        } else {
            actionsHTML = '<span style="color:#aaa;font-size:.85rem;">—</span>';
        }

        tbody.innerHTML += `
            <tr>
                <td><strong>${item.property?.title || '—'}</strong></td>
                <td>${item.tenant?.name || '—'}</td>
                <td>${item.tenant?.phone || '—'}</td>
                <td>
                    <span class="status-badge ${statusClass[item.status] || 'status-pending'}">
                        ${statusMap[item.status] || item.status}
                    </span>
                </td>
                <td><div style="display:flex;gap:6px;align-items:center;">${actionsHTML}</div></td>
            </tr>`;
    });

    document.getElementById('countBookings').innerText =
        bookings.filter(x => x.status === 'pending').length;
}
async function openTenantsManager(propertyId) {
    // جلب كل الحجوزات المقبولة لهذا العقار
    const data     = await apiFetch('/owner/bookings');
    const all      = data.data || [];
    const tenants  = all.filter(b => b.property_id === propertyId && b.status === 'accepted');
    const propTitle = tenants[0]?.property?.title || 'العقار';

    // بناء المودال
    let existing = document.getElementById('tenantsManagerModal');
    if (existing) existing.remove();

    const modal = document.createElement('div');
    modal.id = 'tenantsManagerModal';
    modal.style.cssText = `
        position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;
        display:flex;align-items:center;justify-content:center;padding:20px;`;

    const tenantsRows = tenants.length ? tenants.map(b => `
        <tr>
            <td style="padding:10px;">${b.tenant?.name || '—'}</td>
            <td style="padding:10px;">${b.tenant?.email || '—'}</td>
            <td style="padding:10px;">${b.tenant?.phone || '—'}</td>
            <td style="padding:10px;">${b.created_at ? new Date(b.created_at).toLocaleDateString('ar-SY') : '—'}</td>
            <td style="padding:10px;">
                <button onclick="removeTenant(${b.id}, ${propertyId})"
                    style="background:linear-gradient(135deg,#e53935,#ef5350);color:#fff;
                           border:none;padding:6px 14px;border-radius:8px;cursor:pointer;font-size:.85rem;">
                    <i class="fas fa-user-minus"></i> إزالة
                </button>
            </td>
        </tr>`).join('') : `
        <tr><td colspan="5" style="text-align:center;padding:20px;color:#777;">
            لا يوجد مستأجرون حالياً
        </td></tr>`;

    modal.innerHTML = `
        <div style="background:#fff;border-radius:16px;width:100%;max-width:700px;
                    max-height:80vh;overflow-y:auto;box-shadow:0 20px 60px rgba(0,0,0,.3);">
            <div style="padding:20px 24px;border-bottom:1px solid #eee;display:flex;
                        justify-content:space-between;align-items:center;">
                <h3 style="margin:0;color:#333;">
                    <i class="fas fa-users" style="color:#8B7FD2;margin-left:8px;"></i>
                    مستأجرو: ${propTitle}
                </h3>
                <button onclick="document.getElementById('tenantsManagerModal').remove()"
                    style="background:none;border:none;font-size:1.4rem;cursor:pointer;color:#999;">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div style="padding:20px;">
                <table style="width:100%;border-collapse:collapse;">
                    <thead>
                        <tr style="background:#f8f9ff;">
                            <th style="padding:10px;text-align:right;font-size:.9rem;color:#555;">الاسم</th>
                            <th style="padding:10px;text-align:right;font-size:.9rem;color:#555;">البريد</th>
                            <th style="padding:10px;text-align:right;font-size:.9rem;color:#555;">الهاتف</th>
                            <th style="padding:10px;text-align:right;font-size:.9rem;color:#555;">تاريخ الحجز</th>
                            <th style="padding:10px;text-align:right;font-size:.9rem;color:#555;">إجراء</th>
                        </tr>
                    </thead>
                    <tbody>${tenantsRows}</tbody>
                </table>
            </div>
        </div>`;

    document.body.appendChild(modal);
    modal.addEventListener('click', e => { if (e.target === modal) modal.remove(); });
}

async function removeTenant(bookingId, propertyId) {
    if (!confirm('إزالة هذا المستأجر؟ سيتم تحرير مكانه في العقار.')) return;
    try {
        await apiFetch(`/owner/bookings/${bookingId}/reject`, { method: 'PATCH' });
        alert('✅ تم إزالة المستأجر وتحرير المكان');
        document.getElementById('tenantsManagerModal')?.remove();
        loadDashboard();
    } catch(e) { alert('❌ ' + e.message); }
}
async function loadBookings() {

    const data =
        await apiFetch('/owner/bookings');

    renderBookings(data.data || []);
}
async function acceptBooking(id) {

    await apiFetch(
        `/owner/bookings/${id}/accept`,
        {
            method: 'PATCH'
        }
    );

    loadBookings();
}
// async function acceptBooking(id) {
//     if (!confirm('هل أنت متأكد من قبول هذا الطلب؟')) return;
//     try {
//         await apiFetch(`/owner/bookings/${id}/accept`, { method: 'PATCH' });
//         alert('✅ تم قبول الطلب');
//         loadDashboard(); // بدل loadBookings لتحديث العداد أيضاً
//     } catch(e) { alert('فشل: ' + e.message); }
// }


async function rejectBooking(id) {

    await apiFetch(`/owner/bookings/${bookingId}/remove`, { method: 'PATCH' });

    loadBookings();
}
// async function rejectBooking(id) {
//     if (!confirm('هل أنت متأكد من رفض هذا الطلب؟')) return;
//     try {
//         await apiFetch(`/owner/bookings/${id}/reject`, { method: 'PATCH' });
//         alert('✅ تم رفض الطلب');
//         loadDashboard();
//     } catch(e) { alert('فشل: ' + e.message); }
// }
    // ── main load ────────────────────────────────────────────────
    async function loadDashboard() {
        try {
            // جلب عقارات المالك
            const propData = await apiFetch('/owner/properties?per_page=100');
            const allProps = propData.data || [];
            const pending  = allProps.filter(p => p.status === 'pending');

            renderPendingTable(pending);
            renderAllProperties(allProps);

            // جلب طلبات التواصل
            let messages = [];
            try {
                const msgData = await apiFetch('/owner/contact-requests');
                messages = msgData.data || [];
            } catch (_) {}

            renderContactRequests(messages);
            updateCounters(allProps, messages.length);
            await loadBookings();

        } catch (e) {
            console.error('خطأ في تحميل البيانات:', e);
            document.getElementById('pendingTableBody').innerHTML =
                `<tr><td colspan="5" style="text-align:center;padding:20px;color:#e74c3c;">خطأ في تحميل البيانات: ${e.message}</td></tr>`;
        }
    }

    // ── section switching ────────────────────────────────────────
    function switchSection(sectionId) {
        document.querySelectorAll('.sidebar-nav a[data-section]').forEach(a => {
            a.classList.toggle('active', a.dataset.section === sectionId);
        });
        document.querySelectorAll('.section-panel').forEach(p => {
            p.classList.toggle('active', p.id === sectionId);
        });
        // عند فتح طلبات المراسلة → صفّر العداد
    if (sectionId === 'messages') {
        const badge = document.getElementById('sidebarMessageCount');
        if (badge) badge.style.display = 'none';
        document.getElementById('countMessages').innerText = '0';
    }
    if (sectionId === 'messages') {
    sessionStorage.setItem('messagesRead', 'true');
    const badge = document.getElementById('sidebarMessageCount');
    if (badge) badge.style.display = 'none';
}
    }
    window.switchSection = switchSection;

    // ── init ─────────────────────────────────────────────────────
   document.addEventListener('DOMContentLoaded', function () {
    const user = checkAuth();
    if (!user) return;
    
    // إخفاء أقسام المالك وإظهار رسالة المستأجر إذا كان مستأجراً
    if (user.role === 'tenant') {
        document.querySelector('.content-area .urgent-alerts').style.display = 'none';
        document.querySelector('.section-panel#dashboard').style.display = 'none';
        document.querySelector('.section-panel#messages').style.display = 'none';
        document.querySelector('.section-panel#properties').style.display = 'none';
        
        // إظهار الـ div الذي أضفناه
        document.getElementById('tenantPlaceholder').style.display = 'block';
        return; // توقف عن تحميل البيانات الخاصة بالمالك
    }

    if(user.role === 'admin'){
        window.location.href = 'admin.html';
        return;
    }
        renderProfile(user);

        // nav links
        document.querySelectorAll('.sidebar-nav a[data-section]').forEach(link => {
            link.addEventListener('click', function (e) {
                if (this.classList.contains('return-site-btn')) return;
                e.preventDefault();
                switchSection(this.dataset.section);
            });
        });

        // card clicks
        document.getElementById('cardActiveProperties').addEventListener('click', () => switchSection('properties'));
        // البطاقة الثانية (pending) تبقى في لوحة التحكم الرئيسية
        document.getElementById('cardPendingProperties').addEventListener('click', () => switchSection('dashboard'));
        document.getElementById('cardMessagesRequests').addEventListener('click',  () => switchSection('messages'));
        document.getElementById('cardBookings').addEventListener('click', () => switchSection('bookings')
);

        // logout
        document.querySelectorAll('.logout-btn').forEach(btn => btn.addEventListener('click', () => {
            if (confirm('هل أنت متأكد من تسجيل الخروج؟')) {
                ['authToken','user','userData','userEmail','userType','isLoggedIn'].forEach(k => localStorage.removeItem(k));
                window.location.href = 'home.html';
            }
        }));

        // hamburger
        const hamburger = document.getElementById('adminHamburger');
        const sidebar   = document.querySelector('.sidebar');
        if (hamburger && sidebar) {
            hamburger.addEventListener('click', e => { e.stopPropagation(); hamburger.classList.toggle('active'); sidebar.classList.toggle('active'); });
            document.addEventListener('click', e => { if (!sidebar.contains(e.target) && !hamburger.contains(e.target)) { hamburger.classList.remove('active'); sidebar.classList.remove('active'); } });
        }

        loadDashboard();
    });
    </script>
</body>
</html>


