/**
 * AuthManager - إدارة المصادقة والتواصل مع API
 * يتعامل مع:
 * - التسجيل والدخول
 * - حفظ التوكن في localStorage
 * - إرسال الطلبات المصرح بها (مع التوكن)
 */

const API_BASE_URL = 'http://localhost:8000/api';

const AuthManager = {
    /**
     * تسجيل مستخدم جديد
     * @param {Object} userData - {name, email, password, phone, role}
     */
    register: async (userData) => {
        try {
            const response = await fetch(`${API_BASE_URL}/auth/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(userData)
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.message || `خطأ: ${response.status}`);
            }

            const data = await response.json();
            
            // حفظ البيانات في localStorage
            localStorage.setItem('authToken', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            localStorage.setItem('userData', JSON.stringify(data.user));
            localStorage.setItem('userEmail', data.user.email || '');
            localStorage.setItem('userType', data.user.role || '');
            localStorage.setItem('isLoggedIn', 'true');
            
            return data;
        } catch (error) {
            console.error('خطأ في التسجيل:', error);
            throw error;
        }
    },

    /**
     * تسجيل الدخول
     * @param {string} email - البريد الإلكتروني
     * @param {string} password - كلمة المرور
     */
    login: async (email, password) => {
        try {
            const response = await fetch(`${API_BASE_URL}/auth/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({ email, password })
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.message || `خطأ في المصادقة: ${response.status}`);
            }

            const data = await response.json();
            
            // حفظ البيانات في localStorage
            localStorage.setItem('authToken', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            localStorage.setItem('userData', JSON.stringify(data.user));
            localStorage.setItem('userEmail', data.user.email || '');
            localStorage.setItem('userType', data.user.role || '');
            localStorage.setItem('isLoggedIn', 'true');
            
console.log('✅ تسجيل دخول ناجح:', data.user.name);
    
            return data;
        } catch (error) {
            console.error('خطأ في الدخول:', error);
            throw error;
        }
        // بعد حفظ بيانات المستخدم في login
        
            },
    

    /**
     * تسجيل الخروج
     */
    logout: () => {
        localStorage.removeItem('authToken');
        localStorage.removeItem('user');
        localStorage.removeItem('userData');
        localStorage.removeItem('userEmail');
        localStorage.removeItem('userType');
        localStorage.removeItem('isLoggedIn');
        console.log('✅ تم تسجيل الخروج');
    },

    /**
     * الحصول على التوكن المحفوظ
     */
    getToken: () => {
        return localStorage.getItem('authToken');
    },

    /**
     * الحصول على بيانات المستخدم المحفوظة
     */
    getUser: () => {
        const user = localStorage.getItem('user');
        return user ? JSON.parse(user) : null;
    },

    /**
     * التحقق من تسجيل الدخول
     */
    isLoggedIn: () => {
        return !!localStorage.getItem('authToken');
    },

    /**
     * طلب معرّف بالتوكن (للعمليات المصرح بها)
     * @param {string} endpoint - المسار (مثل: /owner/properties)
     * @param {Object} options - خيارات إضافية (method, body, etc)
     */
    authenticatedFetch: async (endpoint, options = {}) => {
        const token = AuthManager.getToken();
        
        if (!token) {
            throw new Error('لم يتم تسجيل الدخول. يرجى تسجيل الدخول أولاً.');
        }

        const headers = {
            'Authorization': `Bearer ${token}`,
            'Accept': 'application/json',
            ...options.headers
        };

        // إذا كانت هناك بيانات، أضف Content-Type
        if (options.body && typeof options.body === 'object' && !(options.body instanceof FormData)) {
            headers['Content-Type'] = 'application/json';
            options.body = JSON.stringify(options.body);
        }

        const response = await fetch(`${API_BASE_URL}${endpoint}`, {
            method: 'GET',
            ...options,
            headers
        });

        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.message || `خطأ: ${response.status}`);
        }

        return response.json();
    },

    /**
     * إضافة عقار جديد
     * @param {Object} propertyData - بيانات العقار
     * @param {File[]} images - الصور
     */
    createProperty: async (propertyData, images = []) => {
        const token = AuthManager.getToken();
        
        if (!token) {
            throw new Error('لم يتم تسجيل الدخول. يرجى تسجيل الدخول أولاً.');
        }

        const formData = new FormData();
        
       
        // ✅ الإصلاح - يتجاهل الـ null
Object.keys(propertyData).forEach(key => {
    const val = propertyData[key];
    if (val !== null && val !== undefined) {
        // Boolean لازم يصير 1 أو 0 مش "true"/"false"
        formData.append(key, typeof val === 'boolean' ? (val ? '1' : '0') : val);
    }
});

        // إضافة الصور
        images.forEach((image) => {
            formData.append('images[]', image);
        });

        try {
            const response = await fetch(`${API_BASE_URL}/owner/properties`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                },
                body: formData
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.message || `خطأ: ${response.status}`);
            }

            const data = await response.json();
            console.log('✅ تم إنشاء العقار بنجاح:', data);
            return data;
        } catch (error) {
            console.error('خطأ في إنشاء العقار:', error);
            throw error;
        }
    }
};

// تصدير للاستخدام العام
if (typeof window !== 'undefined') {
    window.AuthManager = AuthManager;
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = AuthManager;
}
// }
