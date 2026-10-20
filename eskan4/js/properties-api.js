
// const PROPS_API_BASE = 'http://localhost:8000/api';
window.API_BASE_URL = window.API_BASE_URL || 'http://localhost:8000/api';

// ─────────────────────────────────────────────────────
// Fetch Properties from API
// ─────────────────────────────────────────────────────
async function fetchPropertiesFromAPI(filters = {}) {
    const params = new URLSearchParams();
    Object.entries(filters).forEach(([k, v]) => {
        if (v !== null && v !== undefined && v !== '') params.set(k, v);
    });

    const res = await fetch(`${PROPS_API_BASE}/properties?${params.toString()}`, {
        headers: { 'Accept': 'application/json' }
    });

    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return res.json();
}

// ─────────────────────────────────────────────────────
// Get Image URL
// ─────────────────────────────────────────────────────
function propImageUrl(path) {
    if (!path) return `data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="280" height="200">
        <rect fill="%23f5f5f5" width="280" height="200"/>
        <text fill="%23bbb" x="50%" y="50%" text-anchor="middle" dominant-baseline="middle" font-size="13">لا توجد صورة</text>
    </svg>`;
    if (path.startsWith('http')) return path;
    return `http://localhost:8000/storage/${path}`;
}

// ─────────────────────────────────────────────────────
// Render Cards (compatible with existing CSS classes)
// ─────────────────────────────────────────────────────
function renderCards(properties) {
    const grid = document.getElementById('propertiesGrid');
    if (!grid) return;

    if (properties.length === 0) {
        grid.innerHTML = `
            <div class="no-results" style="grid-column:1/-1;text-align:center;padding:60px;color:#888;">
                <i class="fas fa-search fa-3x" style="opacity:0.3;margin-bottom:16px;"></i>
                <h3>لا توجد نتائج</h3>
                <p>حاول تغيير معايير البحث</p>
            </div>`;
        return;
    }

    grid.innerHTML = properties.map(p => {
        const images  = p.images || [];
        const mainImg = images.find(i => i.is_main) || images[0];
        const imgSrc  = mainImg
            ? (mainImg.image_url || propImageUrl(mainImg.image_path))
            : propImageUrl(null);

        const discountBadge = p.has_student_discount && p.student_discount_percentage
            ? `<div class="discount-badge">خصم ${p.student_discount_percentage}%</div>`
            : '';

        const studentBadge = p.is_student_friendly
            ? `<div class="student-badge"><i class="fas fa-graduation-cap"></i> طلابي</div>`
            : '';

        return `
        <article class="property-card" onclick="openPropertyDetail(${p.id})" style="cursor:pointer;">
            <div class="card-image-wrapper" style="position:relative;overflow:hidden;">
                <img src="${imgSrc}"
                     alt="${p.title}"
                     class="card-image"
                     style="width:100%;height:200px;object-fit:cover;"
                     onerror="this.src='${propImageUrl(null)}'">
                <div style="position:absolute;top:10px;right:10px;display:flex;flex-direction:column;gap:5px;">
                    ${studentBadge}
                    ${discountBadge}
                </div>
            </div>
            <div class="card-body" style="padding:16px;">
                <h3 class="card-title" style="margin:0 0 6px;font-size:1rem;font-weight:600;">${p.title}</h3>
                <p class="card-location" style="margin:0 0 8px;color:#666;font-size:0.85rem;">
                    <i class="fas fa-map-marker-alt" style="color:#8B7FD2;"></i>
                    ${p.city}${p.district ? ' - ' + p.district : ''}
                </p>
                <div class="card-features" style="display:flex;gap:14px;color:#888;font-size:0.82rem;margin-bottom:12px;">
                    <span><i class="fas fa-bed"></i> ${p.rooms_count || p.bedrooms || '-'}</span>
             
                    ${p.area ? `<span><i class="fas fa-ruler-combined"></i> ${p.area} م²</span>` : ''}
                </div>
                <div style="display:flex;align-items:center;justify-content:space-between;">
                    <span class="card-price" style="color:#8B7FD2;font-weight:700;font-size:1.05rem;">
                        ${Number(p.price).toLocaleString('ar-SA')} <small style="font-size:0.75rem;font-weight:400;color:#999;">ريال/شهر</small>
                    </span>
                    <button class="btn-detail"
                            onclick="event.stopPropagation();openPropertyDetail(${p.id})"
                            style="padding:6px 14px;background:#8B7FD2;color:#fff;border:none;
                                   border-radius:8px;cursor:pointer;font-size:0.82rem;">
                        التفاصيل
                    </button>
                </div>
            </div>
        </article>`;
    }).join('');
}

// ─────────────────────────────────────────────────────
// Open Property Detail
// ─────────────────────────────────────────────────────
function openPropertyDetail(id) {
    window.location.href = `property-card.html?id=${id}`;
}

// ─────────────────────────────────────────────────────
// Get current filters from DOM
// ─────────────────────────────────────────────────────
function getFilters() {
    return {
        q:             document.getElementById('q')?.value?.trim() || '',
        city:          document.getElementById('city')?.value || '',
        region:        document.getElementById('region')?.value || '',
        property_type: document.getElementById('property_type')?.value ||
                       document.getElementById('type')?.value || '',
        rooms_count:   document.getElementById('rooms_count')?.value ||
                       document.getElementById('rooms')?.value || '',
        min_price:     document.getElementById('min_price')?.value || '',
        max_price:     document.getElementById('max_price')?.value || '',
        is_student_friendly: document.getElementById('is_student_friendly')?.value || '',
        has_student_discount: document.getElementById('has_student_discount')?.value || '',
        university_id: document.getElementById('university_id')?.value || '',
        per_page: 12,
    };
}

// ─────────────────────────────────────────────────────
// Pagination
// ─────────────────────────────────────────────────────
let currentPropsPage = 1;
let lastMeta = null;

function renderPagination(meta) {
    lastMeta = meta;
    const el = document.getElementById('pagination') ||
               document.getElementById('paginationContainer');
    if (!el || !meta || meta.last_page <= 1) {
        if (el) el.innerHTML = '';
        return;
    }

    let html = '';
    if (meta.current_page > 1) {
        html += `<button onclick="goToPage(${meta.current_page - 1})" class="page-btn">
                     <i class="fas fa-chevron-right"></i>
                 </button>`;
    }

    const start = Math.max(1, meta.current_page - 2);
    const end   = Math.min(meta.last_page, meta.current_page + 2);

    for (let i = start; i <= end; i++) {
        html += `<button onclick="goToPage(${i})"
                         class="page-btn ${i === meta.current_page ? 'active' : ''}">
                     ${i}
                 </button>`;
    }

    if (meta.current_page < meta.last_page) {
        html += `<button onclick="goToPage(${meta.current_page + 1})" class="page-btn">
                     <i class="fas fa-chevron-left"></i>
                 </button>`;
    }

    el.innerHTML = html;
}

async function goToPage(page) {
    currentPropsPage = page;
    await loadAndRender();
    window.scrollTo({ top: 0, behavior: 'smooth' });
}
window.goToPage = goToPage;
const API_BASE_URL = 'http://localhost:8000/api';

async function loadAndRender() {
    const container = document.getElementById('propertiesContainer') || document.getElementById('properties-container');
    if (container) {
        // إظهار مؤشر تحميل بسيط لحين وصول البيانات
        container.innerHTML = '<div style="text-align:center; padding:20px; color:#8B7FD2;"><i class="fas fa-spinner fa-spin fa-2x"></i> جاري تحميل العقارات الحقيقية...</div>';
    }

    try {
        // جلب البيانات من مسار العقارات العامة المعتمد في لارافل
        const response = await fetch(`${API_BASE_URL}/properties`, {
            headers: { 'Accept': 'application/json' }
        });
        
        if (!response.ok) throw new Error(`HTTP Error! Status: ${response.status}`);
        
        const data = await response.json();
        
        // لارافل يرجع البيانات بداخل كائن دائرى الباجينشن data.data
        const propertiesList = data.data || [];

        // مسح العناصر الوهمية والبدء بالرسم الحقيقي بنفس ستايلاتك
        container.innerHTML = ''; 

        if (propertiesList.length === 0) {
            container.innerHTML = '<p style="text-align:center; color:#888; width:100%;">لا توجد عقارات متاحة حالياً في قاعدة البيانات.</p>';
            return;
        }

        propertiesList.forEach(prop => {
            // التحقق من وجود صور للعقار، الباك إند يرجع مصفوفة images
            const images = prop.images || [];
            // إيجاد الصورة الرئيسية أو أخذ الصورة الأولى
            const mainImg = images.find(i => i.is_main) || images[0];
            // بناء مسار الصورة الصحيح طبقاً لملفك المرفق
            const imgSrc = mainImg ? `http://localhost:8000/storage/${mainImg.image_path}` : 'placeholder.svg';

            const card = document.createElement('div');
            card.className = 'property-card'; // نفس كلاس الستايلات الحالي لديك

            card.innerHTML = `
                <img src="${imgSrc}" alt="${prop.title}" class="property-img" onerror="this.src='placeholder.svg'">
                <div class="property-info">
                    <h3 class="property-title">${prop.title}</h3>
                    <p class="property-price">${Number(prop.price).toLocaleString('ar-SA')} ريال / سنوي</p>
                    <p class="property-location"><i class="fas fa-map-marker-alt"></i> ${prop.city} ${prop.region ? '- ' + prop.region : ''}</p>
                    <div class="property-features">
                        <span><i class="fas fa-bed"></i> ${prop.rooms_count || 0} غرف</span>
                   
                    </div>
                    ${prop.has_student_discount == '1' || prop.has_student_discount === true ? '<span class="discount-badge">خصم للطلاب</span>' : ''}
                    <a href="property-details.html?id=${prop.id}" class="btn-details">عرض التفاصيل</a>
                </div>
            `;
            container.appendChild(card);
        });

    } catch (error) {
        console.error("خطأ أثناء جلب البيانات الفعلي:", error);
        if (container) {
            container.innerHTML = '<p style="text-align:center; color:#e53935;">عذراً، فشل الاتصال بالسيرفر وجلب العقارات.</p>';
        }
    }
}
window.loadAndRender = loadAndRender;

// ─────────────────────────────────────────────────────
// Populate City/Region dropdowns from API (dynamic)
// ─────────────────────────────────────────────────────
async function populateCityDropdown() {
    // اجلب العقارات ليرتفع خياراتك الواقعية
    // (بديل: يمكنك hard-code المدن الرئيسية)
    const cities = ['الرياض','جدة','مكة المكرمة','المدينة المنورة','الدمام','الخبر',
                    'الظهران','الطائف','تبوك','أبها','بريدة','حائل','الجوف','نجران'];

    const cityEl = document.getElementById('city');
    if (cityEl && cityEl.options.length <= 1) {
        cities.forEach(c => {
            const opt = document.createElement('option');
            opt.value = c; opt.textContent = c;
            cityEl.appendChild(opt);
        });
    }
}

// ─────────────────────────────────────────────────────
// Init
// ─────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', async () => {
    // استبدال propertiesData بالبيانات الحقيقية
    // (لا نحتاج propertiesData بعد الآن)

    await populateCityDropdown();

    // Bind filters
    const filterIds = ['q','city','region','property_type','type','rooms_count',
                       'rooms','min_price','max_price','is_student_friendly',
                       'has_student_discount','university_id'];

    filterIds.forEach(id => {
        const el = document.getElementById(id);
        if (!el) return;
        if (id === 'q') {
            el.addEventListener('input', debounceProps(() => {
                currentPropsPage = 1;
                loadAndRender();
            }, 500));
        } else {
            el.addEventListener('change', () => {
                currentPropsPage = 1;
                loadAndRender();
            });
        }
    });

    // زر البحث
    document.getElementById('searchBtn')?.addEventListener('click', () => {
        currentPropsPage = 1;
        loadAndRender();
    });

    // زر إعادة الضبط
    document.getElementById('resetBtn')?.addEventListener('click', () => {
        filterIds.forEach(id => {
            const el = document.getElementById(id);
            if (el) el.value = '';
        });
        currentPropsPage = 1;
        loadAndRender();
    });

    // التحميل الأولي
    await loadAndRender();
});

function debounceProps(fn, wait) {
    let t;
    return (...a) => { clearTimeout(t); t = setTimeout(() => fn(...a), wait); };
}

window.openPropertyDetail = openPropertyDetail;
