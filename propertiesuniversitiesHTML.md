<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تصفح العقارات - مرتبط بالجامعة</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/site.css">
    <link rel="stylesheet" href="style/properties.css">
        <!-- <link rel="stylesheet" href="style/property-card.css"> -->
    <link rel="stylesheet" href="style/nav.css">
</head>
<body>
    <div id="navbar-container"></div>

    <header class="page-header">
        <h1>تصفح خدمتنا الطلابية</h1>
        <p>تصفح عروضنا الطلابية التي ستقوم بتلبية كافة متطلباتك بأقل الاسعار</p>
    </header>

    <main class="container">
        <div class="search-row">
            <input type="text" id="q" placeholder="ابحث باسم، مدينة، أو ميزة" oninput="applyFiltersAndUpdateUrl()">
         
            <!-- Combo Box المحافظات -->
            <div class="combo-container" style="position: relative; min-width: 150px;">
                <input type="text" id="city" list="cities-list" placeholder="اختر/اكتب المحافظة" oninput="updateRegionsFilter(); applyFiltersAndUpdateUrl()" autocomplete="off">
                <datalist id="cities-list">
                    <option value="دمشق"></option>
                    <option value="ريف دمشق"></option>
                    <option value="حلب"></option>
                    <option value="حمص"></option>
                    <option value="حماة"></option>
                    <option value="اللاذقية"></option>
                    <option value="طرطوس"></option>
                    <option value="إدلب"></option>
                    <option value="دير الزور"></option>
                    <option value="الرقة"></option>
                    <option value="الحسكة"></option>
                    <option value="درعا"></option>
                    <option value="السويداء"></option>
                    <option value="القنيطرة"></option>
                </datalist>
            </div>

            <!-- Combo Box المناطق (يتغير ديناميكياً حسب المحافظة المختارة) -->
            <div class="combo-container" style="position: relative; min-width: 150px;">
                <input type="text" id="region" list="regions-list" placeholder="اختر/اكتب المنطقة" oninput="applyFiltersAndUpdateUrl()" autocomplete="off">
                <datalist id="regions-list">
                    <!-- يتم تعبئته تلقائياً بالجافاسكريبت -->
                </datalist>
            </div>

            <select id="type" onchange="applyFiltersAndUpdateUrl()">
                <option value="">كل أنواع العقارات</option>
                <option value="villa">فيلا</option>
                <option value="house">منزل عادي</option>
                <option value="shared">منزل مشترك</option>
            </select>
            <select id="rooms" onchange="applyFiltersAndUpdateUrl()">
                <option value="">كل عدد الغرف</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6+</option>
            </select>
            <select id="divisionCount" onchange="applyFiltersAndUpdateUrl()">
                <option value="">كل العقارات</option>
                <option value="">لا يقبل التقسيم</option>
                <option value="2">2 أشخاص</option>
                <option value="3">3 أشخاص</option>
                <option value="4">4 أشخاص</option>
                <option value="5">5 أشخاص</option>
                <option value="6">6+ أشخاص</option>
            </select>
            <div style="display:flex; flex-direction:row; min-width:200px; gap:4px;">
                <span class="filter-label">ارتباطه بالجامعة</span>
                <select id="linkedUniversity" onchange="applyFiltersAndUpdateUrl()">
                    <option value="">كل الجامعات</option>
                    <!-- <option value="الهمك">الهمك</option>
                    <option value="الاداب">الاداب</option>
                    <option value="الكلية المدنية">الكلية المدنية</option>
                    <option value="none">غير مرتبط</option> -->
                </select>
            </div>
            <select id="discount" onchange="applyFiltersAndUpdateUrl()">
                <option value="">كل قيم الخصم</option>
                <option value="0">بدون خصم</option>
                <option value="1-9">خصم 1-9%</option>
                <option value="10-14">خصم 10-14%</option>
                <option value="15+">خصم 15% أو اكثر</option>
            </select>
            <input type="number" id="min_price" placeholder="السعر الأدنى" style="max-width:140px;" oninput="applyFiltersAndUpdateUrl()">
            <input type="number" id="max_price" placeholder="السعر الأقصى" style="max-width:140px;" oninput="applyFiltersAndUpdateUrl()">
            <button onclick="applyFiltersAndUpdateUrl()"><i class="fas fa-filter"></i> فلتر</button>
        </div>

        <section class="grid" id="propertiesGrid"></section>
    </main>

    <div id="popup-container"></div>
    <div id="footer-container"></div>
<!-- 
    // ✔ هذا بيمنع api-integration.js من تشغيل renderPropertyCard القديمة
window.renderPropertyCard = null; -->
 <script>
// const API_BASE_URL = 'http://localhost:8000/api';
window.API_BASE_URL = window.API_BASE_URL || 'http://localhost:8000/api';

let propertiesData = [];
const cityTranslation = {
    'damascus': 'دمشق',
    'rural_damascus': 'ريف دمشق',
    'aleppo': 'حلب',
    'homs': 'حمص',
    'hama': 'حماة',
    'latakia': 'اللاذقية',
    'tartus': 'طرطوس',
    'idlib': 'إدلب',
    'deir_ezzor': 'دير الزور',
    'raqqa': 'الرقة',
    'hasakah': 'الحسكة',
    'daraa': 'درعا',
    'suwayda': 'السويداء',
    'quneitra': 'القنيطرة'
};
async function loadUniversities() {
    try {
        const res  = await fetch(`${API_BASE_URL}/universities`);
        const data = await res.json();
        const unis = data.data || data || [];
        const sel  = document.getElementById('linkedUniversity');
        unis.forEach(u => {
            const opt       = document.createElement('option');
            opt.value       = u.id;
            opt.textContent = u.name;
            sel.appendChild(opt);
        });
    } catch(e) {
        console.warn('فشل تحميل الجامعات', e);
    }
}
function translateCity(city) {
    if (!city) return '';
    return cityTranslation[city.toLowerCase()] || city;
}
// الجغرافيا السورية
const syrianGeography = {
    "دمشق": ["البرامكة","المزة","أبو رمانة","القصاع","الميدان","كفرسوسة"],
    "حلب": ["الشهباء","الفرقان","الجميلية","الحمدانية"],
    "حمص": ["الإنشاءات","الحمراء","الزهراء"],
    "اللاذقية": ["المشروع الأول","المشروع السابع","الزراعة"],
    "طرطوس": ["المشروع الرابع","الكورنيش","الغمقة"],
};

const amenitiesTranslation = {
    'parking':'موقف سيارات','elevator':'مصعد','security':'أمن وحماية',
    'garden':'حديقة','pool':'مسبح','gym':'صالة رياضية',
    'balcony':'شرفة','furnished':'مفروش'
};
const amenitiesIcons = {
    'parking':'fa-car','elevator':'fa-elevator','security':'fa-shield-alt',
    'garden':'fa-tree','pool':'fa-swimming-pool','gym':'fa-dumbbell',
    'balcony':'fa-building','furnished':'fa-couch'
};

function updateRegionsFilter() {
    const city = document.getElementById('city').value.trim();
    const list = document.getElementById('regions-list');
    const regionInput = document.getElementById('region');
    list.innerHTML = '';
    regionInput.value = '';
    if (syrianGeography[city]) {
        syrianGeography[city].forEach(r => {
            const o = document.createElement('option');
            o.value = r;
            list.appendChild(o);
        });
    }
}

function getFilters() {
    return {
        q:           document.getElementById('q')?.value.trim() || '',
        city:        document.getElementById('city')?.value.trim() || '',
        region:      document.getElementById('region')?.value.trim() || '',
        property_type: document.getElementById('type')?.value || '',
        rooms_count: document.getElementById('rooms')?.value || '',
        min_price:   document.getElementById('min_price')?.value || '',
        max_price:   document.getElementById('max_price')?.value || '',
        has_student_discount: document.getElementById('discount')?.value ? '1' : '',
    };
}

async function loadPropertiesDataFromAPI() {
    const grid = document.getElementById('propertiesGrid');
    grid.innerHTML = '<div style="text-align:center;padding:40px;color:#8B7FD2;grid-column:1/-1;"><i class="fas fa-spinner fa-spin fa-2x"></i></div>';
    try {
        const token = localStorage.getItem('authToken');
        const filters = getFilters();
        const params = new URLSearchParams({ per_page: 50, is_student_friendly: 1 });
        Object.entries(filters).forEach(([k, v]) => { if (v) params.set(k, v); });

        const headers = { 'Accept': 'application/json' };
        if (token) headers['Authorization'] = ` Bearer ${token}`;

        const res = await fetch(`${API_BASE_URL}/student/properties?${params}`, { headers });
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();
        propertiesData = data.data || [];
        console.log('properties:', propertiesData.map(p => ({id: p.id, title: p.title, current_occupants: p.current_occupants})));
        renderPropertyCards(propertiesData);
    } catch (e) {
        console.error(e);
        grid.innerHTML = '<div style="text-align:center;padding:40px;color:#e53935;grid-column:1/-1;">فشل تحميل العقارات</div>';
    }
    grid.style.display='grid';
}

function renderPropertyCards(list) {
    const grid = document.getElementById('propertiesGrid');
    grid.innerHTML = '';
    if (!list.length) {
        grid.innerHTML = '<div style="text-align:center;padding:40px;color:#999;grid-column:1/-1;">لا توجد عقارات تطابق معايير البحث</div>';
        return;
    }
    list.forEach(p => {
        const images = p.images || [];
        const mainImg = images.find(i => i.is_main) || images[0];
        const imgSrc = mainImg
            ? (mainImg.image_url || `http://localhost:8000/storage/${mainImg.image_path}`)
            : '';
        const price = Number(p.price).toLocaleString('ar-SY');
        const discount = p.has_student_discount
            ? `<span class="discount-card-badge">خصم ${parseInt(p.student_discount_percentage) || 0}% للطلاب</span>` : '';
 const uniName = p.university ? p.university.name : 'غير مرتبط بجامعة';
        const card = document.createElement('article');
        card.className = 'card';
        card.innerHTML = 
            `<div class="card-image">
                <img src="${imgSrc}" alt="${p.title}" onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22280%22 height=%22180%22><rect fill=%22%23f0f0f0%22 width=%22280%22 height=%22180%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2216%22>لا توجد صورة</text></svg>'">
                <div class="type-badge">${p.property_type || ''}</div><div class="type-badge">${propertyTypeLabel(p.property_type)}</div>
            </div>
            <div class="card-body">
                <div style="display:flex;align-items:center;gap:8px">
                    <div class="card-title">${p.title}</div>${discount}
                </div>
                <div class="card-sub">
                    <span>${translateCity(p.city)} - ${p.region || ''}</span>
                    <strong>${price} ل.س</strong>
                </div>
                <div style="margin-top:6px;display:flex;align-items:center;gap:8px;">
                    <span class="status-badge ${p.is_available ? 'status-available' : 'status-occupied'}">${p.is_available ? 'متوفر' : 'مشغول'}</span>
                    <span style="font-size:0.85rem;color:#667eea;"><i class="fas fa-university"></i> ${uniName}</span>
                </div>
                <div class="card-actions">
    ${p.division_accept === 'yes' ? `
    <div style="text-align:center;margin-bottom:8px;">
        <span style="background:${p.current_occupants >= parseInt(p.division_count) ? '#fdecea' : '#e8f5e9'};
                     color:${p.current_occupants >= parseInt(p.division_count) ? '#c62828' : '#2e7d32'};
                     padding:4px 12px;border-radius:20px;font-size:0.82rem;font-weight:600;">
            <i class="fas fa-users"></i>
            محجوز ${p.current_occupants || 0} من أصل ${p.division_count}
        </span>
    </div>` : ''}
    <button class="btn btn-view" onclick="openPropertyDetails(${p.id})">
        <i class='fas fa-eye'></i> عرض التفاصيل
    </button>
</div>
            </div>`;
        grid.appendChild(card);
    });
    grid.style.display='grid';
}
function propertyTypeLabel(type) {
    const map = {
        apartment: 'شقة',
        house: 'منزل عادي',
        villa: 'فيلا',
        office: 'مكتب',
        shop: 'محل تجاري',
        warehouse: 'مستودع',
        land: 'أرض',
        shared: 'منزل مشترك'
    };
    return map[type] ||type || '';
}
// function applyFiltersAndUpdateUrl() {
//     loadPropertiesDataFromAPI();
// }
function applyFiltersAndUpdateUrl() {
    const q         = document.getElementById('q')?.value.trim().toLowerCase() || '';
    const city      = document.getElementById('city')?.value.trim() || '';
    const region    = document.getElementById('region')?.value.trim() || '';
    const type      = document.getElementById('type')?.value || '';
    const rooms     = document.getElementById('rooms')?.value || '';
    const divCount  = document.getElementById('divisionCount')?.value || '';
    const linkedUni = document.getElementById('linkedUniversity')?.value || '';
    const discount  = document.getElementById('discount')?.value || '';
    const min       = parseFloat(document.getElementById('min_price')?.value  ||'')||  null;
    const max       = parseFloat(document.getElementById('max_price')?.value  ||'') || null;

  

    const filtered = propertiesData.filter(p => {
        if (q) {
            const hay = (
                (p.title||'') + ' ' +
                translateCity(p.city||'') + ' ' +
                (p.region||'') + ' ' +
                (p.property_type||'') + ' ' +
                (p.university?.name||'')
            ).toLowerCase();
            if (!hay.includes(q)) return false;
        }
        if (city   && translateCity(p.city) !== city)   return false;
        if (region && p.region !== region)              return false;
        if (type   && p.property_type !== type)         return false;
       if (rooms) {
        const pRooms = parseInt(p.rooms_count) || 0;
        if (rooms === '6') { if (pRooms < 6) return false; }
        else if (pRooms !== parseInt(rooms)) return false;
    }
       
        if (linkedUni) {
    if (String(p.university_id) !== String(linkedUni)) return false;
    // String() لأن أحياناً واحد number والثاني text
}
       if (divCount) {
            if (divCount === 'no') {
                if (p.division_accept === 'yes') return false;
            } else {
                if (p.division_accept !== 'yes') return false;
                if (divCount === '6') { if ((p.division_count||0) < 6) return false; }
                else if (parseInt(p.division_count) !== parseInt(divCount)) return false;
            }
        }
        if (discount) {
            const d = parseInt(p.student_discount_percentage || 0);
            if (discount === '0'     && d !== 0)        return false;
            if (discount === '1-9'   && (d<1 || d>9))  return false;
            if (discount === '10-14' && (d<10 || d>14)) return false;
            if (discount === '15+'   && d < 15)         return false;
        }
        if (min !== null && Number(p.price) < min) return false;
        if (max !== null && Number(p.price) > max) return false;
        return true;
    });

    renderPropertyCards(filtered);
}


function openPropertyDetails(id) {
    const p = propertiesData.find(x => x.id === id);
    if (!p) return;
    openPropertyModal(p);
}

function openPropertyModal(p) {
    let overlay = document.getElementById('propertyModalOverlay');
    if (overlay) overlay.remove();
    overlay = document.createElement('div');
    overlay.id = 'propertyModalOverlay';
    overlay.className = 'property-modal-overlay active';

    const images = p.images || [];
    const imageUrls = images.map(i => i.image_url || `http://localhost:8000/storage/${i.image_path}`);
    if (!imageUrls.length) imageUrls.push('');
    let currentIndex = 0;

    const price = Number(p.price).toLocaleString('ar-SY');
    const discountedPrice = p.has_student_discount && p.student_discount_percentage
        ? Number(p.price - (p.price * p.student_discount_percentage / 100)).toLocaleString('ar-SY')
        : null;
    const priceDisplay = discountedPrice
        ? `<span class="discount-price">${price} ل.س</span> <span class="final-price">${discountedPrice} ل.س</span>`
        : `${price} <span>ل.س</span>`;

    const uniName = p.university ? p.university.name : 'غير مرتبط بجامعة';
    const amenitiesArr = Array.isArray(p.amenities) ? p.amenities : [];
    const amenitiesHtml = amenitiesArr.length
        ? amenitiesArr.map(a => `<span class="amenity-tag"><i class="fas ${amenitiesIcons[a]||'fa-check'}"></i> ${amenitiesTranslation[a]||a}</span>`).join('')
        : '<span>لا توجد مزايا إضافية</span>';

    const modal = document.createElement('div');
    modal.className = 'property-modal';
    modal.innerHTML = `
        <div class="modal-scrollable">
            <div class="property-image">
                <img src="${imageUrls[0]}" id="modalMainImage" alt="${p.title}">
                <div class="image-counter" id="imageCounter">1 / ${imageUrls.length}</div>
                <div class="image-nav">
                    <button id="prevImageBtn"><i class="fas fa-chevron-right"></i></button>
 <button id="nextImageBtn"><i class="fas fa-chevron-left"></i></button>
                </div>
            </div>
            <button class="modal-close" id="modalCloseBtn"><i class="fas fa-times"></i></button>
            <div class="property-content">
                <div class="property-price">${priceDisplay}</div>
                <h2 class="property-title">${p.title}</h2>
                <div class="property-location"><i class="fas fa-map-marker-alt"></i> <span>${p.city}${p.region ? ' - '+p.region : ''}</span></div>
                <div class="university-badge"><i class="fas fa-university"></i> ${uniName}</div>
                    <div class="property-features">
                        <div class="feature-item"><i class="fas fa-ruler-combined"></i><span>${p.area||'-'} م²</span></div>
                        <div class="feature-item"><i class="fas fa-bed"></i><span>${p.rooms_count||'-'} غرف</span></div>
                        ${p.division_accept === 'yes' ? `
                        <div class="feature-item"><i class="fas fa-users"></i><span>يقبل التقسيم لـ ${p.division_count||'؟'} أشخاص</span></div>` : ''}
                        ${p.payment_method ?` 
                        <div class="feature-item">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>${{'cash':'نقدي','bank_transfer':'تحويل بنكي','check':'شيك','installments':'تقسيط'}[p.payment_method] || p.payment_method}</span>
                        </div>` : ''}
                    </div>
                <div class="property-description"><h4>وصف العقار</h4><p>${p.description||'لا يوجد وصف'}</p></div>
                <div class="amenities-section"><h4>المزايا</h4><div class="amenities-list">${amenitiesHtml}</div></div>
                ${p.owner ?` 
                <div class="contact-section"><h4>معلومات المالك</h4>
                    <div class="contact-info">
                        <div class="contact-item"><i class="fas fa-user"></i><span>${p.owner.name||'—'}</span></div>
                        <div class="contact-item"><i class="fas fa-phone"></i><span>${p.owner.phone||'—'}</span></div>
                    </div>
                </div>` : ''}
            </div>
        </div>
      <div class="modal-footer" style="display:flex;gap:10px;padding:16px;">
    <button class="btn-primary" id="showContactFormBtn" style="flex:1;">
        <i class="fas fa-envelope"></i> طلب تواصل
    </button>
    ${p.division_accept === 'yes' && p.is_available ? `
    <button id="showBookingFormBtn" style="flex:1;padding:12px;
            background:${p.current_occupants >= parseInt(p.division_count) ? '#ccc' : 'linear-gradient(135deg,#667eea,#764ba2)'};
            color:#fff;border:none;border-radius:10px;cursor:${p.current_occupants >= parseInt(p.division_count) ? 'not-allowed' : 'pointer'};
            font-family:Cairo,sans-serif;font-size:0.95rem;font-weight:600;"
            ${p.current_occupants >= parseInt(p.division_count) ? 'disabled' : ''}>
        <i class="fas fa-calendar-check"></i>
        ${p.current_occupants >= parseInt(p.division_count) ? 'العقار ممتلئ' : 'حجز مكان'}
    </button>` : ''}
</div>
<div id="bookingFormSection" style="display:none;padding:20px;border-top:1px solid #eee;">
    <h4 style="color:#333;margin-bottom:8px;">
        <i class="fas fa-calendar-check" style="color:#667eea;"></i> تأكيد طلب الحجز
    </h4>
    ${p.division_accept === 'yes' ? `
    <div style="background:#f0f4ff;border-radius:10px;padding:10px 14px;margin-bottom:14px;font-size:0.9rem;">
        <i class="fas fa-users" style="color:#667eea;"></i>
        الأماكن المتاحة: <strong>${parseInt(p.division_count) - (p.current_occupants || 0)}</strong> من أصل <strong>${p.division_count}</strong>
    </div>` : ''}
    <textarea id="bookingNote"
        style="width:100%;padding:12px;border:1px solid #ddd;border-radius:10px;
               font-family:Cairo,sans-serif;font-size:0.95rem;resize:vertical;
               min-height:80px;margin-bottom:14px;direction:rtl;"
        placeholder="ملاحظة للمالك... (اختياري)"></textarea>
    <div style="display:flex;gap:10px;">
        <button id="sendBookingBtn" style="flex:1;padding:12px;
                background:linear-gradient(135deg,#667eea,#764ba2);
                color:#fff;border:none;border-radius:10px;cursor:pointer;
                font-family:Cairo,sans-serif;font-size:0.95rem;font-weight:600;">
            <i class="fas fa-paper-plane"></i> إرسال طلب الحجز
        </button>
        <button id="cancelBookingBtn"
            style="flex:1;padding:12px;border:1px solid #ddd;border-radius:10px;
                   background:#fff;cursor:pointer;font-family:Cairo,sans-serif;">
            إلغاء
        </button>
    </div>
</div>
<div id="contactFormSection" style="display:none;padding:20px;border-top:1px solid #eee;">
    <h4 style="color:#333;margin-bottom:14px;">
        <i class="fas fa-paper-plane" style="color:#8B7FD2;"></i> 
        إرسال طلب تواصل
    </h4>
    <div class="contact-info" style="margin-bottom:14px;">
        <div class="contact-item">
            <i class="fas fa-user"></i>
            <span id="contactFormName"></span>
        </div>
        <div class="contact-item">
            <i class="fas fa-phone"></i>
            <span id="contactFormPhone"></span>
        </div>
    </div>
    <textarea id="contactFormMessage" 
        style="width:100%;padding:12px;border:1px solid #ddd;border-radius:10px;
               font-family:Cairo,sans-serif;font-size:0.95rem;resize:vertical;
               min-height:100px;margin-bottom:14px;direction:rtl;"
        placeholder="اكتب رسالتك هنا... (اختياري)"></textarea>
    <div style="display:flex;gap:10px;">
        <button id="sendContactBtn" class="btn-primary" style="flex:1;">
            <i class="fas fa-paper-plane"></i> إرسال
        </button>
        <button id="cancelContactBtn" 
            style="flex:1;padding:12px;border:1px solid #ddd;border-radius:10px;
                   background:#fff;cursor:pointer;font-family:Cairo,sans-serif;">
            إلغاء
        </button>
    </div>
</div>`

    overlay.appendChild(modal);
    document.body.appendChild(overlay);

    const mainImage = modal.querySelector('#modalMainImage');
    const counter   = modal.querySelector('#imageCounter');
    function showImage(idx) {
        currentIndex = (idx + imageUrls.length) % imageUrls.length;
        mainImage.src = imageUrls[currentIndex];
        counter.textContent = `${currentIndex+1} / ${imageUrls.length}`;
    }
    modal.querySelector('#prevImageBtn').addEventListener('click', e => { e.stopPropagation(); showImage(currentIndex-1); });
    modal.querySelector('#nextImageBtn').addEventListener('click', e => { e.stopPropagation(); showImage(currentIndex+1); });
    modal.querySelector('#modalCloseBtn').addEventListener('click', () => overlay.remove());
    overlay.addEventListener('click', e => { if (e.target === overlay) overlay.remove(); });
    // ── Contact Form Logic ──
const showContactBtn   = modal.querySelector('#showContactFormBtn');
const contactSection   = modal.querySelector('#contactFormSection');
const sendContactBtn   = modal.querySelector('#sendContactBtn');
const cancelContactBtn = modal.querySelector('#cancelContactBtn');
const msgTextarea      = modal.querySelector('#contactFormMessage');
const formName         = modal.querySelector('#contactFormName');
const formPhone        = modal.querySelector('#contactFormPhone');

const user = JSON.parse(localStorage.getItem('user') || 'null');

// if (showContactBtn) {
//     showContactBtn.addEventListener('click', () => {
//         const token = localStorage.getItem('authToken');
//         if (!token || !user) {
//             localStorage.setItem('afterLoginRedirect', window.location.href);
//             if (window.openLoginPopup) openLoginPopup();
//             return;
//         }
//         formName.textContent  = user.name  || '—';
//         formPhone.textContent = user.phone || '—';
//         contactSection.style.display = 'block';
//         showContactBtn.style.display = 'none';
//         msgTextarea.focus();
//     });
// }
if (showContactBtn) {
    showContactBtn.addEventListener('click', () => {
        const token = localStorage.getItem('authToken');

        // غير مسجّل
        if (!token || !user) {
            localStorage.setItem('afterLoginRedirect', window.location.href);
            if (window.openLoginPopup) openLoginPopup();
            return;
        }

        // admin لا يرسل طلبات
        if (user.role === 'admin') {
            alert('المدير لا يمكنه إرسال طلبات تواصل');
            return;
        }

        // صاحب العقار نفسه
        if (user.role === 'owner' && p.owner_id === user.id) {
            alert('لا يمكنك إرسال طلب تواصل لعقارك الخاص');
            return;
        }

        // ✅ الكل المتبقي يقدر يرسل
        formName.textContent  = user.name  || '—';
        formPhone.textContent = user.phone || '—';
        contactSection.style.display = 'block';
        showContactBtn.style.display = 'none';
        msgTextarea.focus();
    });
}

if (cancelContactBtn) {
    cancelContactBtn.addEventListener('click', () => {
        contactSection.style.display = 'none';
        showContactBtn.style.display = 'block';
        msgTextarea.value = '';
    });
}

if (sendContactBtn) {
    sendContactBtn.addEventListener('click', async () => {
        const token = localStorage.getItem('authToken');
        if (!token || !user) return;

        const name    = user.name  || '';
        const phone   = user.phone || '';
        const message = msgTextarea.value.trim() ||
                       ` طلب تواصل بخصوص العقار: ${p.title}`;

        if (!name || !phone) {
            alert('يجب أن يكون لديك اسم ورقم هاتف في حسابك');
            return;
        }

        sendContactBtn.disabled = true;
        sendContactBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري الإرسال...';

        try {
            const res = await fetch('http://localhost:8000/api/contact-requests', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ' + token
                },
                body: JSON.stringify({
                    property_id: p.id,
                    name, phone, message
                })
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || 'فشل الإرسال');

            contactSection.innerHTML =` 
                <div style="text-align:center;padding:20px;color:#27ae60;">
                    <i class="fas fa-check-circle fa-2x" style="margin-bottom:10px;"></i>
                    <p style="font-weight:600;">تم إرسال طلب التواصل بنجاح!</p>
                    <p style="color:#777;font-size:0.9rem;">سيتواصل معك المالك قريباً على رقم ${phone}</p>
                </div>`;
        } catch(e) {
            alert('❌ ' + e.message);
            sendContactBtn.disabled = false;
            sendContactBtn.innerHTML = '<i class="fas fa-paper-plane"></i> إرسال';
        }
    });
}
// ── Booking Form Logic ──
const showBookingBtn   = modal.querySelector('#showBookingFormBtn');
const bookingSection   = modal.querySelector('#bookingFormSection');
const sendBookingBtn   = modal.querySelector('#sendBookingBtn');
const cancelBookingBtn = modal.querySelector('#cancelBookingBtn');
const bookingNote      = modal.querySelector('#bookingNote');

if (showBookingBtn) {
    showBookingBtn.addEventListener('click', () => {
        const token = localStorage.getItem('authToken');
        if (!token || !user) {
            localStorage.setItem('afterLoginRedirect', window.location.href);
            if (window.openLoginPopup) openLoginPopup();
            return;
        }
        if (user.role === 'admin') {
            alert('المدير لا يمكنه إرسال طلبات حجز');
            return;
        }
        if (p.owner_id === user.id) {
            alert('لا يمكنك حجز عقارك الخاص');
            return;
        }
        bookingSection.style.display = 'block';
        showBookingBtn.style.display = 'none';
    });
}

if (cancelBookingBtn) {
    cancelBookingBtn.addEventListener('click', () => {
        bookingSection.style.display = 'none';
        if (showBookingBtn) showBookingBtn.style.display = 'block';
        if (bookingNote) bookingNote.value = '';
    });
}

if (sendBookingBtn) {
    sendBookingBtn.addEventListener('click', async () => {
        const token = localStorage.getItem('authToken');
        if (!token || !user) return;

        sendBookingBtn.disabled = true;
        sendBookingBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري الإرسال...';

        try {
            const res = await fetch('http://localhost:8000/api/bookings', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ' + token
                },
                body: JSON.stringify({
                    property_id: p.id,
                    note: bookingNote?.value?.trim() || ''
                })
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || 'فشل الإرسال');

            // bookingSection.innerHTML = `
            //     <div style="text-align:center;padding:20px;color:#667eea;">
            //         <i class="fas fa-check-circle fa-2x" style="margin-bottom:10px;"></i>
            //         <p style="font-weight:600;">تم إرسال طلب الحجز بنجاح!</p>
            //         <p style="color:#777;font-size:0.9rem;">بانتظار موافقة المالك — سيتم إشعارك قريباً</p>
            //     </div>`;
                                bookingSection.innerHTML = `
                        <div style="text-align:center;padding:20px;color:#667eea;">
                            <i class="fas fa-check-circle fa-2x" style="margin-bottom:10px;"></i>
                            <p style="font-weight:600;">تم إرسال طلب الحجز بنجاح!</p>
                            <p style="color:#777;font-size:0.9rem;">بانتظار موافقة المالك — سيتم إشعارك قريباً</p>
                        </div>`;

                    // ✅ أعد تحميل البيانات وأغلق المودال بعد ثانيتين
                    setTimeout(async () => {
                        overlay.remove();
                        await loadPropertiesDataFromAPI();
                    }, 2000);
                    } catch(e) {
                        alert('❌ ' + e.message);
                        sendBookingBtn.disabled = false;
                        sendBookingBtn.innerHTML = '<i class="fas fa-paper-plane"></i> إرسال طلب الحجز';
                    }
    });
}
}

 async function requestContactForProperty(id) {
    const token = localStorage.getItem('authToken');
    const user  = JSON.parse(localStorage.getItem('user') || 'null');

    if (!token || !user) {
        localStorage.setItem('afterLoginRedirect', window.location.pathname + window.location.search);
        if (window.openLoginPopup) openLoginPopup();
        else window.location.href = 'login-popup.html';
        return;
    }

    const property = propertiesData.find(item => item.id === id) || {};
    const name  = user.name  || '';
    const phone = user.phone || '';

    if (!name || !phone) {
        alert('يجب أن يكون لديك اسم ورقم هاتف في حسابك لإرسال طلب تواصل');
        return;
    }

    try {
        const res = await fetch('http://localhost:8000/api/contact-requests', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ' + token
            },
            body: JSON.stringify({
                property_id: id,
                name:    name,
                phone:   phone,
                message:` طلب تواصل بخصوص العقار: ${p.title || ''}`
            })
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.message || 'فشل الإرسال');
        alert('✅ تم إرسال طلب التواصل بنجاح! سيتواصل معك المالك قريباً.');
    } catch(e) {
        alert('❌ ' + e.message);
    }
}
window.addEventListener('DOMContentLoaded', () => {
     loadUniversities(); 
    loadPropertiesDataFromAPI();
});

</script>
    <!-- <script src="js/api-integration.js"></script> -->
    <script src="js/includes.js"></script>
    <script src="js/auth-manager.js"></script>
</body>
</html>