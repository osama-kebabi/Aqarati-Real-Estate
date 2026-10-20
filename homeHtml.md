<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>الرئيسية - موقع العقارات</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style/site.css">
    <link rel="stylesheet" href="style/home-page.css">
    <link rel="stylesheet" href="style/nav.css">
</head>
<body>

    <!-- ========== حاوية النافبار ========== -->
    <div class="hero-wrapper">
        <div id="navbar-container"></div>

        <div class="slider-container">
            <div class="slider">
                <div class="slide active">
                    <img src="https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=1200" alt="عقار فاخر">
                    <div class="slide-overlay">
                        <h1>عقارات فاخرة بأفضل الأسعار</h1>
                        <p>اكتشف منزل أحلامك معنا</p>
                    </div>
                </div>
                <div class="slide">
                    <img src="https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1200" alt="فيلا عصرية">
                    <div class="slide-overlay">
                        <h1>فلل عصرية بتصاميم راقية</h1>
                        <p>الرفاهية والأناقة في مكان واحد</p>
                    </div>
                </div>
                <div class="slide">
                    <img src="https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200" alt="شقق فندقية">
                    <div class="slide-overlay">
                        <h1>شقق فندقية مميزة</h1>
                        <p>استثمر في المستقبل اليوم</p>
                    </div>
                </div>
                <div class="slide">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200" alt="منازل عائلية">
                    <div class="slide-overlay">
                        <h1>منازل عائلية واسعة</h1>
                        <p>المكان المثالي لعائلتك</p>
                    </div>
                </div>
            </div>
            <div class="action-buttons">
                <button class="action-btn book-btn" onclick="bookProperty()"><i class="fas fa-search"></i><span>تصفح العقارات</span></button>
                <button class="action-btn" onclick="addProperty()"><i class="fas fa-plus-circle"></i><span>إضافة عقار</span></button>
            </div>

            <div class="slider-nav">
                <button class="slider-btn prev-btn" onclick="changeSlide(1)"><i class="fas fa-chevron-left"></i></button>
                <button class="slider-btn next-btn" onclick="changeSlide(-1)"><i class="fas fa-chevron-right"></i></button>
            </div>

            <div class="slider-dots">
                <span class="dot active" onclick="currentSlide(0)"></span>
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
            </div>
        </div>

        <div class="scroll-down-indicator" onclick="scrollToServices()">
            <i class="fas fa-chevron-down"></i>
        </div>
    </div>

    <!-- ========== قسم الخدمات ========== -->
    <section class="services-section" id="services">
        <div class="services-title">
            <h2>آلية عملنا</h2>
        </div>

        <div class="services-container">
            <div class="service-card">
                <div class="card-number">1</div>
                <div class="card-icon"><i class="fas fa-home"></i></div>
                <h3 class="card-title">إضافة العقار</h3>
                <p class="card-description">يضاف العقار من قبل صاحب العقار مع كافة التفاصيل والمواصفات والصور ليكون متاحاً للعملاء.</p>
                <div class="card-link">أضف عقارك <i class="fas fa-arrow-left"></i></div>
            </div>

            <div class="arrow-between"><i class="fas fa-arrow-left"></i></div>

            <div class="service-card">
                <div class="card-number">2</div>
                <div class="card-icon"><i class="fas fa-clipboard-check"></i></div>
                <h3 class="card-title">مراجعة الطلب</h3>
                <p class="card-description">نقوم بمراجعة الطلب والتأكد من صحة المعلومات وجودة العقار لضمان أفضل تجربة للعملاء.</p>
                <div class="card-link">تعرف على المعايير <i class="fas fa-arrow-left"></i></div>
            </div>

            <div class="arrow-between"><i class="fas fa-arrow-left"></i></div>

            <div class="service-card">
                <div class="card-number">3</div>
                <div class="card-icon"><i class="fas fa-hand-holding-heart"></i></div>
                <h3 class="card-title">حجز الخدمة</h3>
                <p class="card-description">تحجز الخدمة المناسبة لك بكل سهولة ونضمن راحتك معنا طوال فترة التعاقد وبعدها.</p>
                <div class="card-link">احجز الآن <i class="fas fa-arrow-left"></i></div>
            </div>
        </div>
    </section>
 

    <!-- ========== حاوية الفوتر ========== -->
    <div id="footer-container"></div>

    <!-- ========== حاوية البوب اب ========== -->
    <div id="popup-container"></div>

    <!-- ========== زر العودة للأعلى ========== -->
    <button id="scrollToTop" title="العودة للأعلى">
        <i class="fas fa-arrow-up"></i>
    </button>

    <script>
        // ========== السلايدر ==========
        let currentSlideIndex = 0;
        const slides = document.querySelectorAll('.slide');
        const dots = document.querySelectorAll('.dot');
        let autoSlideInterval;

        function showSlide(index) {
            slides.forEach((slide, i) => { 
                slide.classList.remove('active'); 
                dots[i].classList.remove('active'); 
            });
            
            if (index >= slides.length) currentSlideIndex = 0;
            else if (index < 0) currentSlideIndex = slides.length - 1;
            else currentSlideIndex = index;
            
            slides[currentSlideIndex].classList.add('active');
            dots[currentSlideIndex].classList.add('active');
        }

        window.changeSlide = function(direction) { 
            showSlide(currentSlideIndex + direction); 
            resetAutoSlide(); 
        };
        
        window.currentSlide = function(index) { 
            showSlide(index); 
            resetAutoSlide(); 
        };
        
        function startAutoSlide() { 
            autoSlideInterval = setInterval(() => showSlide(currentSlideIndex + 1), 2500);
        }
        
        function resetAutoSlide() { 
            clearInterval(autoSlideInterval); 
            startAutoSlide(); 
        }
        
        startAutoSlide();
        
        window.bookProperty = function() { window.location.href = 'properties.html'; };
        // window.addProperty = function() {
        //     const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
        //     if (isLoggedIn) {
        //         window.location.href = 'add-properties.html';
        //         return;
        //     }

        //     localStorage.setItem('afterLoginRedirect', 'add-properties.html');
        //     if (window.openLoginPopup) {
        //         openLoginPopup();
        //     } else {
        //         window.location.href = 'login-popup.html';
        //     }
        // };
        // ✅ الجديد
window.addProperty = function() {
    const token = localStorage.getItem('authToken');
    const user  = JSON.parse(localStorage.getItem('user') || 'null');

    if (token && user) {
        if (user.role === 'owner') {
            // ✅ المالك يروح لصفحة الإضافة مباشرة
            window.location.href = 'add-properties.html';
        } else if (user.role === 'admin') {
            window.location.href = 'admin.html';
        } else {
            // tenant → صفحة الإضافة وبعدها بيتحول owner
            window.location.href = 'add-properties.html';
        }
        return;
    }

    // غير مسجل → popup
    localStorage.setItem('afterLoginRedirect', 'add-properties.html');
    if (window.openLoginPopup) openLoginPopup();
    else window.location.href = 'login-popup.html';
};
        
        window.scrollToServices = function() {
            document.getElementById('services').scrollIntoView({ behavior: 'smooth' });
        };

        // ========== زر العودة للأعلى ==========
        const scrollBtn = document.getElementById('scrollToTop');
        
        window.addEventListener('scroll', function() {
            if (window.scrollY > 300) {
                scrollBtn.classList.add('show');
            } else {
                scrollBtn.classList.remove('show');
            }
        });
        
        scrollBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // تحديث حالة المصادقة عند تحميل الصفحة
        if (window.updateAuthStatus) {
            updateAuthStatus();
        }
    </script>
     <script src="js/auth-manager.js"></script>
      <script src="js/login-popup-fixed.js"></script>
    <script src="js/includes.js"></script>
    <!-- <script src="js/auth-gard.js"></script> -->
</body>
</html>