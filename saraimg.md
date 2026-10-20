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
        // const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
        const isLoggedIn = localStorage.getItem('authToken');
        if (!isLoggedIn) {
            localStorage.setItem('afterLoginRedirect', 'add-properties.html');
            window.location.href = 'login-popup.html';
        }
    </script>

    <header class="page-header">
        <h1>إضافة عقار جديد</h1>
        <p>أضف عقارك ليصل إلى آلاف المستأجرين المحتملين</p>
    </header>

    <main class="container">
        <div class="form-card">
            <h2 class="form-title">معلومات العقار</h2>

            <form id="property-form" enctype="multipart/form-data">
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

                    <div class="form-row">
                        <div class="form-group" id="university-name-group" style="display: none;">
                            <label for="university-name">اسم الجامعة <span class="required">*</span></label>
                            <input type="text" id="university-name" name="university_name" placeholder="اكتب اسم الجامعة">
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
        <label>صور العقار (يمكنك اختيار حتى 5 صور، الأولى ستكون الرئيسية) <span class="required">*</span></label>
        <div class="file-upload" id="fileUploadContainer" style="position: relative; border: 2px dashed #ccc; padding: 20px; text-align: center; cursor: pointer;">
            <input type="file" id="property-images" accept="image/*" multiple style="position: absolute; opacity: 0; width: 100%; height: 100%; top: 0; left: 0; cursor: pointer;">
            <i class="fas fa-cloud-upload-alt" style="font-size: 40px; color: #007bff;"></i>
            <p id="upload-text">انقر هنا لاختيار الصور أو اسحب وأفلت الملفات</p>
            <small style="color: #999; display: block; margin-top: 10px;">الحد الأقصى 5 صور (JPG, PNG, GIF)</small>
        </div>
        
        <div id="images-preview-container" class="images-preview-grid"></div>
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
    // 1. مصفوفة بالذاكرة للاحتفاظ بالملفات الفعلية المرفوعة
    let selectedImagesArray = [];

    // دالة التحكم في إظهار/إخفاء حقل اسم الجامعة
    function toggleUniversityBox() {
        const universitySelect = document.getElementById('university');
        const universityNameGroup = document.getElementById('university-name-group');
        const universityNameInput = document.getElementById('university-name');
        const divisionAcceptGroup = document.getElementById('division-accept-group');
        const divisionAcceptSelect = document.getElementById('division-accept');
        const divisionCountGroup = document.getElementById('division-count-group');
        const divisionCountSelect = document.getElementById('division-count');

        if (universitySelect && universitySelect.value === 'yes') {
            if(universityNameGroup) universityNameGroup.style.display = 'block';
            if(divisionAcceptGroup) divisionAcceptGroup.style.display = 'block';
            if(universityNameInput) { universityNameInput.setAttribute('required', ''); universityNameInput.focus(); }
            if(divisionAcceptSelect) divisionAcceptSelect.setAttribute('required', '');
        } else {
            if(universityNameGroup) universityNameGroup.style.display = 'none';
            if(divisionAcceptGroup) divisionAcceptGroup.style.display = 'none';
            if(divisionCountGroup) divisionCountGroup.style.display = 'none';
            if(universityNameInput) { universityNameInput.removeAttribute('required'); universityNameInput.value = ''; }
            if(divisionAcceptSelect) { divisionAcceptSelect.removeAttribute('required'); divisionAcceptSelect.value = ''; }
            if(divisionCountSelect) { divisionCountSelect.removeAttribute('required'); divisionCountSelect.value = ''; }
        }
    }

    function toggleDivisionCount() {
        const divisionAcceptSelect = document.getElementById('division-accept');
        const divisionCountGroup = document.getElementById('division-count-group');
        const divisionCountSelect = document.getElementById('division-count');

        if (divisionAcceptSelect && divisionAcceptSelect.value === 'yes') {
            if(divisionCountGroup) divisionCountGroup.style.display = 'block';
            if(divisionCountSelect) divisionCountSelect.setAttribute('required', '');
        } else {
            if(divisionCountGroup) divisionCountGroup.style.display = 'none';
            if(divisionCountSelect) { divisionCountSelect.removeAttribute('required'); divisionCountSelect.value = ''; }
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

        if (universitySelect && universitySelect.value === 'yes') {
            if (universityNameInput && !String(universityNameInput.value || '').trim()) {
                universityNameInput.classList.add('invalid-field');
                if (!firstInvalidField) { firstInvalidField = universityNameInput; }
            }
            if (divisionAcceptSelect && !String(divisionAcceptSelect.value || '').trim()) {
                divisionAcceptSelect.classList.add('invalid-field');
                if (!firstInvalidField) { firstInvalidField = divisionAcceptSelect; }
            }
            if (divisionAcceptSelect && divisionAcceptSelect.value === 'yes' && divisionCountSelect && !String(divisionCountSelect.value || '').trim()) {
                divisionCountSelect.classList.add('invalid-field');
                if (!firstInvalidField) { firstInvalidField = divisionCountSelect; }
            }
        }

        if (firstInvalidField) {
            firstInvalidField.focus();
            alert('الرجاء ملء جميع الحقول المطلوبة (المميزة بعلامة *)');
            return false;
        }

        return true;
    }

    // 2. تفعيل حاوية الرفع والارتباط بالـ DOM بعد تحميل الصفحة تماماً
    document.addEventListener("DOMContentLoaded", function() {
        const fileUpload = document.getElementById('fileUploadContainer');
        const fileInput = document.getElementById('property-images');
        const form = document.getElementById('property-form');

        if(fileUpload && fileInput) {
            fileUpload.addEventListener('click', function(e) {
                if (e.target !== fileInput) {
                    fileInput.click();
                }
            });

            fileInput.addEventListener('change', function() {
                const files = Array.from(this.files);
                
                if (selectedImagesArray.length + files.length > 5) {
                    alert('عذراً، الحد الأقصى المسموح به هو 5 صور فقط لعرض العقار.');
                    this.value = '';
                    return;
                }

                files.forEach(file => {
                    if (file.type.startsWith('image/')) {
                        selectedImagesArray.push(file);
                    }
                });

                this.value = '';
                renderImagesPreview();
            });
        }

        // منع الفورم من إرسال نفسه بالطريقة التقليدية التي تسبب اختفاء البيانات والريفريش المزعج
        if (form) {
            form.addEventListener('submit', function(e) {
                e.preventDefault(); // إيقاف السلوك الافتراضي للمتصفح فوراً
                savePendingProperty(); // استدعاء دالة الرفع الاحترافية بالخلفية
            });
        }
        
        if (window.updateAuthStatus) {
            window.updateAuthStatus();
        }
    });

    // دالة بناء وعرض الصور المصغرة مع ميزة الحذف وتحديد الرئيسية
    function renderImagesPreview() {
        const previewContainer = document.getElementById('images-preview-container');
        const fileUpload = document.getElementById('fileUploadContainer');
        const uploadText = document.getElementById('upload-text');
        
        if(!previewContainer) return;
        previewContainer.innerHTML = ''; 

        if (selectedImagesArray.length === 0) {
            if(uploadText) uploadText.textContent = "انقر هنا لاختيار الصور أو اسحب وأفلت الملفات";
            if(fileUpload) {
                let statusIcon = fileUpload.querySelector('.fa-check-circle, .fa-cloud-upload-alt');
                if (statusIcon) {
                    statusIcon.className = 'fas fa-cloud-upload-alt';
                    statusIcon.style.color = '#007bff';
                }
            }
            return;
        }

        if(uploadText) uploadText.textContent = `تم اختيار ${selectedImagesArray.length} من أصل 5 صور`;
        if(fileUpload) {
            let statusIcon = fileUpload.querySelector('.fa-cloud-upload-alt, .fa-check-circle');
            if (statusIcon) {
                statusIcon.className = 'fas fa-check-circle';
                statusIcon.style.color = '#27ae60';
            }
        }

        selectedImagesArray.forEach((file, index) => {
            const wrapper = document.createElement('div');
            wrapper.className = 'preview-image-wrapper';
            
            if (index === 0) {
                wrapper.classList.add('main-image');
            }

            const img = document.createElement('img');
            img.src = URL.createObjectURL(file);
            
            const removeBtn = document.createElement('button');
            removeBtn.type = 'button';
            removeBtn.className = 'remove-image-btn';
            removeBtn.innerHTML = '<i class="fas fa-times"></i>';
            
            removeBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                URL.revokeObjectURL(img.src);
                selectedImagesArray.splice(index, 1);
                renderImagesPreview();
            });

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            previewContainer.appendChild(wrapper);
        });
    }

    // 3. دالة الإرسال الثابتة والمعدلة لمنع أي ريفريش مفاجئ
    async function savePendingProperty() {
        const token = localStorage.getItem('authToken');
        if (!token) {
            alert('يجب تسجيل الدخول أولاً');
            window.location.href = 'home.html';
            return;
        }

        const form = document.getElementById('property-form');
        if (!validatePropertyForm(form)) {
            return; 
        }

        if (selectedImagesArray.length === 0) {
            alert('يرجى رفع صورة واحدة على الأقل للعقار (الصورة الأولى ستكون واجهة العقار الرئيسية)');
            return;
        }

        // تعطيل زر الحفظ مؤقتاً لمنع الكبسات المتكررة أثناء المعالجة
        const submitBtn = form.querySelector('button[type="submit"]') || form.querySelector('.btn-submit');
        let originalBtnText = "";
        if(submitBtn) {
            originalBtnText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري إرسال العقار...';
            submitBtn.disabled = true;
        }

        const formData = new FormData(form);

        // تنظيف مدخلات الصور لعدم تعارضها مع المصفوفة بالذاكرة
        formData.delete('images');
        formData.delete('images[]');
        
        formData.append('region', formData.get('district') || '');
        formData.append('rooms_count', formData.get('bedrooms') || 0);
        formData.append('bathrooms_count', 1); 
        formData.append('is_student_friendly', formData.get('university') === 'yes' ? 1 : 0);
        formData.append('has_student_discount', 0);
        
        // إرفاق ملفات الصور الفعلية من المصفوفة بالترتيب
        selectedImagesArray.forEach(file => {
            formData.append('images[]', file);
        });

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
                
                // إعادة الزر للعمل في حال الفشل لإتاحة التعديل
                if(submitBtn) {
                    submitBtn.innerHTML = originalBtnText;
                    submitBtn.disabled = false;
                }
                return;
            }

            alert('تم إرسال العقار بنجاح وهو قيد مراجعة الإدارة');
            window.location.href = 'pending-approval.html';

        } catch (e) {
            alert('خطأ في الاتصال بالسيرفر: ' + e.message);
            if(submitBtn) {
                submitBtn.innerHTML = originalBtnText;
                submitBtn.disabled = false;
            }
        }
    }

    // دالة المعاينة (Preview) المحدثة
    function previewProperty() {
        const form = document.getElementById('property-form');
        if (!validatePropertyForm(form)) {
            return;
        }

        const formData = new FormData(form);
        
        const propertyData = {
            title: formData.get('title'),
            type: formData.get('property_type') || formData.get('type'),
            price: formData.get('price'),
            area: formData.get('area'),
            bedrooms: formData.get('bedrooms'),
            university: formData.get('university'),
            university_name: formData.get('university_name'),
            division_accept: formData.get('division_accept'),
            division_count: formData.get('division_count'),
            city: formData.get('city'),
            district: formData.get('district'),
            address: formData.get('address'),
            description: formData.get('description'),
            owner_name: formData.get('owner_name'),
            owner_phone: formData.get('owner_phone'),
            owner_email: formData.get('owner_email'),
            payment_method: formData.get('payment_method'),
            amenities: formData.getAll('amenities[]') || formData.getAll('amenities'),
            images: []
        };
        
        if (selectedImagesArray.length > 0) {
            let loadedImages = 0;
            const totalImages = selectedImagesArray.length;
            
            const previewBtn = document.querySelector('.btn-preview');
            const originalText = previewBtn ? previewBtn.innerHTML : '';
            if(previewBtn) {
                previewBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> جاري تجهيز الصور...';
                previewBtn.disabled = true;
            }
            
            for (let i = 0; i < selectedImagesArray.length; i++) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    propertyData.images.push(e.target.result);
                    loadedImages++;
                    
                    if (loadedImages === totalImages) {
                        openPropertyModal(propertyData);
                        if(previewBtn) {
                            previewBtn.innerHTML = originalText;
                            previewBtn.disabled = false;
                        }
                    }
                };
                
                reader.onerror = function() {
                    loadedImages++;
                    if (loadedImages === totalImages) {
                        openPropertyModal(propertyData);
                        if(previewBtn) {
                            previewBtn.innerHTML = originalText;
                            previewBtn.disabled = false;
                        }
                    }
                };
                
                reader.readAsDataURL(selectedImagesArray[i]);
            }
        } else {
            openPropertyModal(propertyData);
        }
    }

    function propertyTypeLabel(type){
        if (!type) return '';
        return type === 'villa' ? 'فيلا' : (type === 'house' ? 'منزل عادي' : (type === 'shared' ? 'منزل مشترك' : type));
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

    function openPropertyModal(property){
        let overlay = document.getElementById('propertyModalOverlay');
        if (overlay) overlay.remove();
        
        overlay = document.createElement('div');
        overlay.id = 'propertyModalOverlay';
        overlay.className = 'property-modal-overlay active';

        const modal = document.createElement('div');
        modal.className = 'property-modal';

        let currentIndex = 0;
        const imageUrls = (property.images && property.images.length) ? property.images : ['data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22450%22 height=%22300%22><rect fill=%22%23f0f0f0%22 width=%22450%22 height=%22300%22/><text fill=%22%23999%22 x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 font-size=%2218%22>لا توجد صورة</text></svg>'];

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
                    <div class="amenities-list">
                        ${amenitiesList}
                    </div>
                </div>
            `;
        }

        let featuresHTML = '';
        const features = [];
        if (property.area) {
            features.push(`
                <div class="feature-item">
                    <i class="fas fa-vector-square"></i>
                    <span>${property.area} م²</span>
                </div>
            `);
        }
        if (property.bedrooms) {
            features.push(`
                <div class="feature-item">
                    <i class="fas fa-bed"></i>
                    <span>${property.bedrooms} غرف</span>
                </div>
            `);
        }
        if (property.division_accept === 'yes') {
            features.push(`
                <div class="feature-item">
                    <i class="fas fa-layer-group"></i>
                    <span>يقبل التقسيم${property.division_count ? ` لـ ${property.division_count} أفراد` : ''}</span>
                </div>
            `);
        }

        if (features.length > 0) {
            featuresHTML = `
                <div class="property-features">
                    ${features.join('')}
                </div>
            `;
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
                <button class="modal-close" id="modalCloseBtn">
                    <i class="fas fa-times"></i>
                </button>
                <div class="property-content">
                    <div class="property-price">
                        ${property.price ? Number(property.price).toLocaleString('ar-SY') : 'غير محدد'} 
                        <span>ل.س</span>
                    </div>
                    <h2 class="property-title">${property.title}</h2>
                    <div class="property-location">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>${property.city}، ${property.district}، ${property.address}</span>
                    </div>
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
                                <div class="contact-item">
                                    <i class="fas fa-user"></i>
                                    <span>${property.owner_name}</span>
                                </div>
                                <div class="contact-item">
                                    <i class="fas fa-phone"></i>
                                    <span dir="ltr" style="direction: ltr;">${property.owner_phone}</span>
                                </div>
                                ${property.owner_email ? `
                                <div class="contact-item">
                                    <i class="fas fa-envelope"></i>
                                    <span>${property.owner_email}</span>
                                </div>
                                ` : ''}
                            ` : ''}
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn-secondary" onclick="closePropertyModal()">
                    <i class="fas fa-times"></i>
                    إغلاق المعاينة
                </button>
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

        prevBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            showImage(currentIndex - 1);
        });

        nextBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            showImage(currentIndex + 1);
        });

        function closeModal() {
            overlay.classList.remove('active');
            setTimeout(() => {
                if (overlay && overlay.parentNode) {
                    overlay.remove();
                }
            }, 300);
        }

        closeBtn.addEventListener('click', closeModal);
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) {
                closeModal();
            }
        });

        function handleKeyDown(e) {
            if (e.key === 'Escape') {
                closeModal();
            } else if (e.key === 'ArrowLeft') {
                showImage(currentIndex + 1);
            } else if (e.key === 'ArrowRight') {
                showImage(currentIndex - 1);
            }
        }
        document.addEventListener('keydown', handleKeyDown);

        const cleanup = () => {
            document.removeEventListener('keydown', handleKeyDown);
        };
        
        overlay.addEventListener('transitionend', (e) => {
            if (!overlay.classList.contains('active')) {
                cleanup();
            }
        });

        window.closePropertyModal = closeModal;
    }
</script>
   
    <script src="js/api-integration.js"></script>
    <script src="js/add-property-submit.js"></script>
    <script src="js/auth-manager.js"></script>
    <script src="js/includes.js"></script>
</body>
</html>
<!--  -->
/* ========== add-properties.css - تنسيقات صفحة إضافة العقار ========== */

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f6f8fb;
    margin: 0;
}

.page-header {
    padding: 105px 0px 85px 0px;
    background: #f6f8fb;
    color: #667eea;
    text-align: center;
    margin-bottom: -77px;
}

.page-header p {
    margin-top: 10px;
}

.container {
    max-width: 800px;
    margin: 28px auto;
    padding: 0 16px;
}

.form-card {
    background: #fff;
    border-radius: 14px;
    padding: 30px;
    box-shadow: 0 6px 20px rgba(36, 37, 61, 0.06);
}

.form-title {
    color: #333;
    margin-bottom: 30px;
    text-align: center;
    font-size: 1.8rem;
    font-weight: 700;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #555;
    font-weight: 600;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 12px 14px;
    border: 1px solid #e1e4ee;
    border-radius: 10px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.form-group textarea {
    resize: vertical;
    min-height: 100px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

@media (max-width: 768px) {
    .form-row {
        grid-template-columns: 1fr;
    }
}

.file-upload {
    border: 2px dashed #e1e4ee;
    border-radius: 10px;
    padding: 40px;
    text-align: center;
    cursor: pointer;
    transition: border-color 0.3s ease;
    position: relative;
}

.file-upload:hover {
    border-color: #667eea;
}

.file-upload input[type="file"] {
    position: absolute;
    opacity: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
    top: 0;
    left: 0;
}

.file-upload i {
    font-size: 3rem;
    color: #667eea;
    margin-bottom: 10px;
}

.file-upload p {
    color: #666;
    margin: 0;
}

.checkbox-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.checkbox-group input[type="checkbox"] {
    width: auto;
    margin: 0;
}

.btn-submit {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: #fff;
    border: none;
    padding: 15px 30px;
    border-radius: 10px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    transition: transform 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-submit:hover {
    transform: translateY(-2px);
}

.btn-preview {
    background: white;
    color: #667eea;
    border: 2px solid #667eea;
    padding: 15px 30px;
    border-radius: 10px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-preview:hover {
    background: #f0f2ff;
    transform: translateY(-2px);
}

.button-group {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 15px;
    margin-top: 30px;
}

@media (max-width: 480px) {
    .button-group {
        grid-template-columns: 1fr;
    }
}

.required {
    color: #e74c3c;
}

.invalid-field {
    border-color: #e74c3c !important;
    box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.15);
}

.form-section {
    border-bottom: 1px solid #e1e4ee;
    padding-bottom: 30px;
    margin-bottom: 30px;
}

.form-section:last-child {
    border-bottom: none;
    margin-bottom: 0;
}

.section-title {
    color: #667eea;
    font-size: 1.3rem;
    font-weight: 700;
    margin-bottom: 20px;
}

.checkbox-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
}

@media (max-width: 480px) {
    .checkbox-grid {
        grid-template-columns: 1fr;
    }
}

#university-name-group {
    transition: all 0.3s ease;
}
#property-images {
    position: absolute;
    opacity: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
    top: 0;
    left: 0;
}
/* الصور المصغرة  */
/* تنسيق شبكة عرض الصور المرفوعة */
.images-preview-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    gap: 15px;
    margin-top: 20px;
}

.preview-image-wrapper {
    position: relative;
    border: 2px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
    height: 120px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* تمييز الصورة الرئيسية الأولى */
.preview-image-wrapper.main-image {
    border-color: #27ae60;
}

.preview-image-wrapper.main-image::after {
    content: "الرئيسية";
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(39, 174, 96, 0.9);
    color: white;
    font-size: 11px;
    text-align: center;
    padding: 2px 0;
}

.preview-image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* زر الحذف الاحترافي (X) */
.remove-image-btn {
    position: absolute;
    top: 5px;
    left: 5px;
    background: rgba(231, 76, 60, 0.9);
    color: white;
    border: none;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    font-size: 12px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
    z-index: 10;
}

.remove-image-btn:hover {
    background: #c0392b;
}