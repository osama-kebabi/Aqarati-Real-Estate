# دليل ربط API الفرونت مع الباك إند

## ✅ ما تم إنجازه

تم إنشاء ملف JavaScript منفصل `js/api-integration.js` يربط الفرونت الحالي مع API الباك إند **بدون تعديل أكواد الفرونت الأصلية**.

---

## 📁 الملفات المضافة/المعدلة

### 1. **`eskan4/js/api-integration.js`** (ملف جديد)
- يحتوي على module `PropertyAPI` كامل
- يحول أسماء الحقول تلقائياً من صيغة الفرونت إلى صيغة API
- يدير المصادقة والتوكن
- يتعامل مع الصور والبيانات

### 2. **`eskan4/add-properties.html`** (تعديل بسيط)
- إضافة `<script src="js/api-integration.js"></script>` قبل `</body>`

### 3. **`eskan4/pending-approval.html`** (تعديل بسيط)
- إضافة `<script src="js/api-integration.js"></script>` قبل `</body>`

---

## 🔄 تحويل الحقول (تلقائي)

الـ JavaScript يقوم بتحويل الحقول تلقائياً:

| حقل الفرونت | حقل API | ملاحظة |
|-----------|--------|-------|
| `title` | `title` | بدون تغيير |
| `type` | `property_type` | تحويل تلقائي |
| `district` | `region` | تحويل تلقائي |
| `bedrooms` | `rooms_count` | تحويل تلقائي |
| `bathrooms` | `bathrooms_count` | بدون تغيير |
| `price` | `price` | تحويل إلى number |
| `university_name` | `university_id` | يتم معالجته من قائمة الجامعات |

---

## 🔐 المصادقة والتوكن

### كيف يعمل النظام:

1. **بعد تسجيل الدخول:** يجب أن يحفظ `AuthController` التوكن في `localStorage`:
   ```javascript
   localStorage.setItem('authToken', token);
   // أو
   sessionStorage.setItem('authToken', token);
   ```

2. **عند إضافة عقار:** يقرأ الـ JavaScript التوكن تلقائياً ويرسله مع الطلب:
   ```
   Headers: {
       'Authorization': 'Bearer YOUR_TOKEN_HERE',
       'Accept': 'application/json'
   }
   ```

3. **التحقق من التوكن:** إذا لم يكن موجوداً، يتم توجيه المستخدم لصفحة تسجيل الدخول.

---

## 🚀 كيفية الاستخدام

### من ملفات HTML:

```html
<!-- لا حاجة لأي تعديل على النموذج -->
<!-- الـ JavaScript يعمل تلقائياً عند الإرسال -->
<form id="property-form">
    <!-- جميع الحقول الموجودة تعمل كما هي -->
</form>

<!-- يجب إضافة السكريبت -->
<script src="js/api-integration.js"></script>
```

### من ملفات JavaScript أخرى:

```javascript
// الحصول على العقارات
const properties = await PropertyAPI.getProperties();

// إضافة عقار
const formElement = document.getElementById('property-form');
const result = await PropertyAPI.addProperty(formElement);

// التحقق من التوكن
if (PropertyAPI.isLoggedIn()) {
    console.log('المستخدم مسجل دخول');
}

// الحصول على الجامعات
const universities = await PropertyAPI.getUniversities();
```

---

## ⚙️ الإعدادات

إذا كان موقع الباك إند مختلفاً، عدّل في `js/api-integration.js`:

```javascript
config: {
    baseUrl: 'http://localhost:8000/api', // غيّر هنا
    endpoints: { ... }
}
```

---

## 📋 سير العملية عند إضافة عقار

1. **المستخدم يملأ النموذج** في `add-properties.html`
2. **يضغط على "إضافة العقار"**
3. **الـ JavaScript يقوم بـ:**
   - التحقق من تسجيل الدخول
   - تحويل الحقول من صيغة الفرونت إلى صيغة API
   - إرسال البيانات والصور إلى `POST /api/owner/properties`
   - معالجة الاستجابة
4. **إذا نجح:**
   - عرض رسالة نجاح
   - توجيه إلى `pending-approval.html`
5. **إذا فشل:**
   - عرض رسالة خطأ
   - البقاء في نفس الصفحة

---

## 🧪 الاختبار

### 1. تأكد من تشغيل الباك إند:
```bash
cd BackEnd
php artisan serve
```

### 2. تأكد من وجود `authToken` بعد تسجيل الدخول:
```javascript
// في console المتصفح
console.log(localStorage.getItem('authToken'));
```

### 3. افتح `add-properties.html` وحاول إضافة عقار

### 4. تحقق من الـ Network tab في DevTools:
- يجب أن ترى طلب `POST /api/owner/properties`
- الحالة يجب أن تكون `201` أو `200`

---

## ⚠️ المشاكل الشائعة والحلول

### المشكلة: "يجب تسجيل الدخول أولاً"
**السبب:** التوكن غير موجود في `localStorage`
**الحل:** تأكد من أن `AuthController` يحفظ التوكن في `localStorage` بعد تسجيل الدخول

### المشكلة: "خطأ في الخادم (422)"
**السبب:** بيانات غير صحيحة
**الحل:** تحقق من validation errors في استجابة API

### المشكلة: "Cross-Origin Request Blocked"
**السبب:** CORS غير مفعل في الباك
**الحل:** تأكد من إضافة CORS middleware في Laravel

---

## 🔧 دالات PropertyAPI المتاحة

### `PropertyAPI.isLoggedIn()`
- **الوصف:** التحقق من تسجيل الدخول
- **الإرجاع:** `true` أو `false`

### `PropertyAPI.getToken()`
- **الوصف:** الحصول على التوكن
- **الإرجاع:** التوكن أو `null`

### `PropertyAPI.addProperty(formElement)`
- **الوصف:** إضافة عقار جديد
- **المعاملات:** عنصر النموذج
- **الإرجاع:** بيانات العقار المضافة

### `PropertyAPI.getProperties()`
- **الوصف:** الحصول على قائمة العقارات
- **الإرجاع:** مصفوفة العقارات

### `PropertyAPI.getUniversities()`
- **الوصف:** الحصول على قائمة الجامعات
- **الإرجاع:** مصفوفة الجامعات

### `PropertyAPI.updateProperty(propertyId, formElement)`
- **الوصف:** تحديث عقار
- **المعاملات:** ID العقار وعنصر النموذج
- **الإرجاع:** بيانات العقار المحدثة

### `PropertyAPI.deleteProperty(propertyId)`
- **الوصف:** حذف عقار
- **المعاملات:** ID العقار
- **الإرجاع:** `true` إذا نجح

---

## 📝 ملاحظات مهمة

1. **لا تحتاج لتعديل أكواد الفرونت الأصلية** - كل شيء يعمل من ملف `api-integration.js`

2. **التوكن يجب أن يُحفظ من `AuthController`:**
   ```php
   // في BackEnd/app/Http/Controllers/Api/AuthController.php
   $token = $user->createToken('authToken')->plainTextToken;
   // في استجابة login
   return response()->json([
       'token' => $token,
       'user' => $user
   ]);
   ```

3. **في الفرونت (في صفحة login):**
   ```javascript
   // بعد استقبال التوكن من API
   localStorage.setItem('authToken', response.token);
   ```

4. **الصور يتم إرسالها كـ multipart/form-data تلقائياً**

---

## 🎉 الخلاصة

✅ الفرونت الحالي يعمل **بدون أي تعديل** على الأكواس الأصلية
✅ إضافة عقار يتم **مباشرة إلى API**
✅ تحويل الحقول يتم **تلقائياً**
✅ المصادقة **آمنة وسهلة**

**استمتع! 🚀**
