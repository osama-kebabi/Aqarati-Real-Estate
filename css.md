/* ========== property-card.css - تنسيقات معاينة بطاقة العقار ========== */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.property-card {
    background: white;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    max-width: 600px;
    width: 100%;
    min-height: calc(100vh - 80px);
    display: flex;
    flex-direction: column;
    transition: transform 0.3s ease;
}

.property-card:hover {
    transform: translateY(-5px);
}

.property-image {
    position: relative;
    width: 100%;
    height: 320px;
    background: #f0f0f0;
    overflow: hidden;
}

.property-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.property-status {
    position: absolute;
    top: 20px;
    right: 20px;
    background: #27ae60;
    color: white;
    padding: 8px 20px;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: bold;
    box-shadow: 0 4px 10px rgba(39, 174, 96, 0.3);
}

.property-type-badge {
    position: absolute;
    top: 20px;
    left: 20px;
    background: rgba(255, 255, 255, 0.95);
    color: #667eea;
    padding: 8px 20px;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: bold;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.image-counter {
    position: absolute;
    bottom: 20px;
    left: 20px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.85rem;
}

.image-nav {
    position: absolute;
    bottom: 20px;
    right: 20px;
    display: flex;
    gap: 10px;
}

.image-nav button {
    background: rgba(255, 255, 255, 0.9);
    border: none;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.image-nav button:hover {
    background: white;
    transform: scale(1.1);
}

.property-content {
    padding: 25px;
    display: flex;
    flex-direction: column;
    flex: 1;
}
.property-price {
    font-size: 2rem;
    font-weight: bold;
    color: #667eea;
    margin-bottom: 5px;
}

.property-price span {
    font-size: 1rem;
    color: #999;
    font-weight: normal;
}

.property-title {
    font-size: 1.4rem;
    color: #333;
    margin-bottom: 15px;
    font-weight: 700;
}

.property-location {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #666;
    margin-bottom: 20px;
    font-size: 0.95rem;
}

.property-location i {
    color: #e74c3c;
    font-size: 1.1rem;
}

.property-features {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-bottom: 25px;
    padding: 20px;
    background: #f8f9ff;
    border-radius: 15px;
}

.feature-item {
    display: flex;
    align-items: center;
    gap: 10px;
}

.feature-item i {
    width: 35px;
    height: 35px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
}

.feature-item span {
    color: #555;
    font-size: 0.9rem;
}

.university-badge {
    background: linear-gradient(135deg, #f093fb, #f5576c);
    color: white;
    padding: 10px 15px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
    font-weight: 600;
}

.university-badge i {
    font-size: 1.2rem;
}

.property-description {
    color: #666;
    line-height: 1.8;
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}

.amenities-section {
    margin-bottom: 25px;
}

.amenities-section h4 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

.amenities-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.amenity-tag {
    background: #f0f2ff;
    color: #667eea;
    padding: 8px 15px;
    border-radius: 25px;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    gap: 8px;
}

.amenity-tag i {
    color: #27ae60;
}

.contact-section {
    background: #f8f9ff;
    padding: 20px;
    border-radius: 15px;
    margin-bottom: 10px;
}

.contact-section h4 {
    color: #333;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

.contact-info {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #555;
}

.contact-item i {
    width: 35px;
    height: 35px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.action-buttons {
    /* display: grid;
    grid-template-columns: 1fr 1fr; */
    display: contents;
    gap: 15px;
    margin-top: auto;
    padding-top: 10px;
    border-top: 1px solid #eee;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    border: none;
    padding: 15px;
    border-radius: 12px;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 600;
    transition: transform 0.2s ease;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-primary:hover {
    transform: translateY(-2px);
}

.btn-secondary {
    background: white;
    color: #667eea;
    border: 2px solid #667eea;
    padding: 15px;
    border-radius: 12px;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-secondary:hover {
    background: #f0f2ff;
}

.btn-secondary:hover {
    background: #f0f2ff;
}

@media (max-width: 768px) {
    .property-card {
        max-width: 100%;
        min-height: auto;
        margin: 0 10px;
    }
    .property-image {
        height: 260px;
    }
    .property-features {
        grid-template-columns: 1fr;
    }
    .action-buttons {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 480px) {
    .property-content {
        padding: 20px;
    }
    .property-price {
        font-size: 1.7rem;
    }
    .property-title {
        font-size: 1.25rem;
    }
    .action-buttons {
        gap: 10px;
    }
}

.loading {
    text-align: center;
    padding: 40px;
    color: white;
    font-size: 1.2rem;
}

.no-images {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    color: #999;
    flex-direction: column;
}

.no-images i {
    font-size: 4rem;
    margin-bottom: 15px;
    color: #ccc;
}

.back-button {
    position: fixed;
    top: 20px;
    right: 20px;
    background: white;
    border: none;
    padding: 12px 25px;
    border-radius: 25px;
    cursor: pointer;
    font-size: 1rem;
    font-weight: 600;
    color: #667eea;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    gap: 8px;
    z-index: 1000;
    transition: all 0.3s ease;
}

.back-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}
