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
// <<<<<<< HEAD
//         const propertiesData = [
//             { 
//                 id:1, 
//                 title:'فيلا فاخرة مع مسبح', 
//                 city:'دمشق', 
//                 region:'مشروع دمر', 
//                 property_type:'villa', 
//                 rooms:5, 
//                 price_num:320000000, 
//                 price:'320,000,000 ل.س', 
//                 images:['photo/1.jpg','photo/2.jpg','photo/3.jpg','photo/4.jpg','photo/5.jpg'], 
//                 owner:{name:'أحمد البستاني', phone:'0988123456', 
//                 email:'ahmad@example.com'}, 
//                 status:'available',
//                 area: 350,
//                 description: 'فيلا فاخرة في موقع متميز مع مسبح خاص وحديقة جميلة. تتكون من 5 غرف نوم وصالة كبيرة ومطبخ مجهز بالكامل. موقع استراتيجي قريب من جميع الخدمات.',
//                 amenities: ['parking', 'pool', 'garden', 'security', 'furnished', 'balcony'],
//             },
//             { 
//                 id:2, 
//                 title:'منزل عائلي 3 غرف', 
//                 city:'حلب', 
//                 region:'الفرقان', 
//                 property_type:'house', 
//                 rooms:3, 
//                 price_num:85000000, 
//                 price:'85,000,000 ل.س', 
//                 images:['photo/2.jpg','photo/3.jpg','photo/4.jpg','photo/5.jpg','photo/1.jpg'], 
//                 owner:{name:'سارة الخالد', 
//                 phone:'0988654321', 
//                 email:'sara@example.com'}, 
//                 status:'occupied',
//                 area: 200,
//                 description: 'منزل عائلي دافئ في حي هادئ. 3 غرف نوم، صالة واسعة، مطبخ أمريكي، وموقف سيارة خاص. قريب من المدارس والأسواق.',
//                 amenities: ['parking', 'security', 'balcony'],
//             },
//             { 
//                 id:3, 
//                 title:'منزل مشترك (غرف مفروشة)', 
//                 city:'حمص', 
//                 region:'الإنشاءات', 
//                 property_type:'shared', 
//                 rooms:1, 
//                 price_num:22000000, 
//                 price:'22,000,000 ل.س', 
//                 images:['photo/3.jpg','photo/4.jpg','photo/5.jpg'], 
//                 owner:{name:'محمود الرفاعي', 
//                 phone:'0988777888', 
//                 email:'mahmoud@example.com'}, 
//                 status:'available',
//                 area: 120,
//                 description: 'منزل مشترك للطلاب، غرف مفروشة بالكامل مع جميع الخدمات. إنترنت، ماء ساخن، تدفئة، قريب من الجامعة والمواصلات.',
//                 amenities: ['furnished', 'elevator', 'security'],
//             },
//             { 
//                 id:4, 
//                 title:'دوبلكس مميز', 
//                 city:'اللاذقية', 
//                 region:'المشروع الأول', 
//                 property_type:'house', 
//                 rooms:4, 
//                 price_num:145000000, 
//                 price:'145,000,000 ل.س', 
//                 images:['photo/4.jpg','photo/5.jpg','photo/1.jpg'], 
//                 owner:{name:'ليلى منصور', 
//                 phone:'0988222333', 
//                 email:'layla@example.com'}, 
//                 status:'occupied',
//                 area: 280,
//                 description: 'دوبلكس راقي بإطلالة بحرية. 4 غرف نوم، 3 حمامات، صالة استقبال كبيرة، تراس واسع. تصميم عصري وتشطيبات فاخرة.',
//                 amenities: ['parking', 'elevator', 'balcony', 'gym', 'security'],
//             },
//             { 
//                 id:5, 
//                 title:'فيلا حديثة مع حديقة', 
//                 city:'طرطوس', 
//                 region:'المشروع السابع', 
//                 property_type:'villa', 
//                 rooms:4, 
//                 price_num:290000000, 
//                 price:'290,000,000 ل.س', 
//                 images:['photo/5.jpg','photo/1.jpg','photo/2.jpg'], 
//                 owner:{name:'كريم اليوسف', 
//                 phone:'0988444555', 
//                 email:'karim@example.com'}, 
//                 status:'available',
//                 area: 400,
//                 description: 'فيلا عصرية بحديقة كبيرة وأشجار مثمرة. مسبح، منطقة شواء، موقف لـ 3 سيارات. موقع هادئ ومناسب للعائلات.',
//                 amenities: ['parking', 'pool', 'garden', 'furnished'],
//             },
//             { 
//                 id:6, 
//                 title:'منزل مفروش للإيجار', 
//                 city:'حماة', 
//                 region:'الشريعة', 
//                 property_type:'house', 
//                 rooms:2, 
//                 price_num:4500000, 
//                 price:'4,500,000 ل.س / سنويا', 
//                 images:['photo/1.jpg'], 
//                 owner:{name:'نهى جميل', phone:'0988999000', email:'nouha@example.com'}, 
//                 status:'occupied',
//                 area: 150,
//                 description: 'منزل مفروش بالكامل للإيجار السنوي. مناسب للعائلات الصغيرة أو الموظفين. قريب من مركز المدينة والخدمات.', 
//                 amenities: ['furnished', 'parking', 'balcony'],

                
        // const propertiesData = []
        //     { 
        //         id:1, 
        //         title:'فيلا فاخرة مع مسبح', 
        //         city:'دمشق', 
        //         region:'مشروع دمر', 
        //         property_type:'villa', 
        //         rooms:5, 
        //         price_num:320000000, 
        //         price:'320,000,000 ل.س', 
        //         images:['photo/1.jpg','photo/2.jpg','photo/3.jpg','photo/4.jpg','photo/5.jpg'], 
        //         owner:{name:'أحمد البستاني', phone:'+963-988-123456', email:'ahmad@example.com'}, 
        //         status:'available',
        //         area: 350,
        //         description: 'فيلا فاخرة في موقع متميز مع مسبح خاص وحديقة جميلة. تتكون من 5 غرف نوم وصالة كبيرة ومطبخ مجهز بالكامل. موقع استراتيجي قريب من جميع الخدمات.',
        //         amenities: ['parking', 'pool', 'garden', 'security', 'furnished', 'balcony'],
        //     },
        //     { 
        //         id:2, 
        //         title:'منزل عائلي 3 غرف', 
        //         city:'حلب', 
        //         region:'الفرقان', 
        //         property_type:'house', 
        //         rooms:3, 
        //         price_num:85000000, 
        //         price:'85,000,000 ل.س', 
        //         images:['photo/2.jpg','photo/3.jpg','photo/4.jpg','photo/5.jpg','photo/1.jpg'], 
        //         owner:{name:'سارة الخالد', phone:'+963-988-654321', email:'sara@example.com'}, 
        //         status:'occupied',
        //         area: 200,
        //         description: 'منزل عائلي دافئ في حي هادئ. 3 غرف نوم، صالة واسعة، مطبخ أمريكي، وموقف سيارة خاص. قريب من المدارس والأسواق.',
        //         amenities: ['parking', 'security', 'balcony'],
        //     },
        //     { 
        //         id:3, 
        //         title:'منزل مشترك (غرف مفروشة)', 
        //         city:'حمص', 
        //         region:'الإنشاءات', 
        //         property_type:'shared', 
        //         rooms:1, 
        //         price_num:22000000, 
        //         price:'22,000,000 ل.س', 
        //         images:['photo/3.jpg','photo/4.jpg','photo/5.jpg'], 
        //         owner:{name:'محمود الرفاعي', phone:'+963-988-777888', email:'mahmoud@example.com'}, 
        //         status:'available',
        //         area: 120,
        //         description: 'منزل مشترك للطلاب، غرف مفروشة بالكامل مع جميع الخدمات. إنترنت، ماء ساخن، تدفئة، قريب من الجامعة والمواصلات.',
        //         amenities: ['furnished', 'elevator', 'security'],
        //     },
        //     { 
        //         id:4, 
        //         title:'دوبلكس مميز', 
        //         city:'اللاذقية', 
        //         region:'المشروع الأول', 
        //         property_type:'house', 
        //         rooms:4, 
        //         price_num:145000000, 
        //         price:'145,000,000 ل.س', 
        //         images:['photo/4.jpg','photo/5.jpg','photo/1.jpg'], 
        //         owner:{name:'ليلى منصور', phone:'+963-988-222333', email:'layla@example.com'}, 
        //         status:'occupied',
        //         area: 280,
        //         description: 'دوبلكس راقي بإطلالة بحرية. 4 غرف نوم، 3 حمامات، صالة استقبال كبيرة، تراس واسع. تصميم عصري وتشطيبات فاخرة.',
        //         amenities: ['parking', 'elevator', 'balcony', 'gym', 'security'],
        //     },
        //     { 
        //         id:5, 
        //         title:'فيلا حديثة مع حديقة', 
        //         city:'طرطوس', 
        //         region:'المشروع السابع', 
        //         property_type:'villa', 
        //         rooms:4, 
        //         price_num:290000000, 
        //         price:'290,000,000 ل.س', 
        //         images:['photo/5.jpg','photo/1.jpg','photo/2.jpg'], 
        //         owner:{name:'كريم اليوسف', phone:'+963-988-444555', email:'karim@example.com'}, 
        //         status:'available',
        //         area: 400,
        //         description: 'فيلا عصرية بحديقة كبيرة وأشجار مثمرة. مسبح، منطقة شواء، موقف لـ 3 سيارات. موقع هادئ ومناسب للعائلات.',
        //         amenities: ['parking', 'pool', 'garden', 'furnished'],
        //     },
        //     { 
        //         id:6, 
        //         title:'منزل مفروش للإيجار', 
        //         city:'حماة', 
        //         region:'الشريعة', 
        //         property_type:'house', 
        //         rooms:2, 
        //         price_num:4500000, 
        //         price:'4,500,000 ل.س / سنويا', 
        //         images:['photo/1.jpg'], 
        //         owner:{name:'نهى جميل', phone:'+963-988-999000', email:'nouha@example.com'}, 
        //         status:'occupied',
        //         area: 150,
        //         description: 'منزل مفروش بالكامل للإيجار السنوي. مناسب للعائلات الصغيرة أو الموظفين. قريب من مركز المدينة والخدمات.', 
        //         amenities: ['furnished', 'parking', 'balcony'],
        //     }
        // ];

        // const API_BASE_URL = 'http://localhost:8000/api';
        window.API_BASE_URL = window.API_BASE_URL || 'http://localhost:8000/api';
        let propertiesData = [];

        async function loadPropertiesDataFromAPI() {
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
                            <button class="btn btn-view" onclick="openPropertyDetails(${p.id})"><i class='fas fa-eye'></i> عرض التفاصيل</button>
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
    //     async function applyFiltersAndUpdateUrl(updateUrl = true) {
    // const q      = document.getElementById('q').value.trim();
    // const city   = document.getElementById('city').value.trim();
    // const region = document.getElementById('region').value.trim();
    // const type   = document.getElementById('type').value;
    // const rooms  = document.getElementById('rooms').value;
    // const min    = document.getElementById('min_price').value;
    // const max    = document.getElementById('max_price').value;

    // // تحديث الـ URL
    // if (updateUrl) {
    //     const params = new URLSearchParams();
    //     if (q)      params.set('q', q);
    //     if (city)   params.set('city', city);
    //     if (region) params.set('region', region);
    //     if (type)   params.set('property_type', type);
    //     if (rooms)  params.set('rooms_count', rooms);
    //     if (min)    params.set('min_price', min);
    //     if (max)    params.set('max_price', max);
    //     history.replaceState(null, '', location.pathname + (params.toString() ? '?' + params : ''));
    // }

    // جلب من API مباشرة
    // const grid = document.getElementById('propertiesGrid');
    // grid.innerHTML = '<div style="grid-column:1/-1;text-align:center;padding:40px;color:#8B7FD2;">'
    //     + '<i class="fas fa-spinner fa-spin fa-2x"></i>'
    //     + '<p style="margin-top:12px;">جاري البحث...</p></div>';

    // try {
    //     const filters = {};
    //     if (q)      filters.q             = q;
    //     if (city)   filters.city          = city;
    //     if (region) filters.region        = region;
    //     if (type)   filters.property_type = type;
    //     if (rooms)  filters.rooms_count   = rooms;
    //     if (min)    filters.min_price     = min;
    //     if (max)    filters.max_price     = max;

// ✔ هذا — نفس المنطق بدون اعتماد على ملف خارجي
// const params = new URLSearchParams();function applyFiltersAndUpdateUrl() {
//     const q         = document.getElementById('q')?.value.trim().toLowerCase() || '';
//     const city      = document.getElementById('city')?.value.trim() || '';
//     const region    = document.getElementById('region')?.value.trim() || '';
//     const type      = document.getElementById('type')?.value || '';
//     const rooms     = document.getElementById('rooms')?.value || '';
//     const divCount  = document.getElementById('divisionCount')?.value || '';
//     const linkedUni = document.getElementById('linkedUniversity')?.value || '';
//     const discount  = document.getElementById('discount')?.value || '';
//     const min       = parseFloat(document.getElementById('min_price')?.value  '')  null;
//     const max       = parseFloat(document.getElementById('max_price')?.value  '')  null;

//     // إذا ما في بيانات محملة بعد، حمّل من API
//     if (!propertiesData.length) {
//         loadPropertiesDataFromAPI();
//         return;
//     }

//     const filtered = propertiesData.filter(p => {
//         if (q) {
//             const hay = (
//                 (p.title||'') + ' ' +
//                 translateCity(p.city||'') + ' ' +
//                 (p.region||'') + ' ' +
//                 (p.property_type||'') + ' ' +
//                 (p.university?.name||'')
//             ).toLowerCase();
//             if (!hay.includes(q)) return false;
//         }
//         if (city   && translateCity(p.city) !== city)   return false;
//         if (region && p.region !== region)              return false;
//         if (type   && p.property_type !== type)         return false;
//         if (rooms) {
//             if (rooms === '6') { if ((p.rooms_count||0) < 6) return false; }
//             else if (parseInt(p.rooms_count) !== parseInt(rooms)) return false;
//         }
//         if (linkedUni) {
//             if (linkedUni === 'none') { if (p.university_id) return false; }
//             else { if (!(p.university?.name||'').includes(linkedUni)) return false; }
//         }
//         if (divCount) {
//             if (p.division_accept !== 'yes') return false;
//             if (divCount === '6') { if ((p.division_count||0) < 6) return false; }
//             else if (parseInt(p.division_count) !== parseInt(divCount)) return false;
//         }
//         if (discount) {
//             const d = parseInt(p.student_discount_percentage || 0);
//             if (discount === '0'     && d !== 0)        return false;
//             if (discount === '1-9'   && (d<1 || d>9))  return false;
//             if (discount === '10-14' && (d<10 || d>14)) return false;
//             if (discount === '15+'   && d < 15)         return false;
//         }
//         if (min !== null && Number(p.price) < min) return false;
//         if (max !== null && Number(p.price) > max) return false;
//         return true;
//     });

//     renderPropertyCards(filtered);
// }
// Object.entries(filters).forEach(([k, v]) => {
//     if (v !== null && v !== undefined && v !== '') params.set(k, v);
// });
// const res = await fetch(`http://localhost:8000/api/properties?${params}`, {
//     headers: { 'Accept': 'application/json' }
// });
// if (!res.ok) throw new Error(`HTTP ${res.status}`);
// const data = await res.json();
//         propertiesData   = data.data || [];
//         renderPropertyCards(propertiesData);
//     } catch (e) {
//         grid.innerHTML = '<div style="grid-column:1/-1;text-align:center;padding:40px;color:#e53935;">'
//             + '<p>فشل البحث: ' + e.message + '</p></div>';
//     }
// }

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

      async   function openPropertyDetails(id){
            // const property = propertiesData.find(item => item.id === id);
            // if (!property) return alert('العقار غير موجود');
            // openPropertyModal(property);
 const grid = document.getElementById('propertiesGrid');
    
    try {
        const res = await fetch(`http://localhost:8000/api/properties/${id}`, {
            headers: { 'Accept': 'application/json' }
        });
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();
        openPropertyModal(data.data);
    } catch(e) {
        alert('فشل تحميل تفاصيل العقار: ' + e.message);
    }
        }

//         function openPropertyModal(property){
//             let overlay = document.getElementById('propertyModalOverlay');
//             if (overlay) overlay.remove();
            
//             overlay = document.createElement('div');
//             overlay.id = 'propertyModalOverlay';
//             overlay.className = 'property-modal-overlay active';

//             const modal = document.createElement('div');
//             modal.className = 'property-modal';

//             let currentIndex = 0;
//             // const imageUrls = (property.images && property.images.length) ? property.images : ['data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>لا توجد صورة</text></svg>'];
// const imageUrls = (property.images && property.images.length)
//     ? property.images.map(img =>
//         typeof img === 'string' ? img :
//         (img.image_url || `http://localhost:8000/storage/${img.image_path}`)
//       ) : ['data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>لا توجد صورة</text></svg>'];
//             let amenitiesHTML = '';
//             // أضف هذا قبل if (property.amenities):
// let amenitiesArr = property.amenities || [];
// if (typeof amenitiesArr === 'string') {
//     try { amenitiesArr = JSON.parse(amenitiesArr); } catch(e) { amenitiesArr = []; }
// }

// // ثم استبدل كل property.amenities بـ amenitiesArr:
// if (amenitiesArr && amenitiesArr.length > 0) {
//     const amenitiesList = amenitiesArr.map(amenity => `...`).join('');
// }
//             if (property.amenities && property.amenities.length > 0) {
//                 const amenitiesList = property.amenities.map(amenity => `
//                     <span class="amenity-tag">
//                         <i class="fas ${amenitiesIcons[amenity] || 'fa-check'}"></i>
//                         ${amenitiesTranslation[amenity] || amenity}
//                     </span>
//                 `).join('');
                
//                 amenitiesHTML = `
//                     <div class="amenities-section">
//                         <h4>المرافق والخدمات</h4>
//                         <div class="amenities-list">
//                             ${amenitiesList}
//                         </div>
//                     </div>
//                 `;
//             }

//             let featuresHTML = '';
//             const features = [];
//             if (property.area) {
//                 features.push(`
//                     <div class="feature-item">
//                         <i class="fas fa-vector-square"></i>
//                         <span>${property.area} م²</span>
//                     </div>
//                 `);
//             }
//             if (property.rooms_count) {
//                 features.push(`
//                     <div class="feature-item">
//                         <i class="fas fa-bed"></i>
//                         <span>${property.rooms_count} غرف</span>
//                     </div>
//                 `);
//             }

//             if (features.length > 0) {
//                 featuresHTML = `
//                     <div class="property-features">
//                         ${features.join('')}
//                     </div>
//                 `;
//             }

//             modal.innerHTML = `
//                 <div class="modal-scrollable">
//                     <div class="property-image">
//                         <img src="${imageUrls[0]}" alt="${property.title}" id="modalMainImage" onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>تعذر تحميل الصورة</text></svg>'">
//                         <div class="property-status ${property.status === 'occupied' ? 'status-occupied-badge' : ''}">${property.is_available  ? 'متاح للإيجار' : 'مشغول'}</div>
//                         <div class="property-type-badge">${propertyTypeLabel(property.property_type)}</div>
//                         <div class="image-counter" id="imageCounter">1 / ${imageUrls.length}</div>
//                         <div class="image-nav">
//                             <button id="prevImageBtn"><i class="fas fa-chevron-right"></i></button>
//                             <button id="nextImageBtn"><i class="fas fa-chevron-left"></i></button>
//                         </div>
//                     </div>
//                     <button class="modal-close" id="modalCloseBtn">
//                         <i class="fas fa-times"></i>
//                     </button>
//                     <div class="property-content">
//                         <div class="property-price">
//                             ${Number(property.price).toLocaleString('ar-SY')} 
//                             <span>ل.س</span>
//                                     </div>
                       
//                         <h2 class="property-title">${property.title}</h2>
                        
//                         <div class="property-location">
//                             <i class="fas fa-map-marker-alt"></i>
//                             <span>${translateCity(property.region)}، ${property.city}</span>
//                         </div>

//                         ${featuresHTML}

//                         <div class="property-description">
//                             <h4 style="color: #333; margin-bottom: 10px;">وصف العقار</h4>
//                             <p>${property.description || 'لا يوجد وصف'}</p>
//                         </div>

//                         ${amenitiesHTML}
//                         ${(property.owner || property.owner_name) ? `
//                 <div class="contact-section">
//                     <h4>معلومات التواصل</h4>
//                     <div class="contact-info">
//                         <div class="contact-item">
//                             <i class="fas fa-user"></i>
//                             <span>${property.owner?.name || property.owner_name || '—'}</span>
//                         </div>
//                         <div class="contact-item">
//                             <i class="fas fa-phone"></i>
//                             <span dir="ltr">${property.owner?.phone || property.owner_phone || '—'}</span>
//                         </div>
//                         ${(property.owner?.email || property.owner_email) ? `
//                         <div class="contact-item">
//                             <i class="fas fa-envelope"></i>
//                             <span>${property.owner?.email || property.owner_email}</span>
//                         </div>` : ''}
//                     </div>
//                 </div>` : ''}

//                     </div>
//                 </div>
        //     `;
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
        <div class="modal-footer">
            <button class="btn-primary" onclick="requestContactForProperty(${property.id})">
                <i class="fas fa-envelope"></i> طلب تواصل
            </button>
        </div>`;

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
}

        //     // إضافة تذييل المودال مع زر واحد لطلب تواصل
        //     const modalFooter = document.createElement('div');
        //     modalFooter.className = 'modal-footer';
        //     modalFooter.innerHTML = `
        //         <button class="btn-primary" onclick="requestContactForProperty(${property.id})">
        //             <i class="fas fa-envelope"></i>
        //             طلب تواصل
        //         </button>
        //     `;
        //     modal.appendChild(modalFooter);

        //     overlay.appendChild(modal);
        //     document.body.appendChild(overlay);

        //     setTimeout(() => overlay.classList.add('active'), 10);

        //     const mainImage = modal.querySelector('#modalMainImage');
        //     const imageCounter = modal.querySelector('#imageCounter');
        //     const prevBtn = modal.querySelector('#prevImageBtn');
        //     const nextBtn = modal.querySelector('#nextImageBtn');
        //     const closeBtn = modal.querySelector('#modalCloseBtn');

        //     function showImage(index) {
        //         currentIndex = (index + imageUrls.length) % imageUrls.length;
        //         mainImage.src = imageUrls[currentIndex];
        //         imageCounter.textContent = `${currentIndex + 1} / ${imageUrls.length}`;
        //     }

        //     prevBtn.addEventListener('click', (e) => {
        //         e.stopPropagation();
        //         showImage(currentIndex - 1);
        //     });

        //     nextBtn.addEventListener('click', (e) => {
        //         e.stopPropagation();
        //         showImage(currentIndex + 1);
        //     });

        //     function closeModal() {
        //         overlay.classList.remove('active');
        //         setTimeout(() => {
        //             if (overlay && overlay.parentNode) {
        //                 overlay.remove();
        //             }
        //         }, 300);
        //     }

        //     closeBtn.addEventListener('click', closeModal);
        //     overlay.addEventListener('click', (e) => {
        //         if (e.target === overlay) {
        //             closeModal();
        //         }
        //     });

        //     function handleKeyDown(e) {
        //         if (e.key === 'Escape') {
        //             closeModal();
        //         } else if (e.key === 'ArrowLeft') {
        //             showImage(currentIndex + 1);
        //         } else if (e.key === 'ArrowRight') {
        //             showImage(currentIndex - 1);
        //         }
        //     }
        //     document.addEventListener('keydown', handleKeyDown);

        //     const cleanup = () => {
        //         document.removeEventListener('keydown', handleKeyDown);
        //     };
            
        //     overlay.addEventListener('transitionend', (e) => {
        //         if (!overlay.classList.contains('active')) {
        //             cleanup();
        //         }
        //     });

        //     window.closePropertyModal = closeModal;
        // }

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

        function requestContactForProperty(id) {
            const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
            if (!isLoggedIn) {
                // احفظ صفحة العودة ثم افتح بوب آب تسجيل الدخول
                localStorage.setItem('afterLoginRedirect', window.location.pathname + window.location.search);
                if (window.openLoginPopup) { openLoginPopup(); } else { window.location.href = 'login-popup.html'; }
                return;
            }

            // اجمع بيانات الطلب واحفظها في localStorage حتى يراها المالك في لوحة الإدارة
            const property = propertiesData.find(item => item.id === id) || {};
            const userEmail = localStorage.getItem('userEmail') || '';
            const userData = JSON.parse(localStorage.getItem('userData') || '{}');
            const userName = userData.name || (userEmail ? userEmail.split('@')[0] : 'زائر');

            const requests = JSON.parse(localStorage.getItem('contactRequests') || '[]');
            const req = {
                id: 'cr_' + Date.now(),
                propertyId: id,
                propertyTitle: property.title || '',
                ownerName: property.owner && property.owner.name ? property.owner.name : '',
                ownerEmail: property.owner && property.owner.email ? property.owner.email : '',
                ownerPhone: property.owner && property.owner.phone ? property.owner.phone : '',
                customerName: userName,
                customerPhone: userData.phone || userData.mobile || '',
                customerEmail: userEmail,
                date: new Date().toISOString(),
                status: 'new'
            };
            requests.unshift(req);
            localStorage.setItem('contactRequests', JSON.stringify(requests));

            alert('تم إرسال طلب تواصل؛ سيصل المالك إشعارًا داخل لوحة الإدارة.');
        }

        window.handleAddProperty = function(event) {
            event.preventDefault();
            const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
            if (isLoggedIn) {
                window.location.href = 'add-properties.html';
                return;
            }

            localStorage.setItem('afterLoginRedirect', 'add-properties.html');
            if (window.openLoginPopup) {
                openLoginPopup();
            } else {
                window.location.href = 'login-popup.html';
            }
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
        // طلبات المراسلة 
        // كود تجريبي يوضع في صفحة العقار عند الضغط على إرسال المراسلة
// let currentRequests = JSON.parse(localStorage.getItem('contactRequests') || '[]');

// let newRequest = {
//     propertyTitle: "سكن طلابي - المزة دمشق", // عنوان العقار من الصفحة
//     date: new Date().toISOString(),
//     customerEmail: "student@example.com", // مدخلات الزبون
//     customerPhone: "0912345678"
// };
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


