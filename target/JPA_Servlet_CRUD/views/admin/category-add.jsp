<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục</title>
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            display: flex;
            min-height: 100vh;
        }
        .main-content { margin-left: 260px; flex: 1; padding: 20px; }
        .header {
            background: white; padding: 20px 30px; border-radius: 10px;
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header-right a { text-decoration: none; font-weight: 600; padding: 8px 16px; border-radius: 6px; }
        .header-right .btn-list { background: #3498db; color: white; }
        .header-right .btn-home { background: #95a5a6; color: white; }
        
        .form-container {
            background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 600px;
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
        .btn-reset { background: #95a5a6; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-reset:hover { background: #7f8c8d; }
        .btn-cancel { background: #e74c3c; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-cancel:hover { background: #c0392b; }
        
        .sidebar {
            width: 260px; background: #2c3e50; color: white; padding: 20px 0;
            position: fixed; height: 100vh; overflow-y: auto; top: 0; left: 0;
        }
        .sidebar .logo { text-align: center; padding: 20px; border-bottom: 1px solid #34495e; }
        .sidebar .logo h3 { color: #ecf0f1; margin: 0; }
        .sidebar .nav-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar .nav-menu li { border-bottom: 1px solid #34495e; }
        .sidebar .nav-menu li a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: all 0.3s; }
        .sidebar .nav-menu li a:hover { background: #34495e; color: white; }
        .required { color: red; }
    </style>
</head>
<body>

    <jsp:include page="/views/admin/layout/sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>➕ Thêm danh mục mới</h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn-list">📋 Danh sách</a>
                <a href="${pageContext.request.contextPath}/admin/home" class="btn-home">🏠 Quay lại</a>
            </div>
        </div>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/category/insert" method="post" onsubmit="return validateCategory()">
                <div class="form-group">
                    <label>Tên danh mục <span class="required">*</span></label>
                    <input type="text" id="name" name="name" placeholder="Nhập tên danh mục...">
                    <div id="nameError" class="error-message"></div>
                </div>
                <div class="form-group">
                    <label>Icon (URL ảnh)</label>
                    <input type="text" id="icon" name="icon" placeholder="Nhập URL ảnh...">
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-submit">💾 Lưu</button>
                    <button type="reset" class="btn-reset">🔄 Nhập lại</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn-cancel">⬅️ Hủy</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateCategory() {
            var name = document.getElementById('name').value;
            var isValid = true;

            document.getElementById('nameError').style.display = 'none';

            if (isEmpty(name)) {
                showError('nameError', '⚠️ Vui lòng nhập tên danh mục!');
                isValid = false;
            }

            return isValid;
        }
    </script>

</body>
</html>