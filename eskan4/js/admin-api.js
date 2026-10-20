const ADMIN_API = 'http://localhost:8000/api';

// ─────────────────────────────────────────────────────────
// Helper
// ─────────────────────────────────────────────────────────
async function adminFetch(endpoint, options = {}) {
    const token = localStorage.getItem('authToken');
    if (!token) throw new Error('لم يتم تسجيل الدخول');

    const headers = {
        'Accept': 'application/json',
        'Authorization': `Bearer ${token}`,
        ...options.headers,
    };

    if (options.body && typeof options.body === 'object' && !(options.body instanceof FormData)) {
        headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(options.body);
    }

    const res = await fetch(`${ADMIN_API}${endpoint}`, { method: 'GET', ...options, headers });

    if (res.status === 403) throw new Error('غير مصرح - يجب أن تكون أدمناً');
    if (res.status === 401) {
        localStorage.clear();
        window.location.href = 'home.html';
        throw new Error('انتهت صلاحية الجلسة');
    }
    if (!res.ok) {
        const err = await res.json().catch(() => ({}));
        throw new Error(err.message || `HTTP ${res.status}`);
    }

    return res.json();
}

// ─────────────────────────────────────────────────────────
// Check Admin Auth on Page Load
// ─────────────────────────────────────────────────────────
function checkAdminAuth() {
    const token = localStorage.getItem('authToken');
    const user  = JSON.parse(localStorage.getItem('user') || 'null');

    if (!token || !user) {
        alert('يجب تسجيل الدخول كمدير للوصول لهذه الصفحة');
        window.location.href = 'home.html';
        return false;
    }
    if (user.role !== 'admin') {
        alert('غير مصرح لك بالوصول لهذه الصفحة');
        window.location.href = 'home.html';
        return false;
    }


const nameEl = document.getElementById('adminName');
if (nameEl) nameEl.textContent = user.name || 'المدير';

const roleEl = document.getElementById('adminRole') 
            || document.querySelector('.admin-role, .user-role, .profile-role');
if (roleEl) roleEl.textContent = 'مدير النظام';
}

// ─────────────────────────────────────────────────────────
// Render Properties Table
// ─────────────────────────────────────────────────────────
function getImageUrl(path) {
    if (!path) return '';
    if (path.startsWith('http')) return path;
    return `http://localhost:8000/storage/${path}`;
}

function renderPropertiesTable(properties, tableBodyId) {
    const tbody = document.getElementById(tableBodyId);
    if (!tbody) return;

    if (properties.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="7" style="text-align:center;padding:40px;color:#888;">
                    لا توجد عقارات
                </td>
            </tr>`;
        return;
    }

    tbody.innerHTML = properties.map(p => {
        const images  = p.images || [];
        const mainImg = images.find(i => i.is_main) || images[0];
        const imgSrc  = mainImg ?(mainImg.image_url || getImageUrl(mainImg.image_path)) : '';

        return `
        <tr data-id="${p.id}">
            <td>
                ${imgSrc ? `<img src="${imgSrc}" style="width:60px;height:45px;object-fit:cover;border-radius:6px;">` : '-'}
            </td>
            <td>${p.title}</td>
            <td>${p.city} - ${p.region || ''}</td>
            <td>${Number(p.price).toLocaleString('ar-SA')} ريال</td>
            <td>${p.owner?.name || 'غير معروف'}</td>
            <td>
                <span class="status-badge status-${p.status}">
                    ${p.status === 'pending' ? 'قيد المراجعة' : p.status === 'approved' ? 'مقبول' : 'مرفوض'}
                </span>
            </td>
            <td>
                ${p.status === 'pending' ? `
                    <button class="btn-approve" onclick="handleApprove(${p.id})">
                        <i class="fas fa-check"></i> قبول
                    </button>
                    <button class="btn-reject" onclick="handleReject(${p.id})">
                        <i class="fas fa-times"></i> رفض
                    </button>
                ` : `<span style="color:#888;font-size:0.85rem;">تمت المعالجة</span>`}
            </td>
        </tr>`;
    }).join('');
}

// ─────────────────────────────────────────────────────────
// Load Properties by Status
// ─────────────────────────────────────────────────────────
let currentStatus = 'pending';
let currentPage   = 1;

async function loadAdminProperties(status = 'pending', page = 1) {
    currentStatus = status;
    currentPage   = page;

    const tableBody    = 'propertiesTableBody';
    const paginationEl = document.getElementById('pagination');
    const tableEl      = document.getElementById('propertiesTable') ||
                         document.querySelector('.properties-table-wrapper');

    // Show loading
    const tbody = document.getElementById(tableBody);
    if (tbody) {
        tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;padding:30px;">
            <i class="fas fa-spinner fa-spin fa-2x" style="color:#8B7FD2;"></i>
        </td></tr>`;
    }

    try {
        const data       = await adminFetch(`/admin/properties?status=${status}&page=${page}`);
        const properties = data.data || [];

        // Load images for each property (owner info)
        // نحمّل كل عقار مع images (الباك يُرجع data.data pagination)
        renderPropertiesTable(properties, tableBody);

        // Pagination
        if (paginationEl && data.last_page > 1) {
            paginationEl.innerHTML = '';
            for (let i = 1; i <= data.last_page; i++) {
                const btn = document.createElement('button');
                btn.textContent = i;
                btn.className   = 'page-btn' + (i === data.current_page ? ' active' : '');
                btn.onclick     = () => loadAdminProperties(status, i);
                paginationEl.appendChild(btn);
            }
            paginationEl.style.display = 'flex';
        } else if (paginationEl) {
            paginationEl.style.display = 'none';
        }

    } catch (e) {
        if (tbody) {
            tbody.innerHTML = `<tr><td colspan="7" style="text-align:center;padding:30px;color:#e53935;">
                خطأ: ${e.message}
            </td></tr>`;
        }
    }
}

// ─────────────────────────────────────────────────────────
// Load Pending Count (للـ badge)
// ─────────────────────────────────────────────────────────
async function loadPendingCount() {
    try {
        const data  = await adminFetch('/admin/properties/pending-count');
        const count = data.count || 0;

        // تحديث كل الـ badges
        document.querySelectorAll('.pending-count, #pendingCount').forEach(el => {
            el.textContent = count;
            el.style.display = count > 0 ? 'inline-block' : 'none';
        });
    } catch (_) {}
}

// ─────────────────────────────────────────────────────────
// Approve / Reject Handlers
// ─────────────────────────────────────────────────────────
async function handleApprove(id) {
    if (!confirm('هل تريد قبول هذا العقار؟')) return;

    const row = document.querySelector(`tr[data-id="${id}"]`);
    if (row) {
        const actionCell = row.querySelector('td:last-child');
        if (actionCell) actionCell.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
    }

    try {
        await adminFetch(`/admin/properties/${id}/approve`, { method: 'PATCH' });
        showAdminToast('✅ تم قبول العقار بنجاح', 'success');

        // إزالة الصف من الجدول أو إعادة التحميل
        setTimeout(() => loadAdminProperties(currentStatus, currentPage), 800);
        await loadPendingCount();

    } catch (e) {
        showAdminToast('❌ فشل القبول: ' + e.message, 'error');
        if (row) loadAdminProperties(currentStatus, currentPage);
    }
}

async function handleReject(id) {
    if (!confirm('هل تريد رفض هذا العقار؟')) return;

    const row = document.querySelector(`tr[data-id="${id}"]`);
    if (row) {
        const actionCell = row.querySelector('td:last-child');
        if (actionCell) actionCell.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
    }

    try {
        await adminFetch(`/admin/properties/${id}/reject`, { method: 'PATCH' });
        showAdminToast('✅ تم رفض العقار', 'success');

        setTimeout(() => loadAdminProperties(currentStatus, currentPage), 800);
        await loadPendingCount();

    } catch (e) {
        showAdminToast('❌ فشل الرفض: ' + e.message, 'error');
        if (row) loadAdminProperties(currentStatus, currentPage);
    }
}

// ─────────────────────────────────────────────────────────
// Toast Notification
// ─────────────────────────────────────────────────────────
function showAdminToast(msg, type = 'success') {
    const toast = document.createElement('div');
    toast.textContent = msg;
    toast.style.cssText = `
        position:fixed; top:20px; left:50%; transform:translateX(-50%);
        background:${type === 'success' ? '#4caf50' : '#e53935'};
        color:#fff; padding:12px 24px; border-radius:8px;
        box-shadow:0 4px 12px rgba(0,0,0,0.2); z-index:9999;
        font-size:0.95rem; transition:opacity .3s;`;
    document.body.appendChild(toast);
    setTimeout(() => { toast.style.opacity = '0'; setTimeout(() => toast.remove(), 300); }, 3000);
}

// ─────────────────────────────────────────────────────────
// Filter Tabs (pending / approved / rejected)
// ─────────────────────────────────────────────────────────
function initFilterTabs() {
    document.querySelectorAll('[data-status-filter]').forEach(btn => {
        btn.addEventListener('click', function () {
            document.querySelectorAll('[data-status-filter]').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            loadAdminProperties(this.dataset.statusFilter, 1);
        });
    });
}

// ─────────────────────────────────────────────────────────
// Admin Logout
// ─────────────────────────────────────────────────────────
function adminLogout() {
    const token = localStorage.getItem('authToken');

    // نستدعي logout API
    if (token) {
        fetch(`${ADMIN_API}/auth/logout`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
        }).finally(() => {
            localStorage.clear();
            window.location.href = 'home.html';
        });
    } else {
        localStorage.clear();
        window.location.href = 'home.html';
    }
}

// ─────────────────────────────────────────────────────────
// Init
// ─────────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
    if (!checkAdminAuth()) return;

    initFilterTabs();

    // ربط زر الخروج
    document.querySelectorAll('.logout-btn, #logoutBtn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            if (confirm('هل تريد تسجيل الخروج؟')) adminLogout();
        });
    });

    // تحميل البيانات الأولية
    await Promise.all([
        loadAdminProperties('pending', 1),
        loadPendingCount(),
    ]);
});

// Expose globals للـ onclick handlers في HTML
window.handleApprove = handleApprove;
window.handleReject  = handleReject;
window.loadAdminProperties = loadAdminProperties;
