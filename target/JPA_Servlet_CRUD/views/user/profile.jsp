<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ của tôi</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
        }
        .profile-card {
            background: white; 
            padding: 30px; 
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 700px;
            margin: 0 auto;
        }
        .profile-card .avatar-section {
            text-align: center; 
            margin-bottom: 30px;
        }
        .profile-card .avatar-section img {
            width: 150px; 
            height: 150px; 
            border-radius: 50%;
            object-fit: cover; 
            border: 4px solid #3498db;
        }
        .profile-card .avatar-section .upload-hint {
            font-size: 12px; 
            color: #7f8c8d; 
            margin-top: 5px;
        }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #2c3e50; margin-bottom: 6px; }
        .form-group input {
            width: 100%; 
            padding: 12px 16px;
            border: 2px solid #e8e8e8; 
            border-radius: 8px;
            font-size: 15px; 
            outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus { border-color: #3498db; }
        .form-group input[readonly] { background: #f8f9fa; color: #7f8c8d; }
        
        .form-actions { display: flex; gap: 15px; margin-top: 10px; flex-wrap: wrap; }
        .btn-submit { background: #2ecc71; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-submit:hover { background: #27ae60; }
        .btn-cancel { background: #95a5a6; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-cancel:hover { background: #7f8c8d; }
        
        .alert { padding: 12px 16px; border-radius: 10px; margin-bottom: 20px; font-size: 14px; }
        .alert-success { background: #dcfce7; color: #16a34a; border: 1px solid #86efac; }
        .alert-danger { background: #fee2e2; color: #dc2626; border: 1px solid #fca5a5; }
        
        .page-title { 
            font-size: 28px; 
            color: #2c3e50; 
            text-align: center; 
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

    <h1 class="page-title">👤 Hồ sơ của tôi</h1>

    <div class="profile-card">
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
            <!-- Avatar -->
            <div class="avatar-section">
                <c:choose>
                    <c:when test="${not empty user.avatar}">
                        <img src="${pageContext.request.contextPath}/image?fname=${user.avatar}" 
                             alt="Avatar" id="avatarPreview">
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/150x150?text=No+Avatar" 
                             alt="Avatar" id="avatarPreview">
                    </c:otherwise>
                </c:choose>
                <br>
                <input type="file" name="avatar" accept="image/*" 
                       onchange="previewImage(event)" style="margin-top: 10px;">
                <div class="upload-hint">Chọn ảnh đại diện mới (JPG, PNG, GIF)</div>
            </div>

            <!-- Username (readonly) -->
            <div class="form-group">
                <label>Tên đăng nhập</label>
                <input type="text" value="${user.username}" readonly>
            </div>

            <!-- Email (readonly) -->
            <div class="form-group">
                <label>Email</label>
                <input type="email" value="${user.email}" readonly>
            </div>

            <!-- Fullname -->
            <div class="form-group">
                <label>Họ và tên <span style="color: red;">*</span></label>
                <input type="text" name="fullname" value="${user.fullname}" required>
            </div>

            <!-- Phone -->
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="text" name="phone" value="${user.phone}">
            </div>

            <!-- Role (readonly) -->
            <div class="form-group">
                <label>Vai trò</label>
                <input type="text" value="${user.roleid == 1 ? 'Admin' : 'Người dùng'}" readonly>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="submit" class="btn-submit">💾 Cập nhật</button>
                <a href="${pageContext.request.contextPath}/home" class="btn-cancel">⬅️ Hủy</a>
            </div>
        </form>
    </div>

    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('avatarPreview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>

</body>
</html>