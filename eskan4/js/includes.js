// أضف هذا الكود في بداية ملف includes.js
document.addEventListener('click', function(e) {
    // التحقق إذا كان العنصر المضغوط هو الرابط المطلوب
    const target = e.target.closest('#myPropertiesLink');
    
    if (target) {
        e.preventDefault(); // منع أي تحديث للصفحة
        e.stopPropagation(); // منع انتقال الحدث لأي مكان آخر
        
        const user = JSON.parse(localStorage.getItem('user') || 'null');
        const token = localStorage.getItem('authToken');

        // إذا لم يكن مسجلاً
        if (!token || !user) {
            if (typeof openLoginPopup === 'function') openLoginPopup();
            else window.location.href = 'login-popup.html';
            return;
        }

        // التوجيه الذكي
        if (user.role === 'admin') {
            window.location.href = 'admin.html';
        } else if (user.role === 'owner') {
            window.location.href = 'pending-approval.html';
        } else {
            // للمستأجر
            window.location.href = 'tenant-dashboard.html';
        }
    }
});

(function() {
    function appendHeadAssets(doc) {
        doc.head.querySelectorAll('link[rel="stylesheet"], style').forEach(node => {
            if (node.tagName.toLowerCase() === 'link' && node.href) {
                const exists = Array.from(document.head.querySelectorAll('link[rel="stylesheet"]')).some(l => l.href === node.href);
                if (!exists) document.head.appendChild(node.cloneNode(true));
            } else {
                document.head.appendChild(node.cloneNode(true));
            }
        });
    }

    function appendDocumentScripts(doc) {
        doc.querySelectorAll('script').forEach(s => {
            const newS = document.createElement('script');
            if (s.src) {
                newS.src = s.src;
                newS.async = false;
                document.body.appendChild(newS);
            } else if (s.textContent && s.textContent.trim()) {
                newS.text = s.textContent;
                document.body.appendChild(newS);
            }
        });
    }

    function initNavImmediate(container) {
        const hamburger = container.querySelector('#hamburger');
        const navMenu = container.querySelector('#navMenu');
        if (!hamburger || !navMenu) return;

        hamburger.addEventListener('click', (e) => {
            e.stopPropagation();
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
        });

        container.querySelectorAll('.nav-menu a').forEach(link => {
            link.addEventListener('click', () => {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });

        document.addEventListener('click', (e) => {
            if (!navMenu.contains(e.target) && !hamburger.contains(e.target)) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            }
        });

        if (typeof setActiveNavItem === 'function') setActiveNavItem();
        if (typeof checkAuthStatus === 'function') checkAuthStatus();
        // If the loaded nav defines an initializer, call it to bind additional handlers
        if (typeof initializeNav === 'function') initializeNav();
    }

    function loadNav() {
        fetch('nav.html')
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                appendHeadAssets(doc);
                appendDocumentScripts(doc);

                const container = document.getElementById('navbar-container');
                const navEl = doc.body.firstElementChild;
                if (container && navEl) {
                    container.appendChild(navEl.cloneNode(true));
                    initNavImmediate(container);

                    container.querySelectorAll('a').forEach(a => {
                        const href = a.getAttribute('href') || '';
                        const text = (a.textContent || '').trim();
                        if (href.includes('properties.html') || text.includes('العقارات')) {
                            a.addEventListener('click', function(e) {
                                e.preventDefault();
                                window.location.href = 'properties.html';
                            });
                        }
                    });
                }
            })
            .catch(err => console.error('خطأ في تحميل النافبار:', err));
    }

    function loadFooter() {
        fetch('footer.html')
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                appendHeadAssets(doc);

                const footerEl = doc.querySelector('footer') || doc.body.firstElementChild;
                if (footerEl) {
                    const container = document.getElementById('footer-container');
                    if (container) container.appendChild(footerEl.cloneNode(true));
                }

                appendDocumentScripts(doc);
            })
            .catch(err => console.error('خطأ في تحميل الفوتر:', err));
    }

    function loadLoginPopup() {
        fetch('login-popup.html')
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                appendHeadAssets(doc);

                const popupEl = doc.querySelector('.login-popup-overlay') || doc.body.firstElementChild;
                if (popupEl) {
                    const container = document.getElementById('popup-container');
                    if (container) container.appendChild(popupEl.cloneNode(true));
                }

                appendDocumentScripts(doc);
            })
            .catch(err => console.error('خطأ في تحميل البوب اب:', err));
    }

    function loadSharedUI() {
        loadNav();
        loadFooter();
        loadLoginPopup();
    }

    window.loadSharedUI = loadSharedUI;

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', loadSharedUI);
    } else {
        loadSharedUI();
    }
})();
