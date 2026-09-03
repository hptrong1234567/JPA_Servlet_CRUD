<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
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
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px;
        }
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header-right a { text-decoration: none; font-weight: 600; padding: 8px 16px; border-radius: 6px; }
        .header-right .btn-list { background: #3498db; color: white; }
        .header-right .btn-home { background: #95a5a6; color: white; }
        
        .form-container {
            background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 700px;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #2c3e50; margin-bottom: 6px; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%; padding: 12px 16px;
            border: 2px solid #e8e8e8; border-radius: 8px;
            font-size: 15px; outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: #3498db;
        }
        .form-group textarea { min-height: 100px; resize: vertical; }
        .form-actions { display: flex; gap: 15px; margin-top: 10px; }
        .btn-submit { background: #2ecc71; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-submit:hover { background: #27ae60; }
        .btn-cancel { background: #e74c3c; color: white; border: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-cancel:hover { background: #c0392b; }
        
        .sidebar { width: 260px; background: #2c3e50; color: white; padding: 20px 0; position: fixed; height: 100vh; overflow-y: auto; top: 0; left: 0; }
        .sidebar .logo { text-align: center; padding: 20px; border-bottom: 1px solid #34495e; }
        .sidebar .logo h3 { color: #ecf0f1; margin: 0; }
        .sidebar .nav-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar .nav-menu li { border-bottom: 1px solid #34495e; }
        .sidebar .nav-menu li a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: all 0.3s; }
        .sidebar .nav-menu li a:hover { background: #34495e; color: white; }
        .required { color: red; }
        .preview-img { width: 100px; height: 100px; object-fit: cover; border-radius: 8px; border: 1px solid #e8e8e8; margin-top: 10px; }
    </style>
</head>
<body>

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>✏️ Sửa sản phẩm</h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-list">📋 Danh sách</a>
                <a href="${pageContext.request.contextPath}/admin/home" class="btn-home">🏠 Quay lại</a>
            </div>
        </div>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/product/update" method="post">
                <input type="hidden" name="productId" value="${product.productId}">
                <div class="form-group">
                    <label>Tên sản phẩm <span class="required">*</span></label>
                    <input type="text" name="productName" value="${product.productName}" required>
                </div>
                <div class="form-group">
                    <label>Giá <span class="required">*</span></label>
                    <input type="number" step="1000" name="price" value="${product.price}" required>
                </div>
                <div class="form-group">
                    <label>Số lượng</label>
                    <input type="number" name="quantity" value="${product.quantity}">
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <textarea name="description">${product.description}</textarea>
                </div>
                <div class="form-group">
                    <label>URL hình ảnh</label>
                    <input type="text" name="imageUrl" value="${product.imageUrl}">
                    <c:if test="${not empty product.imageUrl}">
                        <img src="${pageContext.request.contextPath}/image?fname=${product.imageUrl}" 
                             alt="${product.productName}" class="preview-img">
                    </c:if>
                </div>
                <div class="form-group">
                    <label>Danh mục <span class="required">*</span></label>
                    <select name="cateId" required>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.cateId}" ${category.cateId == product.category.cateId ? 'selected' : ''}>
                                ${category.cateName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="1" ${product.status == 1 ? 'selected' : ''}>✅ Hoạt động</option>
                        <option value="0" ${product.status != 1 ? 'selected' : ''}>⛔ Khóa</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-submit">💾 Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn-cancel">⬅️ Hủy</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>