<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa danh mục</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            display: flex;
            min-height: 100vh;
        }
        .main-content { margin-left: 260px; flex: 1; padding: 20px; }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            border: none;
            cursor: pointer;
        }
        .btn-success { background: #2ecc71; color: white; }
        .btn-success:hover { background: #27ae60; }
        .btn-secondary { background: #95a5a6; color: white; }
        .btn-secondary:hover { background: #7f8c8d; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 600px;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; color: #2c3e50; margin-bottom: 6px; }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e8e8e8;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }
        .form-group input:focus { border-color: #3498db; }
        .form-actions { display: flex; gap: 15px; margin-top: 10px; }
        .radio-group { display: flex; gap: 20px; margin-top: 5px; }
        .radio-group label { font-weight: normal; cursor: pointer; }
        .header {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .header h1 { color: #2c3e50; font-size: 24px; margin: 0; }
        .header-right { display: flex; align-items: center; gap: 15px; }
        .header-right a { text-decoration: none; font-weight: 600; padding: 8px 16px; border-radius: 6px; color: #e74c3c; background: #fde8e8; }
        .header-right a:hover { background: #fcc; }
        .preview-image { margin-top: 10px; }
        .preview-image img { width: 100px; height: 100px; object-fit: cover; border-radius: 6px; border: 1px solid #e8e8e8; }
    </style>
</head>
<body>

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>✏️ Sửa danh mục</h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-primary">📋 Danh sách</a>
                <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-secondary">🏠 Quay lại</a>
            </div>
        </div>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/category/update" method="post">
                <input type="hidden" name="categoryid" value="${cate.cateId}">
                <div class="form-group">
                    <label for="categoryname">Tên danh mục <span style="color: red;">*</span></label>
                    <input type="text" id="categoryname" name="categoryname" value="${cate.cateName}" required>
                </div>
                <div class="form-group">
                    <label for="images">Hình ảnh (URL)</label>
                    <input type="text" id="images" name="images" value="${cate.icons}" placeholder="Nhập URL ảnh...">
                    <c:if test="${not empty cate.icons}">
                        <div class="preview-image">
                            <img src="${pageContext.request.contextPath}/image?fname=${cate.icons}" alt="${cate.cateName}">
                        </div>
                    </c:if>
                </div>
                <div class="form-group">
                    <label>Trạng thái</label>
                    <div class="radio-group">
                        <label><input type="radio" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}> Hoạt động</label>
                        <label><input type="radio" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}> Khóa</label>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-success">💾 Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">⬅️ Hủy</a>
                </div>
            </form>
        </div>

        <jsp:include page="layout/footer.jsp" />
    </div>

</body>
</html>