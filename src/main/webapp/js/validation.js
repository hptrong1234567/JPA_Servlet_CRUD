/**
 * validation.js - Validation chung cho toàn bộ project
 * Các hàm kiểm tra dữ liệu cho các form: Login, Register, Profile, Category, Product...
 */

// ===== HÀM KIỂM TRA RỖNG =====
function isEmpty(value) {
    return value === null || value.trim() === '';
}

// ===== HÀM KIỂM TRA ĐỘ DÀI TỐI THIỂU =====
function minLength(value, min) {
    return value.length >= min;
}

// ===== HÀM KIỂM TRA EMAIL =====
function isValidEmail(email) {
    var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(email);
}

// ===== HÀM KIỂM TRA SỐ ĐIỆN THOẠI =====
function isValidPhone(phone) {
    var regex = /^[0-9]{10,11}$/;
    return regex.test(phone);
}

// ===== HÀM KIỂM TRA GIÁ TRỊ SỐ > 0 =====
function isPositiveNumber(value) {
    return !isNaN(value) && parseFloat(value) > 0;
}

// ===== HIỂN THỊ LỖI =====
function showError(elementId, message) {
    var errorElement = document.getElementById(elementId);
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
}

// ===== ẨN LỖI =====
function hideError(elementId) {
    var errorElement = document.getElementById(elementId);
    if (errorElement) {
        errorElement.textContent = '';
        errorElement.style.display = 'none';
    }
}

// ===== RESET TẤT CẢ LỖI =====
function resetErrors(errorIds) {
    for (var i = 0; i < errorIds.length; i++) {
        hideError(errorIds[i]);
    }
}