<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ của tôi</title>
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
        }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .header {
            background: white; padding: 20px 30px; border-radius: 10px;
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header a { color: #e74c3c; text-decoration: none; font-weight: 600; padding: 8px 16px; border-radius: 6px; background: #fde8e8; }
        .header a:hover { background: #fcc; }
        
        .profile-card {
            background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .profile-card .avatar-section {
            text-align: center; margin-bottom: 30px;
        }
        .profile-card .avatar-section img {
            width: 150px; height: 150px; border-radius: 50%;
            object-fit: cover; border: 4px solid #3498db;
        }
        .profile-card .avatar-section .upload-hint {
            font-size: 12px; color: #7f8c8d; margin-top: 5px;
        }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #2c3e50; margin-bottom: 6px; }
        .form-group input {
            width: 100%; padding: 12px 16px;
            border: 2px solid #e8e8e8; border-radius: 8px;
            font-size: 15px; outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus { border-color: #3498db; }
        .form-group input[readonly] { background: #f8f9fa; color: #7f8c8d; }
        
        .error-message {
            color: #dc2626;
            font-size: 13px;
            margin-top: 5px;
            padding: 5px 10px;
            background: #fee2e2;
            border-radius: 6px;
            border-left: 4px solid #dc2626;
            display: none;
        }
        
        .form-actions { display: flex; gap: 15px; margin-top: 10px; }
        .btn-submit { background: #2ecc71; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-submit:hover { background: #27ae60; }
        .btn-cancel { background: #95a5a6; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-cancel:hover { background: #7f8c8d; }
        
        .alert { padding: 12px 16px; border-radius: 10px; margin-bottom: 20px; font-size: 14px; }
        .alert-success { background: #dcfce7; color: #16a34a; border: 1px solid #86efac; }
        .alert-danger { background: #fee2e2; color: #dc2626; border: 1px solid #fca5a5; }
        
        .footer { background: white; padding: 15px 30px; border-radius: 10px; text-align: center; margin-top: 30px; color: #7f8c8d; }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h1>👤 Hồ sơ của tôi</h1>
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
        </div>

        <div class="profile-card">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" onsubmit="return validateProfile()">
                <!-- Avatar -->
                <div class="avatar-section">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img src="${pageContext.request.contextPath}/image?fname=${user.avatar}" alt="Avatar" id="avatarPreview">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/150x150?text=No+Avatar" alt="Avatar" id="avatarPreview">
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <input type="file" name="avatar" accept="image/*" onchange="previewImage(event)" style="margin-top: 10px;">
                    <div class="upload-hint">Chọn ảnh đại diện mới (JPG, PNG, GIF)</div>
                </div>

                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <input type="text" value="${user.username}" readonly>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" value="${user.email}" readonly>
                </div>

                <div class="form-group">
                    <label>Họ và tên <span style="color: red;">*</span></label>
                    <input type="text" id="fullname" name="fullname" value="${user.fullname}">
                    <div id="fullnameError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" id="phone" name="phone" value="${user.phone}">
                    <div id="phoneError" class="error-message"></div>
                </div>

                <div class="form-group">
                    <label>Vai trò</label>
                    <input type="text" value="${user.roleid == 1 ? 'Admin' : 'Người dùng'}" readonly>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">💾 Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/home" class="btn-cancel">⬅️ Hủy</a>
                </div>
            </form>
        </div>

        <div class="footer">
            <p>© 2026 JPA Servlet CRUD</p>
        </div>
    </div>

    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('avatarPreview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }

        function validateProfile() {
            var fullname = document.getElementById('fullname').value;
            var phone = document.getElementById('phone').value;
            var isValid = true;

            resetErrors(['fullnameError', 'phoneError']);

            if (isEmpty(fullname)) {
                showError('fullnameError', '⚠️ Vui lòng nhập họ và tên!');
                isValid = false;
            }

            if (!isEmpty(phone) && !isValidPhone(phone)) {
                showError('phoneError', '⚠️ Số điện thoại phải có 10-11 chữ số!');
                isValid = false;
            }

            return isValid;
        }
    </script>

</body>
</html>