<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>إضافة عقار جديد - عقاراتي</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/site.css">
    <link rel="stylesheet" href="style/add-properties.css">
    <link rel="stylesheet" href="style/properties.css">
    <link rel="stylesheet" href="style/nav.css">
</head>
<body>
    <div id="navbar-container"></div>

   
    <script>
    const isLoggedIn = localStorage.getItem('authToken');
    const currentUser = JSON.parse(localStorage.getItem('user') || 'null');

        if (!isLoggedIn) {
            // غير مسجّل — احفظ الـ redirect وأرسله لتسجيل الدخول
            localStorage.setItem('afterLoginRedirect', 'add-properties.html');
            window.location.href = 'login-popup.html';
        // } else if (currentUser && currentUser.role === 'owner') {
        //     // مسجّل ومالك — أرسله للداش بورد مباشرة
        //     window.location.href = 'pending-approval.html';
        }
        // tenant عادي — يبقى في الصفحة ليضيف عقاره
</script>
    <header class="page-header">
        <h1>إضافة عقار جديد</h1>
        <p>أضف عقارك ليصل إلى آلاف المستأجرين المحتملين</p>
    </header>

    <main class="container">
        <div class="form-card">
            <h2 class="form-title">معلومات العقار</h2>

            <form id="property-form" novalidate enctype="multipart/form-data">
                <!-- معلومات أساسية -->
                <div class="form-section">
                    <h3 class="section-title">المعلومات الأساسية</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="property-title">عنوان العقار <span class="required">*</span></label>
                            <input type="text" id="property-title" name="title" required placeholder="مثال: شقة فاخرة في مركز المدينة">
                        </div>

                        <div class="form-group">
                            <label for="property-type">نوع العقار <span class="required">*</span></label>
                            <!-- <select id="property-type" name="type" required> -->
                                <select id="property-type" name="property_type" required>
                                <option value="">اختر نوع العقار</option>
                                <option value="apartment">شقة</option>
                                <option value="house">منزل</option>
                                <option value="villa">فيلا</option>
                                <option value="office">مكتب</option>
                                <option value="shop">محل تجاري</option>
                                <option value="warehouse">مستودع</option>
                                <option value="land">أرض</option>
                                <option value="shared">منزل مشترك</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="property-price">السعر (ليرة سورية) <span class="required">*</span></label>
                            <input type="number" id="property-price" name="price" min="0" required placeholder="أدخل السعر بالليرة السورية">
                        </div>

                        <div class="form-group">
                            <label for="property-area">المساحة (متر مربع) <span class="required">*</span></label>
                            <input type="number" id="property-area" name="area" min="0" required placeholder="أدخل المساحة بالمتر المربع">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="bedrooms">عدد غرف النوم</label>
                            <input type="number" id="bedrooms" name="bedrooms" min="0" placeholder="عدد غرف النوم">
                        </div>

                        <div class="form-group">
                            <label for="university">مرتبط بالجامعة؟ <span class="required">*</span></label>
                            <select id="university" name="university" required onchange="toggleUniversityBox()">
                                <option value="">اختر</option>
                                <option value="yes">نعم</option>
                                <option value="no">لا</option>
                            </select>
                        </div>
                    </div>
    </div>
</div>


                    <div class="form-row">
                        <div class="form-group" id="university-name-group" style="display: none;">
                          <label for="university-name">اسم الجامعة <span class="required">*</span></label>
                            <select id="university-name" name="university_id">
                                <option value="">جاري تحميل الجامعات...</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group" id="division-accept-group" style="display: none;">
                            <label for="division-accept">هل يقبل التقسيم على أفراد؟ <span class="required">*</span></label>
                            <select id="division-accept" name="division_accept" onchange="toggleDivisionCount()">
                                <option value="">اختر</option>
                                <option value="yes">نعم</option>
                                <option value="no">لا</option>
                            </select>
                        </div>

                        <div class="form-group" id="division-count-group" style="display: none;">
                            <label for="division-count">عدد الأفراد</label>
                            <select id="division-count" name="division_count">
                                <option value="">اختر العدد</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6+">6+</option>
                            </select>
                            
                        </div>
                        
                    </div>
                    <!-- يظهر فقط بعد تحديد يقبل التقسيم = نعم -->
<div class="form-row" id="discount-main-group" style="display:none;">
    <div class="form-group">
        <label for="has_student_discount">هل يوجد خصم للطلاب؟</label>
        <select id="has_student_discount" name="has_student_discount" 
                onchange="toggleDiscountField()">
            <option value="0">لا</option>
            <option value="1">نعم</option>
        </select>
    </div>
    <div class="form-group" id="discount-pct-group" style="display:none;">
        <label for="student_discount_percentage">نسبة الخصم % <span >*</span></label>
                  <input type="number" id="student_discount_percentage" 
                    name="student_discount_percentage" 
                    min="1" max="100" 
                    placeholder="أدخل نسبة الخصم (1-100)"  >
                  

                    </div>
                </div>
                </div>

                <!-- الموقع -->
                <div class="form-section">
                    <h3 class="section-title">الموقع</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">المدينة <span class="required">*</span></label>
                            <select id="city" name="city" required>
                                <option value="">اختر المدينة</option>
                                <option value="damascus">دمشق</option>
                                <option value="aleppo">حلب</option>
                                <option value="homs">حمص</option>
                                <option value="latakia">اللاذقية</option>
                                <option value="hama">حماة</option>
                                <option value="tartus">طرطوس</option>
                                <option value="deir_ezzor">دير الزور</option>
                                <option value="alhasakah">الحسكة</option>
                                <option value="daraa">درعا</option>
                                <option value="as_suwayda">السويداء</option>
                                <option value="idlib">إدلب</option>
                                <option value="quneitra">القنيطرة</option>
                                <option value="raqqa">الرقة</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="district">الحي/المنطقة <span class="required">*</span></label>
                            <input type="text" id="district" name="district" required placeholder="مثال: المالكي، أبو رمانة">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">العنوان التفصيلي <span class="required">*</span></label>
                        <input type="text" id="address" name="address" placeholder="الشارع، الرقم، المعالم القريبة" required>
                    </div>
                </div>

                <!-- التفاصيل والوصف -->
                <div class="form-section">
                    <h3 class="section-title">التفاصيل والوصف</h3>

                    <div class="form-group">
                        <label for="description">وصف العقار <span class="required">*</span></label>
                        <textarea id="description" name="description" placeholder="اكتب وصفاً مفصلاً للعقار... اذكر المميزات والموقع والخدمات المتوفرة" required></textarea>
                    </div>

                    <div class="form-group">
                        <label>المرافق والخدمات</label>
                        <div class="checkbox-grid">
                            <div class="checkbox-group">
                                <input type="checkbox" id="parking" name="amenities" value="parking">
                                <label for="parking">موقف سيارات</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="elevator" name="amenities" value="elevator">
                                <label for="elevator">مصعد</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="security" name="amenities" value="security">
                                <label for="security">أمن وحراسة</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="garden" name="amenities" value="garden">
                                <label for="garden">حديقة</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="pool" name="amenities" value="pool">
                                <label for="pool">مسبح</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="gym" name="amenities" value="gym">
                                <label for="gym">صالة رياضية</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="balcony" name="amenities" value="balcony">
                                <label for="balcony">شرفة</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="furnished" name="amenities" value="furnished">
                                <label for="furnished">مفروش</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- الصور -->
                <div class="form-section">
                    <h3 class="section-title">صور العقار</h3>

                    <div class="form-group">
                        <label>صور العقار (حتى 5 صور)</label>
                        <div class="file-upload" id="fileUploadContainer">
                            <input type="file" id="property-images" name="images" multiple accept="image/*" style="display:none;">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <p>انقر هنا لاختيار الصور أو اسحب وأفلت الملفات</p>
                            <small style="color: #999; display: block; margin-top: 10px;">يمكنك اختيار حتى 5 صور (JPG, PNG, GIF)</small>
                        </div>
                        <div id="image-preview-container" style="display:flex; flex-wrap:wrap; gap:10px; margin-top:12px;"></div>
                    </div>
                </div>

                <!-- معلومات الاتصال -->
                <div class="form-section">
                    <h3 class="section-title">معلومات الاتصال</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="owner-name">اسم المالك <span class="required">*</span></label>
                            <input type="text" id="owner-name" name="owner_name" required placeholder="الاسم الكامل">
                        </div>

                        <div class="form-group">
                            <label for="owner-phone">رقم الهاتف <span class="required">*</span></label>
                            <input type="tel" id="owner-phone" name="owner_phone" required placeholder="مثال: 099999999">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="owner-email">البريد الإلكتروني</label>
                            <input type="email" id="owner-email" name="owner_email" placeholder="example@email.com">
                        </div>

                        <div class="form-group">
                            <label for="payment-method">طريقة الدفع <span class="required">*</span></label>
                            <select id="payment-method" name="payment_method" required>
                                <option value="">اختر طريقة الدفع</option>
                                <option value="cash">نقدي</option>
                                <option value="bank_transfer">تحويل بنكي</option>
                                <option value="check">شيك</option>
                                <option value="installments">تقسيط</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- أزرار الإجراءات -->
                <div class="button-group">
                    <button type="button" class="btn-preview" onclick="previewProperty()">
                        <i class="fas fa-eye"></i>
                        معاينة العقار
                    </button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-plus-circle"></i>
                        إضافة العقار
                    </button>
                </div>
            </form>
        </div>
    </main>

    <div id="footer-container"></div>

    <script>
        // دالة التحكم في إظهار/إخفاء حقل اسم الجامعة
        // function toggleUniversityBox() {
        //     const universitySelect = document.getElementById('university');
        //     const universityNameGroup = document.getElementById('university-name-group');
        //     const universityNameInput = document.getElementById('university-name');
        //     const divisionAcceptGroup = document.getElementById('division-accept-group');
        //     const divisionAcceptSelect = document.getElementById('division-accept');
        //     const divisionCountGroup = document.getElementById('division-count-group');
        //     const divisionCountSelect = document.getElementById('division-count');

        //     if (universitySelect.value === 'yes') {
        //         universityNameGroup.style.display = 'block';
        //         divisionAcceptGroup.style.display = 'block';
        //         universityNameInput.setAttribute('required', '');
        //         divisionAcceptSelect.setAttribute('required', '');
        //         universityNameInput.focus();
        //     } else {
        //         universityNameGroup.style.display = 'none';
        //         divisionAcceptGroup.style.display = 'none';
        //         divisionCountGroup.style.display = 'none';
        //         universityNameInput.removeAttribute('required');
        //         divisionAcceptSelect.removeAttribute('required');
        //         divisionCountSelect.removeAttribute('required');
        //         universityNameInput.value = '';
        //         divisionAcceptSelect.value = '';
        //         divisionCountSelect.value = '';
        //     }
        // }

        // function toggleDivisionCount() {
        //     const divisionAcceptSelect = document.getElementById('division-accept');
        //     const divisionCountGroup = document.getElementById('division-count-group');
        //     const divisionCountSelect = document.getElementById('division-count');

        //     if (divisionAcceptSelect.value === 'yes') {
        //         divisionCountGroup.style.display = 'block';
        //         divisionCountSelect.setAttribute('required', '');
        //     } else {
        //         divisionCountGroup.style.display = 'none';
        //         divisionCountSelect.removeAttribute('required');
        //         divisionCountSelect.value = '';
        //     }
        // }
     function toggleUniversityBox() {
    const uniVal = document.getElementById('university').value;
    const uniNameGroup    = document.getElementById('university-name-group');
    const uniNameInput    = document.getElementById('university-name');
    const divAcceptGroup  = document.getElementById('division-accept-group');
    const divAcceptSelect = document.getElementById('division-accept');
    const divCountGroup   = document.getElementById('division-count-group');
    const divCountSelect  = document.getElementById('division-count');
    const discountGroup   = document.getElementById('discount-main-group');

    if (uniVal === 'yes') {
        // ✔ يظهر: اسم الجامعة + التقسيم + الخصم
        uniNameGroup.style.display  = 'block';
        divAcceptGroup.style.display = 'block';
        discountGroup.style.display  = 'block'; // ← يظهر مباشرة
        uniNameInput.setAttribute('required', '');
        divAcceptSelect.setAttribute('required', '');
    } else {
        // ✔ يخفي كل شي
        uniNameGroup.style.display   = 'none';
        divAcceptGroup.style.display = 'none';
        divCountGroup.style.display  = 'none';
        discountGroup.style.display  = 'none';
        uniNameInput.removeAttribute('required');
        divAcceptSelect.removeAttribute('required');
        divCountSelect.removeAttribute('required');
        uniNameInput.value    = '';
        divAcceptSelect.value = '';
        divCountSelect.value  = '';
        document.getElementById('has_student_discount').value          = '0';
        document.getElementById('discount-pct-group').style.display    = 'none';
        document.getElementById('student_discount_percentage').value   = '';
    }
}

function toggleDivisionCount() {
    const divVal          = document.getElementById('division-accept').value;
    const divCountGroup   = document.getElementById('division-count-group');
    const divCountSelect  = document.getElementById('division-count');
    const discountGroup   = document.getElementById('discount-main-group');

    if (divVal === 'yes') {
        divCountGroup.style.display = 'block';
        divCountSelect.setAttribute('required', '');
        // ✔ بعد تحديد التقسيم يظهر سؤال الخصم
        discountGroup.style.display = 'block';
    } else {
        divCountGroup.style.display  = 'none';
        discountGroup.style.display  = 'none';
        divCountSelect.removeAttribute('required');
        divCountSelect.value = '';
        document.getElementById('has_student_discount').value = '0';
        document.getElementById('discount-pct-group').style.display = 'none';
    }
}

function toggleDiscountField() {
    const val = document.getElementById('has_student_discount').value;
    document.getElementById('discount-pct-group').style.display = val === '1' ? 'block' : 'none';
    if (val !== '1') {
        document.getElementById('student_discount_percentage').value = '';
    }
}

        function clearValidationHighlights(form) {
            const invalidFields = form.querySelectorAll('.invalid-field');
            invalidFields.forEach(field => field.classList.remove('invalid-field'));
        }

        function validatePropertyForm(form) {
            clearValidationHighlights(form);

            const requiredFields = Array.from(form.querySelectorAll('[required]'));
            let firstInvalidField = null;

            requiredFields.forEach(field => {
                const value = String(field.value || '').trim();
                if (!value) {
                    field.classList.add('invalid-field');
                    if (!firstInvalidField) {
                        firstInvalidField = field;
                    }
                }
            });

            const universitySelect = document.getElementById('university');
            const universityNameInput = document.getElementById('university-name');
            const divisionAcceptSelect = document.getElementById('division-accept');
            const divisionCountSelect = document.getElementById('division-count');

            if (universitySelect.value === 'yes') {
                if (!String(universityNameInput.value || '').trim()) {
                    universityNameInput.classList.add('invalid-field');
                    if (!firstInvalidField) {
                        firstInvalidField = universityNameInput;
                    }
                }
                if (!String(divisionAcceptSelect.value || '').trim()) {
                    divisionAcceptSelect.classList.add('invalid-field');
                    if (!firstInvalidField) {
                        firstInvalidField = divisionAcceptSelect;
                    }
                }
                if (divisionAcceptSelect.value === 'yes' && !String(divisionCountSelect.value || '').trim()) {
                    divisionCountSelect.classList.add('invalid-field');
                    if (!firstInvalidField) {
                        firstInvalidField = divisionCountSelect;
                    }
                }
            }

            if (firstInvalidField) {
                firstInvalidField.focus();
                alert('الرجاء ملء جميع الحقول المطلوبة (المميزة بعلامة *)');
                return false;
            }

            return true;
        }

        function serializeFormData(formData) {
            const data = {};
            for (const [key, value] of formData.entries()) {
                if (data[key] !== undefined) {
                    if (!Array.isArray(data[key])) {
                        data[key] = [data[key]];
                    }
                    data[key].push(value);
                } else {
                    data[key] = value;
                }
            }
            return data;
        }

    
async function savePendingProperty(pendingData) {
    const token = localStorage.getItem('authToken');
    if (!token) {
        alert('يجب تسجيل الدخول أولاً');
        window.location.href = 'home.html';
        return;
    }
    
    const form = document.getElementById('property-form');
    const formData = new FormData(form);

    // إضافة الصور بالشكل الصحيح لـ Laravel
    formData.delete('images');

    // ── إصلاح أسماء الحقول ──
    formData.set('region', formData.get('district') || '');
    formData.set('rooms_count', formData.get('bedrooms') || 0);
    formData.set('bathrooms_count', 1);
    formData.delete('district');
    formData.delete('bedrooms');
    formData.set('division_accept', document.getElementById('division-accept')?.value || 'no');
    formData.set('division_count', document.getElementById('division-count')?.value || '');

    // ── is_student_friendly ──
    const isUniversity = formData.get('university') === 'yes';
    formData.set('is_student_friendly', isUniversity ? '1' : '0');

    // ── has_student_discount ──
    const discountVal = isUniversity
        ? (document.getElementById('has_student_discount')?.value || '0')
        : '0';
    formData.delete('has_student_discount');
    formData.set('has_student_discount', discountVal);

    // ── student_discount_percentage ──
    if (discountVal === '1') {
        const pct = document.getElementById('student_discount_percentage')?.value || '';
        formData.set('student_discount_percentage', pct);
    } else {
        formData.delete('student_discount_percentage');
    }

    // ── amenities (checkboxes) → array ──
    formData.delete('amenities');
    document.querySelectorAll('[name="amenities"]:checked')
        .forEach(cb => formData.append('amenities[]', cb.value));

    // ── university_id ──
    formData.delete('university_name');
    if (isUniversity) {
        const uniId = document.getElementById('university-name')?.value || '';
        if (uniId) formData.set('university_id', uniId);
    }

    // إضافة الملفات المختارة من المصفوفة لضمان رفع الصور
    for (let i = 0; i < selectedFiles.length; i++) {
        formData.append('images[]', selectedFiles[i]);
    }

    try {
        const response = await fetch('http://localhost:8000/api/owner/properties', {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer ' + token
            },
            body: formData
        });

        const result = await response.json();

        if (!response.ok) {
            const errors = result.errors 
                ? Object.values(result.errors).flat().join('\n') 
                : result.message;
            alert('فشل الإضافة:\n' + errors);
            return;
        }

        // ✅ تحديث الـ role في localStorage قبل التوجيه
        const savedUser = JSON.parse(localStorage.getItem('user') || '{}');
        savedUser.role = 'owner';
        localStorage.setItem('user', JSON.stringify(savedUser));
        localStorage.setItem('userType', 'owner');

        alert('تم إرسال العقار بنجاح وهو قيد مراجعة الإدارة');
        window.location.href = 'pending-approval.html';
    } catch (e) {
        alert('خطأ في الاتصال: ' + e.message);
    }
}

            // ── إدارة الصور المختارة ──
            const MAX_IMAGES = 5;
            let selectedFiles = []; // مصفوفة الملفات المختارة

            const fileUpload = document.getElementById('fileUploadContainer');
            const fileInput  = document.getElementById('property-images');
            const previewContainer = document.getElementById('image-preview-container');

            fileUpload.addEventListener('click', function() {
                if (selectedFiles.length >= MAX_IMAGES) {
                    alert('لا يمكنك إضافة أكثر من 5 صور');
                    return;
                }
                fileInput.value = '';
                fileInput.click();
            });

            fileInput.addEventListener('change', function() {
                const newFiles = Array.from(this.files);
                const available = MAX_IMAGES - selectedFiles.length;
                const toAdd = newFiles.slice(0, available);

                toAdd.forEach(file => {
                    selectedFiles.push(file);
                    addImagePreview(file, selectedFiles.length - 1);
                });

                if (newFiles.length > available) {
                    alert(`تم إضافة ${toAdd.length} صورة فقط. الحد الأقصى 5 صور.`);
                }

                updateUploadLabel();
            });

            function addImagePreview(file, index) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const wrapper = document.createElement('div');
                    wrapper.dataset.index = index;
                    wrapper.style.cssText = 'position:relative; width:90px; height:90px; border-radius:8px; overflow:hidden; border:2px solid #ddd; flex-shrink:0;';

                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.cssText = 'width:100%; height:100%; object-fit:cover;';

                    const btn = document.createElement('button');
                    btn.type = 'button';
                    btn.innerHTML = '<i class="fas fa-times"></i>';
                    btn.style.cssText = 'position:absolute; top:3px; right:3px; background:rgba(220,53,69,0.85); color:#fff; border:none; border-radius:50%; width:22px; height:22px; font-size:11px; cursor:pointer; display:flex; align-items:center; justify-content:center; padding:0;';
                    btn.addEventListener('click', function(e) {
                        e.stopPropagation();
                        removeImage(parseInt(wrapper.dataset.index));
                    });

                    wrapper.appendChild(img);
                    wrapper.appendChild(btn);
                    previewContainer.appendChild(wrapper);
                };
                reader.readAsDataURL(file);
            }

            function removeImage(index) {
                selectedFiles.splice(index, 1);
                previewContainer.innerHTML = '';
                selectedFiles.forEach((file, i) => addImagePreview(file, i));
                updateUploadLabel();
            }

            function updateUploadLabel() {
                const count = selectedFiles.length;
                const icon  = count >= MAX_IMAGES ? 'fa-check-circle' : 'fa-cloud-upload-alt';
                const color = count >= MAX_IMAGES ? '#27ae60' : 'inherit';
                fileUpload.innerHTML = `
                    <i class="fas ${icon}" style="color:${color};"></i>
                    <p>${count > 0 ? `تم اختيار ${count} صورة` : 'انقر هنا لاختيار الصور أو اسحب وأفلت الملفات'}</p>
                    <small style="color:#999; display:block; margin-top:10px;">${count < MAX_IMAGES ? `يمكنك إضافة ${MAX_IMAGES - count} صورة أخرى` : 'وصلت للحد الأقصى (5 صور)'}</small>
                `;
            }

            const form = document.getElementById('property-form');
            const interactiveFields = form.querySelectorAll('input, select, textarea');
            interactiveFields.forEach(field => {
                field.addEventListener('input', function() {
                    this.classList.remove('invalid-field');
                });
                field.addEventListener('change', function() {
                    this.classList.remove('invalid-field');
                });
            });

            form.addEventListener('submit', async function(e) {
                e.preventDefault();

                if (!validatePropertyForm(form)) {
                    return;
                }

                const formData = new FormData(form);
                const pendingData = serializeFormData(formData);
                pendingData.submissionDate = new Date().toLocaleString('ar-SY');
                pendingData.status = 'قيد المراجعة';
                pendingData.id = 'REQ-' + Date.now();

                await savePendingProperty({});
                
                form.reset();
                clearValidationHighlights(form);
                document.getElementById('university-name-group').style.display = 'none';
                
                selectedFiles = [];
                previewContainer.innerHTML = '';
                updateUploadLabel();
            });

            if (window.updateAuthStatus) {
                updateAuthStatus();
            }

        function propertyTypeLabel(type){
            if (!type) return '';
            return type === 'villa' ? 'فيلا' : (type === 'house' ? 'منزل عادي' : (type === 'shared' ? 'منزل مشترك' : type));
        }

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

        function openPropertyModal(property){
            let overlay = document.getElementById('propertyModalOverlay');
            if (overlay) overlay.remove();
            
            overlay = document.createElement('div');
            overlay.id = 'propertyModalOverlay';
            overlay.className = 'property-modal-overlay active';

            const modal = document.createElement('div');
            modal.className = 'property-modal';

            let currentIndex = 0;
            const rawImages = (property.images && property.images.length) ? property.images : [];
            const imageUrls = rawImages.length
                ? rawImages.map(img => (typeof img === 'string' ? img : (img.image_url || img.path || null))).filter(Boolean)
                : ['data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>لا توجد صورة</text></svg>'];

            let amenitiesHTML = '';
            if (property.amenities && property.amenities.length > 0) {
                const amenitiesList = property.amenities.map(amenity => `
                    <span class="amenity-tag">
                        <i class="fas ${amenitiesIcons[amenity] || 'fa-check'}"></i>
                        ${amenitiesTranslation[amenity] || amenity}
                    </span>
                `).join('');
                
                amenitiesHTML = `
                    <div class="amenities-section">
                        <h4>المرافق والخدمات</h4>
                        <div class="amenities-list">${amenitiesList}</div>
                    </div>
                `;
            }

            let featuresHTML = '';
            const features = [];
            if (property.area) {
                features.push(`<div class="feature-item"><i class="fas fa-vector-square"></i><span>${property.area} م²</span></div>`);
            }
            if (property.bedrooms) {
                features.push(`<div class="feature-item"><i class="fas fa-bed"></i><span>${property.bedrooms} غرف</span></div>`);
            }
            if (property.division_accept === 'yes') {
                features.push(`<div class="feature-item"><i class="fas fa-layer-group"></i><span>يقبل التقسيم${property.division_count ? ` لـ ${property.division_count} أفراد` : ''}</span></div>`);
            }

            if (features.length > 0) {
                featuresHTML = `<div class="property-features">${features.join('')}</div>`;
            }

            modal.innerHTML = `
                <div class="modal-scrollable">
                    <div class="property-image">
                        <img src="${imageUrls[0]}" alt="${property.title}" id="modalMainImage" onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>تعذر تحميل الصورة</text></svg>'">
                        <div class="property-status">معاينة</div>
                        <div class="property-type-badge">${propertyTypeLabel(property.type)}</div>
                        <div class="image-counter" id="imageCounter">1 / ${imageUrls.length}</div>
                        <div class="image-nav">
                            <button id="prevImageBtn"><i class="fas fa-chevron-right"></i></button>
                            <button id="nextImageBtn"><i class="fas fa-chevron-left"></i></button>
                        </div>
                    </div>
                    <button class="modal-close" id="modalCloseBtn"><i class="fas fa-times"></i></button>
                    <div class="property-content">
                        <div class="property-price">${property.price ? Number(property.price).toLocaleString('ar-SY') : 'غير محدد'} <span>ل.س</span></div>
                        <h2 class="property-title">${property.title}</h2>
                        <div class="property-location"><i class="fas fa-map-marker-alt"></i><span>${property.city}، ${property.district}، ${property.address}</span></div>
                        ${featuresHTML}
                        <div class="property-description">
                            <h4 style="color: #333; margin-bottom: 10px;">وصف العقار</h4>
                            <p>${property.description || 'لا يوجد وصف'}</p>
                        </div>
                        ${amenitiesHTML}
                        <div class="contact-section">
                            <h4>معلومات التواصل</h4>
                            <div class="contact-info">
                                ${property.owner_name ? `
                                    <div class="contact-item"><i class="fas fa-user"></i><span>${property.owner_name}</span></div>
                                    <div class="contact-item"><i class="fas fa-phone"></i><span dir="ltr" style="direction: ltr;">${property.owner_phone}</span></div>
                                    ${property.owner_email ? `<div class="contact-item"><i class="fas fa-envelope"></i><span>${property.owner_email}</span></div>` : ''}
                                ` : ''}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn-secondary" onclick="closePropertyModal()"><i class="fas fa-times"></i> إغلاق المعاينة</button>
                </div>
            `;

            overlay.appendChild(modal);
            document.body.appendChild(overlay);

            setTimeout(() => overlay.classList.add('active'), 10);

            const mainImage = modal.querySelector('#modalMainImage');
            const imageCounter = modal.querySelector('#imageCounter');
            const prevBtn = modal.querySelector('#prevImageBtn');
            const nextBtn = modal.querySelector('#nextImageBtn');
            const closeBtn = modal.querySelector('#modalCloseBtn');

            function showImage(index) {
                currentIndex = (index + imageUrls.length) % imageUrls.length;
                mainImage.src = imageUrls[currentIndex];
                imageCounter.textContent = `${currentIndex + 1} / ${imageUrls.length}`;
            }

            prevBtn.addEventListener('click', (e) => { e.stopPropagation(); showImage(currentIndex - 1); });
            nextBtn.addEventListener('click', (e) => { e.stopPropagation(); showImage(currentIndex + 1); });

            function closeModal() {
                overlay.classList.remove('active');
                setTimeout(() => { if (overlay && overlay.parentNode) overlay.remove(); }, 300);
            }

            closeBtn.addEventListener('click', closeModal);
            overlay.addEventListener('click', (e) => { if (e.target === overlay) closeModal(); });

            function handleKeyDown(e) {
                if (e.key === 'Escape') closeModal();
                else if (e.key === 'ArrowLeft') showImage(currentIndex + 1);
                else if (e.key === 'ArrowRight') showImage(currentIndex - 1);
            }
            document.addEventListener('keydown', handleKeyDown);

            overlay.addEventListener('transitionend', (e) => {
                if (!overlay.classList.contains('active')) {
                    document.removeEventListener('keydown', handleKeyDown);
                }
            });

            window.closePropertyModal = closeModal;
        }

        function previewProperty() {
            const form = document.getElementById('property-form');
            if (!validatePropertyForm(form)) return;

            const formData = new FormData(form);
            const propertyData = {
                title: formData.get('title'), type: formData.get('type'), price: formData.get('price'),
                area: formData.get('area'), bedrooms: formData.get('bedrooms'), university: formData.get('university'),
                university_name: formData.get('university_name'), division_accept: formData.get('division_accept'),
                division_count: formData.get('division_count'), city: formData.get('city'), district: formData.get('district'),
                address: formData.get('address'), description: formData.get('description'), owner_name: formData.get('owner_name'),
                owner_phone: formData.get('owner_phone'), owner_email: formData.get('owner_email'),
                payment_method: formData.get('payment_method'), amenities: formData.getAll('amenities'), images: []
            };
            
            if (selectedFiles.length > 0) {
                let loadedImages = 0;
                const totalImages = selectedFiles.length;
                
                const previewBtn = document.querySelector('.btn-preview');
                const originalText = previewBtn.innerHTML;
                previewBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري تجهيز الصور...';
                previewBtn.disabled = true;
                
                for (let i = 0; i < selectedFiles.length; i++) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        propertyData.images.push(e.target.result);
                        loadedImages++;
                        if (loadedImages === totalImages) {
                            openPropertyModal(propertyData);
                            previewBtn.innerHTML = originalText;
                            previewBtn.disabled = false;
                        }
                    };
                    reader.readAsDataURL(selectedFiles[i]);
                }
            } else {
                openPropertyModal(propertyData);
            }
        }

        async function loadUniversitiesIntoSelect() {
            const select = document.getElementById('university-name');
            if (!select) return;
            try {
                const res = await fetch('http://localhost:8000/api/universities', { headers: { 'Accept': 'application/json' } });
                const data = await res.json();
                const unis = data.data || [];
                select.innerHTML = '<option value="">اختر الجامعة</option>';
                unis.forEach(u => {
                    const opt = document.createElement('option');
                    opt.value = u.id;
                    opt.textContent = `${u.name} - ${u.city}`;
                    select.appendChild(opt);
                });
            } catch (e) {
                select.innerHTML = '<option value="">فشل تحميل الجامعات</option>';
            }
        }
        document.addEventListener('DOMContentLoaded', loadUniversitiesIntoSelect);

// ── وضع التعديل ──────────────────────────────
const editId = new URLSearchParams(window.location.search).get('edit');

if (editId) {
    document.querySelector('.page-header h1').textContent = 'تعديل العقار';
    document.querySelector('.page-header p').textContent = 'عدّل بيانات عقارك ثم احفظ التعديلات';
    document.querySelector('.form-title').textContent = 'تعديل معلومات العقار';

    const submitBtn = document.querySelector('.btn-submit');
    if (submitBtn) {
        submitBtn.innerHTML = '<i class="fas fa-save"></i> حفظ التعديلات';

        const cancelBtn = document.createElement('button');
        cancelBtn.type = 'button';
        cancelBtn.className = 'btn-secondary';
        cancelBtn.style.cssText = `
            padding:14px 32px;border:2px solid #8B7FD2;background:#fff;
            color:#8B7FD2;border-radius:10px;font-size:1rem;cursor:pointer;
            margin-right:10px;font-family:Cairo,sans-serif;font-weight:600;`;
        cancelBtn.innerHTML = '<i class="fas fa-times"></i> إلغاء';
        cancelBtn.onclick = () => window.location.href = 'pending-approval.html';
        submitBtn.parentElement.insertBefore(cancelBtn, submitBtn);
    }

    async function loadPropertyForEdit() {
        const token = localStorage.getItem('authToken');
        try {
            const res = await fetch(`http://localhost:8000/api/owner/properties/${editId}`, {
                headers: { 'Accept':'application/json', 'Authorization':'Bearer '+token }
            });
            const data = await res.json();
            const p = data.data || data;

            document.getElementById('property-title').value   = p.title || '';
            document.getElementById('property-type').value    = p.property_type || '';
            document.getElementById('property-price').value   = p.price || '';
            document.getElementById('property-area').value    = p.area || '';
            document.getElementById('bedrooms').value         = p.rooms_count || '';

            const cityEl = document.getElementById('city');
            if (cityEl) { cityEl.value = p.city || ''; }
            const districtEl = document.getElementById('district');
            if (districtEl) districtEl.value = p.district || '';
            const addressEl = document.getElementById('address');
            if (addressEl) addressEl.value = p.address || '';
            const descEl = document.getElementById('description');
            if (descEl) descEl.value = p.description || '';

            const uniSelect = document.getElementById('university');
            if (uniSelect) {
                uniSelect.value = p.university_id ? 'yes' : 'no';
                toggleUniversityBox();
            }
            const uniName = document.getElementById('university-name');
            if (uniName && p.university_id) uniName.value = p.university_id;

            const discountSelect = document.getElementById('has_student_discount');
            if (discountSelect) discountSelect.value = p.has_student_discount ? '1' : '0';
            const discountPct = document.getElementById('student_discount_percentage');
            if (discountPct) discountPct.value = p.student_discount_percentage || '';

            const paymentEl = document.getElementById('payment-method');
            if (paymentEl) paymentEl.value = p.payment_method || '';

            const divAccept = document.getElementById('division-accept');
            if (divAccept) divAccept.value = p.division_accept || 'no';
            const divCount = document.getElementById('division-count');
            if (divCount) divCount.value = p.division_count || '';

            // ✅ إصلاح الخطأ البرمجي في جلب المرافق بإضافة علامات الاقتباس الصحيحة (Backticks)
            if (p.amenities && Array.isArray(p.amenities)) {
                p.amenities.forEach(a => {
                    const cb = document.querySelector(`[name="amenities"][value="${a}"]`);
                    if (cb) cb.checked = true;
                });
            }

        } catch(e) {
            alert('فشل تحميل بيانات العقار: ' + e.message);
        }
    }

    loadPropertyForEdit();
}

// ── تعديل savePendingProperty لدعم وضع التعديل ──
const _originalSave = savePendingProperty;
savePendingProperty = async function(pendingData) {
    if (!editId) {
        return _originalSave(pendingData);
    }

    const token = localStorage.getItem('authToken');
    const form  = document.getElementById('property-form');
    const fd    = new FormData(form);

    fd.set('region',       fd.get('district') || '');
    fd.set('rooms_count',  fd.get('bedrooms')  || 0);
    fd.delete('bedrooms');
    fd.delete('district'); 
    fd.set('is_available', '1');
    fd.set('is_student_friendly', fd.get('university') === 'yes' ? '1' : '0');
    fd.set('has_student_discount', document.getElementById('has_student_discount')?.value === '1' ? '1' : '0');
    fd.set('division_accept', document.getElementById('division-accept')?.value || 'no');
    fd.set('division_count', document.getElementById('division-count')?.value || '');

    fd.delete('amenities');
    document.querySelectorAll('[name="amenities"]:checked')
        .forEach(cb => fd.append('amenities[]', cb.value));

    // إرسال الصور في حال تم تعديلها
    for (let i = 0; i < selectedFiles.length; i++) {
        fd.append('images[]', selectedFiles[i]);
    }

    fd.append('_method', 'PUT');

    const submitBtn = document.querySelector('.btn-submit');
    if (submitBtn) { submitBtn.disabled = true; submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري الحفظ...'; }

    try {
        const res = await fetch(`http://localhost:8000/api/owner/properties/${editId}`, {
            method: 'POST',
            headers: { 'Accept':'application/json', 'Authorization':'Bearer '+token },
            body: fd
        });
        const data = await res.json();
        if (!res.ok) {
            const errors = data.errors ? Object.values(data.errors).flat().join('\n') : data.message;
            alert('فشل الحفظ:\n' + errors);
            return;
        }
        alert('✅ تم حفظ التعديلات بنجاح وعاد العقار قيد الانتظار!');
        window.location.href = 'pending-approval.html';
    } catch(e) {
        alert('خطأ: ' + e.message);
    } finally {
        if (submitBtn) { submitBtn.disabled = false; submitBtn.innerHTML = '<i class="fas fa-save"></i> حفظ التعديلات'; }
    }
};
</script>
    </script>
    <script src="js/api-integration.js"></script>
    <!-- <script src="js/add-property-submit.js"></script> -->
    <script src="js/auth-manager.js"></script>
    <script src="js/includes.js"></script>
</body>
</html>