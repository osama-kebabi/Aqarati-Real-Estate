<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>تصفح العقارات - عقاراتي</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/site.css">
    <link rel="stylesheet" href="style/properties.css">
    <link rel="stylesheet" href="style/nav.css">
</head>
<body>
    <div id="navbar-container"></div>
    <header class="page-header">
        <h1>تصفح العقارات</h1>
        <p>ابحث عن العقار المناسب لك بين قوائمنا المميزة</p>
    </header>
    <main class="container">
        <div class="student-callout">
            <span>إذا كنت طالباً، الرجاء اختيار خيار طالب للذهاب لصفحة عروض الطلاب أو إضافة عقار جديد.</span>
            <div style="display:flex; gap:10px; ">
                <a class="btn-student" href="properties_university.html"><i class="fas fa-graduation-cap"></i> طالب</a>
                <a class="btn-add-property" href="#" onclick="handleAddProperty(event)"><i class="fas fa-plus-circle"></i> إضافة عقار</a>
            </div>
        </div>
        <div class="search-row">
            <input type="text" id="q" placeholder="ابحث باسم مدينة أو ميزة" oninput="applyFiltersAndUpdateUrl()">
            
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

            <!-- Combo Box المناطق (يتغير ديناميكياً) -->
            <div class="combo-container" style="position: relative; min-width: 150px;">
                <input type="text" id="region" list="regions-list" placeholder="اختر/اكتب المنطقة" oninput="applyFiltersAndUpdateUrl()" autocomplete="off">
                <datalist id="regions-list">
                    <!-- يتم ملؤه عبر الجافاسكريبت فور كتابة المحافظة -->
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
                <option value="5">5+</option>
            </select>
            <input type="number" id="min_price" placeholder="السعر الأدنى" style="max-width:140px;" oninput="applyFiltersAndUpdateUrl()">
            <input type="number" id="max_price" placeholder="السعر الأقصى" style="max-width:140px;" oninput="applyFiltersAndUpdateUrl()">
            <button onclick="applyFiltersAndUpdateUrl()"><i class="fas fa-filter"></i> فلتر</button>
        </div>
        <section class="grid" id="propertiesGrid"></section>
    </main>
    <div id="popup-container"></div>

    <div id="footer-container"></div>
    <script>


        // const API_BASE_URL = 'http://localhost:8000/api';
        window.API_BASE_URL = window.API_BASE_URL || 'http://localhost:8000/api';
        let propertiesData = [];
window.propertiesLoaded = window.propertiesLoaded || false;
        async function loadPropertiesDataFromAPI() {
    //           if (propertiesLoaded) return; // ✅ منع إعادة التحميل
    // propertiesLoaded = true;      // ✅ سجّل إنه اشتغل مرة
            try {
                const response = await fetch(`${API_BASE_URL}/properties?per_page=50`, {
                    headers: { 'Accept': 'application/json' }
                });

                if (!response.ok) {
                    throw new Error(`HTTP ${response.status}`);
                }

                const data = await response.json();
                propertiesData = data.data || [];
                applyFiltersAndUpdateUrl(false);
            } catch (error) {
                console.error('خطأ أثناء تحميل العقارات من API:', error);
                propertiesData = [];
                applyFiltersAndUpdateUrl(false);
// >>>>>>> f8ddb0a (js)
            }
        }

        function propertyTypeLabel(type){
            if (!type) return '';
            return type === 'villa' ? 'فيلا' : (type === 'house' ? 'منزل عادي' : (type === 'shared' ? 'منزل مشترك' : type));
        }

        function parseQueryParams(){
            const params = {};
            location.search.replace(/^[?]/,'').split('&').forEach(pair => {
                if (!pair) return;
                const [k, ...rest] = pair.split('=');
                const key = decodeURIComponent(k || '');
                const value = decodeURIComponent(rest.join('=') || '');
                if (key) params[key] = value;
            });
            return params;
        }

        // هيكلية المحافظات والمناطق الثابتة
        const syriaData = {
            "دمشق": ["الميدان", "البرامكة", "مشروع دمر", "القابون", "التجارة", "القصاع", "المزة", "كفرسوسة", "المالكي", "أبو رمانة", "المهاجرين", "ركن الدين", "مساكن برزة", "الشاغور", "باب توما", "القدم"],
            "ريف دمشق": ["غوطة دوما", "حرستا", "جرمانا", "صحنايا", "أشرفية صحنايا", "قدسيا", "الهامة", "التل", "يبرود", "النبك", "الزبداني", "بلودان", "جبرود", "السيدة زينب", "ضاحية قدسيا", "عين ترما", "عربين"]
        };

        // تحديث قائمة المناطق (Datalist) بناءً على المحافظة المكتوبة
        function updateRegionsFilter() {
            const cityInput = document.getElementById('city');
            const regionsList = document.getElementById('regions-list');
            const regionInput = document.getElementById('region');
            const selectedCity = cityInput.value.trim();

            // تفريغ المدخل القديم والمستند الحالي للمناطق
            regionsList.innerHTML = '';
            regionInput.value = ''; 

            if (syriaData[selectedCity]) {
                syriaData[selectedCity].forEach(region => {
                    const option = document.createElement('option');
                    option.value = region;
                    regionsList.appendChild(option);
                });
            }
        }

        function renderPropertyCards(list){
            const grid = document.getElementById('propertiesGrid');
            grid.innerHTML = '';
            if (list.length === 0) {
                grid.innerHTML = '<div style="text-align:center; padding:40px; color:#999; grid-column:1/-1;">لا توجد عقارات تطابق معايير البحث</div>';
                return;
            }
            list.forEach(p => {
                const card = document.createElement('article');
                card.className = 'card';
                const mainImg = (p.images && p.images.length) ? (p.images.find(i => i.is_main) || p.images[0]) : null;
                const imgSrc = mainImg
                    ? (typeof mainImg === 'string'
                        ? mainImg
                        : (mainImg.image_url || (mainImg.image_path ? `http://localhost:8000/storage/${mainImg.image_path}` : '')))
                    : '';
                card.innerHTML = `
                 <div class="card-image">
                    <img src="${imgSrc}" alt="${p.title}" onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22280%22 height=%22180%22><rect fill=%22%23f0f0f0%22 width=%22280%22 height=%22180%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2216%22>لا توجد صورة</text></svg>'">
                        <div class="type-badge">${propertyTypeLabel(p.property_type)}
                            </div>
                        </div>
                    <div class="card-body">
                        <div style="display:flex; align-items:center; gap:8px">
                            <div class="card-title">${p.title}</div>
                        </div>
                     
                     <div class="card-sub"><span>${translateCity(p.city)} - ${p.region || ''} · ${propertyTypeLabel(p.property_type)}</span><strong>${Number(p.price).toLocaleString('ar-SY')} ل.س</strong></div>
                        <div style="margin-top:6px">
                          <span class="status-badge ${p.is_available ? 'status-available' : 'status-occupied'}">${p.is_available ? 'متوفر' : 'مشغول'}</span> 
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
        }

        function applyFiltersAndUpdateUrl(updateUrl = true){
            const q = document.getElementById('q').value.trim().toLowerCase();
            const city = document.getElementById('city').value.trim();
            const region = document.getElementById('region').value.trim();
            const type = document.getElementById('type').value;
            const rooms = document.getElementById('rooms').value;
            const min = parseFloat(document.getElementById('min_price').value || '') || null;
            const max = parseFloat(document.getElementById('max_price').value || '') || null;

            const filtered = propertiesData.filter(p => {
                if (q) {
                    const hay = (p.title + ' ' + translateCity(p.city || '') + ' ' + (p.region || '') + ' ' + (p.property_type || '') + ' ' + (p.description || '')).toLowerCase();
                    if (!hay.includes(q)) return false;
                }
                if (city && translateCity(p.city) !== city) return false;
                if (region && p.region !== region) return false;
                if (type && p.property_type !== type) return false;
                if (rooms) {
                const pRooms = parseInt(p.rooms_count) || 0;
                if (rooms === '6') { if (pRooms < 6) return false; }
                else if (pRooms !== parseInt(rooms)) return false;
            }
                if (min !== null && Number(p.price  < min)) return false;
                if (max !== null && Number(p.price  > max)) return false;
                return true;
            });

            renderPropertyCards(filtered);

            if (updateUrl) {
                const params = new URLSearchParams();
                if (city) params.set('city', city);
                if (region) params.set('region', region);
                if (type) params.set('property_type', type);
                if (rooms) params.set('rooms_count', rooms);
                if (min !== null) params.set('min_price', min);
                if (max !== null) params.set('max_price', max);
                const qv = document.getElementById('q').value.trim();
                if (qv) params.set('q', qv);
                history.replaceState(null, '', location.pathname + (params.toString() ? ('?' + params.toString()) : ''));
            }
        }
  

        const amenitiesTranslation = {
            'parking': 'موقف سيارات',
            'elevator': 'مصعد',
            'security': 'أمن وحراسة',
            'garden': 'حديقة',
            'pool': 'مسبح',
            'gym': 'صالة رياضية',
            'balcony': 'شرفة',
            'furnished': 'مفروش'
        };

        const amenitiesIcons = {
            'parking': 'fa-car',
            'elevator': 'fa-elevator',
            'security': 'fa-shield-alt',
            'garden': 'fa-tree',
            'pool': 'fa-swimming-pool',
            'gym': 'fa-dumbbell',
            'balcony': 'fa-building',
            'furnished': 'fa-couch'
        };


async function openPropertyDetails(id) {
    // ✅ جلب من API دائماً لضمان وجود owner + current_occupants محدّث
    try {
        const res = await fetch(`http://localhost:8000/api/properties/${id}`, {
            headers: { 'Accept': 'application/json' }
        });
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();
        const property = data.data;

        // ✅ أضف current_occupants من propertiesData المحلية إذا موجود
        const cached = propertiesData.find(p => p.id === id);
        if (cached) {
            property.current_occupants = cached.current_occupants;
        }

        openPropertyModal(property);
    } catch(e) {
        alert('فشل تحميل تفاصيل العقار: ' + e.message);
    }
}
            function openPropertyModal(property) {
            let overlay = document.getElementById('propertyModalOverlay');
            if (overlay) overlay.remove();

            overlay = document.createElement('div');
            overlay.id = 'propertyModalOverlay';
            overlay.className = 'property-modal-overlay active';

            const modal = document.createElement('div');
            modal.className = 'property-modal';

            // ── الصور ──
            let currentIndex = 0;
            const imageUrls = (property.images && property.images.length)
                ? property.images.map(img =>
                    typeof img === 'string' ? img :
                    (img.image_url || `http://localhost:8000/storage/${img.image_path}`)
                )
                : ['data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>لا توجد صورة</text></svg>'];

            // ── السعر مع/بدون خصم ──
            const price = parseFloat(property.price);
            let priceHTML;
            if (property.has_student_discount && property.student_discount_percentage > 0) {
                const discounted = price * (1 - property.student_discount_percentage / 100);
                priceHTML = `
                    <span style="text-decoration:line-through;color:#aaa;font-size:1.3rem;margin-left:10px;">
                        ${price.toLocaleString('ar-SY')} ل.س
                    </span>
                    <span style="color:#27ae60;">
                        ${discounted.toLocaleString('ar-SY')} <span>ل.س</span>
                    </span>
                    <span style="font-size:.85rem;color:#ff3d6d;font-weight:700;">
                        (خصم ${property.student_discount_percentage}%)
                    </span>`;
            } else {
                priceHTML = `${isNaN(price) ? 'غير محدد' : price.toLocaleString('ar-SY')} <span>ل.س</span>`;
            }

            // ── الجامعة ──
            const uniName = property.university ? (property.university.name || null) : null;
            const uniHTML = uniName ? `
                <div class="university-badge">
                    <i class="fas fa-university"></i>
                    <span>قريب من ${uniName}</span>
                </div>` : '';

            // ── المميزات ──
            let featuresHTML = '';
            const features = [];
            if (property.area) features.push(`
                <div class="feature-item">
                    <i class="fas fa-vector-square"></i>
                    <span>${property.area} م²</span>
                </div>`);
            if (property.rooms_count) features.push(`
                <div class="feature-item">
                    <i class="fas fa-bed"></i>
                    <span>${property.rooms_count} غرف</span>
                </div>`);
            if (property.bathrooms_count) features.push(`
                <div class="feature-item">
                    <i class="fas fa-bath"></i>
                    <span>${property.bathrooms_count} حمام</span>
                </div>`);
            if (property.has_student_discount && property.student_discount_percentage>0 )features.push(`
                <div class="feature-item">
                    <i class="fas fa-tag"></i>
                    <span>خصم طلابي ${property.student_discount_percentage}%</span>
                </div>`);
            if (property.division_accept === 'yes') features.push(`
                <div class="feature-item">
                    <i class="fas fa-layer-group"></i>
                    <span>يقبل التقسيم${property.division_count ? ` لـ ${property.division_count} أفراد` : ''}</span>
                </div>`);
                if (property.payment_method) features.push(`
            <div class="feature-item">
                <i class="fas fa-money-bill-wave"></i>
                <span>${{
                    'cash': 'نقدي',
                    'bank_transfer': 'تحويل بنكي',
                    'check': 'شيك',
                    'installments': 'تقسيط'
                }[property.payment_method] || property.payment_method}</span>
            </div>`);
            if (features.length) featuresHTML = `
                <div class="property-features">${features.join('')}</div>`;

            // ── المرافق (قد تكون JSON string) ──
            let amenitiesArr = property.amenities || [];
            if (typeof amenitiesArr === 'string') {
                try { amenitiesArr = JSON.parse(amenitiesArr); } catch(e) { amenitiesArr = []; }
            }
            let amenitiesHTML = '';
            if (amenitiesArr.length) {
                amenitiesHTML = `
                    <div class="amenities-section">
                        <h4>المرافق والخدمات</h4>
                        <div class="amenities-list">
                            ${amenitiesArr.map(a => `
                                <span class="amenity-tag">
                                    <i class="fas ${amenitiesIcons[a] || 'fa-check'}"></i>
                                    ${amenitiesTranslation[a] || a}
                                </span>`).join('')}
                        </div>
                    </div>`;
            }

            // ── معلومات التواصل ──
            const contactName  = property.owner?.name  || property.owner_name  || '—';
            const contactPhone = property.owner?.phone || property.owner_phone || '—';
            const contactEmail = property.owner?.email || property.owner_email || null;

            modal.innerHTML = `
                <div class="modal-scrollable">
                    <div class="property-image">
                        <img src="${imageUrls[0]}" alt="${property.title}" id="modalMainImage"
                            onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/></svg>'">
                        <div class="property-status ${property.is_available ? '' : 'status-occupied-badge'}">
                            ${property.is_available ? 'متاح للإيجار' : 'مشغول'}
                        </div>
                        <div class="property-type-badge">${propertyTypeLabel(property.property_type)}</div>
                        <div class="image-counter" id="imageCounter">1 / ${imageUrls.length}</div>
                        <div class="image-nav">
                            <button id="prevImageBtn"><i class="fas fa-chevron-right"></i></button>
                            <button id="nextImageBtn"><i class="fas fa-chevron-left"></i></button>
                        </div>
                    </div>
                    <button class="modal-close" id="modalCloseBtn"><i class="fas fa-times"></i></button>
                    <div class="property-content">

                        <div class="property-price">${priceHTML}</div>
                        <h2 class="property-title">${property.title}</h2>

                        <div class="property-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>${translateCity(property.city)}${property.region ? ' - ' + property.region : ''}${property.address ? ' - ' + property.address : ''}</span>
                        </div>

                        ${uniHTML}
                        ${featuresHTML}

                        <div class="property-description">
                            <h4 style="color:#333;margin-bottom:10px;">وصف العقار</h4>
                            <p>${property.description || 'لا يوجد وصف'}</p>
                        </div>

                        ${amenitiesHTML}

                        <div class="contact-section">
                            <h4>معلومات التواصل</h4>
                            <div class="contact-info">
                                <div class="contact-item">
                                    <i class="fas fa-user"></i>
                                    <span>${contactName}</span>
                                </div>
                                <div class="contact-item">
                                    <i class="fas fa-phone"></i>
                                    <span dir="ltr">${contactPhone}</span>
                                </div>
                                ${contactEmail ? `
                                <div class="contact-item">
                                    <i class="fas fa-envelope"></i>
                                    <span>${contactEmail}</span>
                                </div>` : ''}
                            </div>
                        </div>

                    </div>
                </div>
        
            <div class="modal-footer" style="display:flex;gap:10px;padding:16px;">
            <button class="btn-primary" id="showContactFormBtn" style="flex:1;">
                <i class="fas fa-envelope"></i> طلب تواصل
            </button>
          ${property.is_available ? `
<button id="showBookingFormBtn" style="flex:1;padding:12px;
    background:linear-gradient(135deg,#667eea,#764ba2);
    color:#fff;border:none;border-radius:10px;cursor:pointer;
    font-family:Cairo,sans-serif;font-size:0.95rem;font-weight:600;">
    <i class="fas fa-calendar-check"></i>
    ${property.division_accept === 'yes' ? 'حجز مكان' : 'احجز الآن'}
</button>` : `
<button disabled style="flex:1;padding:12px;background:#ccc;
    color:#fff;border:none;border-radius:10px;cursor:not-allowed;
    font-family:Cairo,sans-serif;font-size:0.95rem;">
    <i class="fas fa-ban"></i> غير متاح
</button>`}
        </div>
        <div id="bookingFormSection" style="display:none;padding:20px;border-top:1px solid #eee;">
            <h4 style="color:#333;margin-bottom:8px;">
                <i class="fas fa-calendar-check" style="color:#667eea;"></i> تأكيد طلب الحجز
            </h4>
            ${property.division_accept === 'yes' ? `
            <div style="background:#f0f4ff;border-radius:10px;padding:10px 14px;margin-bottom:14px;font-size:0.9rem;">
                <i class="fas fa-users" style="color:#667eea;"></i>
                الأماكن المتاحة: <strong>${parseInt(property.division_count) - (property.current_occupants || 0)}</strong>
                من أصل <strong>${property.division_count}</strong>
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
            setTimeout(() => overlay.classList.add('active'), 10);

            const mainImage    = modal.querySelector('#modalMainImage');
            const imageCounter = modal.querySelector('#imageCounter');
            const prevBtn      = modal.querySelector('#prevImageBtn');
            const nextBtn      = modal.querySelector('#nextImageBtn');
            const closeBtn     = modal.querySelector('#modalCloseBtn');

            function showImage(index) {
                currentIndex = (index + imageUrls.length) % imageUrls.length;
                mainImage.src = imageUrls[currentIndex];
                imageCounter.textContent = `${currentIndex + 1} / ${imageUrls.length}`;
            }

            prevBtn.addEventListener('click', e => { e.stopPropagation(); showImage(currentIndex - 1); });
            nextBtn.addEventListener('click', e => { e.stopPropagation(); showImage(currentIndex + 1); });

            function closeModal() {
                overlay.classList.remove('active');
                setTimeout(() => { if (overlay?.parentNode) overlay.remove(); }, 300);
            }

            closeBtn.addEventListener('click', closeModal);
            overlay.addEventListener('click', e => { if (e.target === overlay) closeModal(); });

            function handleKeyDown(e) {
                if (e.key === 'Escape') closeModal();
                else if (e.key === 'ArrowLeft') showImage(currentIndex + 1);
                else if (e.key === 'ArrowRight') showImage(currentIndex - 1);
            }
            document.addEventListener('keydown', handleKeyDown);
            overlay.addEventListener('transitionend', () => {
                if (!overlay.classList.contains('active'))
                    document.removeEventListener('keydown', handleKeyDown);
            });

            window.closePropertyModal = closeModal;
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
                if (user.role === 'owner' && property.owner_id === user.id) {
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
                            ` طلب تواصل بخصوص العقار: ${property.title}` ;

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
                            property_id: property.id,
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
                const ownerId = property.owner_id || property.owner?.id;
                if (ownerId && ownerId === user.id) {
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
                            property_id: property.id,
                            note: bookingNote?.value?.trim() || ''
                        })
                    });
                    const data = await res.json();
                    if (!res.ok) throw new Error(data.message || 'فشل الإرسال');

                    // bookingSection.innerHTML = `
                    //     <div style="text-align:center;padding:20px;color:#667eea;">
                    //         <i class="fas fa-check-circle fa-2x" style="margin-bottom:10px;"></i>
                    //         <p style="font-weight:600;">تم إرسال طلب الحجز بنجاح!</p>
                    //         <p style="color:#777;font-size:0.9rem;">
                    //             بانتظار موافقة المالك — سيتم إشعارك قريباً
                    //         </p>
                    //     </div>`;
                    bookingSection.innerHTML = `
                            <div style="text-align:center;padding:20px;color:#667eea;">
                                <i class="fas fa-check-circle fa-2x" style="margin-bottom:10px;"></i>
                                <p style="font-weight:600;">تم إرسال طلب الحجز بنجاح!</p>
                                <p style="color:#777;font-size:0.9rem;">بانتظار موافقة المالك — سيتم إشعارك قريباً</p>
                            </div>`;

                        // ✅ أعد تحميل البيانات لتحديث العداد
                        await loadPropertiesDataFromAPI();
                } catch(e) {
                    alert('❌ ' + e.message);
                    sendBookingBtn.disabled = false;
                    sendBookingBtn.innerHTML = '<i class="fas fa-paper-plane"></i> إرسال طلب الحجز';
                }
            });
        }
        }


                function contactPropertyOwner(id){
                    const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
                    
                    if (!isLoggedIn) {
                        if (window.openLoginPopup) { 
                            openLoginPopup(); 
                            return; 
                        }
                    }
                    
                    const property = propertiesData.find(item => item.id === id);
                    if (property && property.owner) {
                        alert('معلومات التواصل مع صاحب العقار:\n\nالاسم: ' + property.owner.name + '\nرقم الهاتف: ' + property.owner.phone + 
                            (property.owner.email ? '\nالبريد الإلكتروني: ' + property.owner.email : ''));
                    } else {
                        alert('عذراً، لا توجد معلومات تواصل متاحة لهذا العقار');
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
                        message:` طلب تواصل بخصوص العقار: ${property.title || ''}`
                    })
                });
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || 'فشل الإرسال');
                alert('✅ تم إرسال طلب التواصل بنجاح! سيتواصل معك المالك قريباً.');
            } catch(e) {
                alert('❌ ' + e.message);
            }
        }

             
            window.handleAddProperty = function(event) {
            event.preventDefault();
            const token = localStorage.getItem('authToken');
            const user  = JSON.parse(localStorage.getItem('user') || 'null');

            // غير مسجّل → فتح popup
            if (!token || !user) {
                localStorage.setItem('afterLoginRedirect', 'add-properties.html');
                if (window.openLoginPopup) openLoginPopup();
                else window.location.href = 'login-popup.html';
                return;
            }

            // ✅ أي مستخدم مسجّل → صفحة الإضافة
            window.location.href = 'add-properties.html';
        }

                document.addEventListener('DOMContentLoaded', async () => {
                    const qp = parseQueryParams();
                    if (qp.q) document.getElementById('q').value = qp.q;
                    if (qp.city) {
                        document.getElementById('city').value = qp.city;
                        updateRegionsFilter();
                    }
                    if (qp.region) document.getElementById('region').value = qp.region;
                    if (qp.property_type) document.getElementById('type').value = qp.property_type;

                    await loadPropertiesDataFromAPI();
                    applyFiltersAndUpdateUrl(false);
                });
              
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
    return map[type] || type ||  '';
}
        function translateCity(city) {
            if (!city) return '';
            return cityTranslation[city.toLowerCase()] || city;
        }
        // currentRequests.push(newRequest);
        // localStorage.setItem('contactRequests', JSON.stringify(currentRequests));
            </script>
            <script src="js/includes.js"></script>
            <!-- <script src="js/properties-api.js"></script> -->

        </body>
        </html>


