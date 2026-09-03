<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            display: flex;
            min-height: 100vh;
        }
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 20px;
        }
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
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header-right { display: flex; align-items: center; gap: 15px; }
        .header-right a { text-decoration: none; font-weight: 600; padding: 8px 16px; border-radius: 6px; }
        .header-right .btn-add { background: #2ecc71; color: white; }
        .header-right .btn-add:hover { background: #27ae60; }
        .header-right .btn-home { background: #3498db; color: white; }
        .header-right .btn-home:hover { background: #2980b9; }
        
        .table-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        table { width: 100%; border-collapse: collapse; }
        table th {
            background: #f8f9fa;
            text-align: left;
            padding: 12px 15px;
            border-bottom: 2px solid #dee2e6;
        }
        table td { padding: 12px 15px; border-bottom: 1px solid #dee2e6; }
        table tr:hover { background: #f8f9fa; }
        .actions a {
            margin-right: 10px;
            text-decoration: none;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .actions a.edit { color: #f39c12; }
        .actions a.edit:hover { background: #fef9e7; }
        .actions a.delete { color: #e74c3c; }
        .actions a.delete:hover { background: #fdedec; }
        .empty-msg { text-align: center; padding: 40px; color: #7f8c8d; font-size: 16px; }
        .status-active { color: #2ecc71; font-weight: 600; }
        .status-inactive { color: #e74c3c; font-weight: 600; }
        
        .sidebar { width: 260px; background: #2c3e50; color: white; padding: 20px 0; position: fixed; height: 100vh; overflow-y: auto; top: 0; left: 0; }
        .sidebar .logo { text-align: center; padding: 20px; border-bottom: 1px solid #34495e; }
        .sidebar .logo h3 { color: #ecf0f1; margin: 0; }
        .sidebar .nav-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar .nav-menu li { border-bottom: 1px solid #34495e; }
        .sidebar .nav-menu li a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: all 0.3s; }
        .sidebar .nav-menu li a:hover { background: #34495e; color: white; }
        .sidebar .nav-menu li a.active { background: #1abc9c; color: white; }
        .product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body>

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📦 Quản lý sản phẩm</h1>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn-add">➕ Thêm sản phẩm</a>
                <a href="${pageContext.request.contextPath}/admin/home" class="btn-home">🏠 Quay lại</a>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Danh mục</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="8" class="empty-msg">📭 Chưa có sản phẩm nào. Hãy thêm sản phẩm mới!</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${products}" var="product" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/image?fname=${product.imageUrl}" 
                                             alt="${product.productName}" 
                                             class="product-img"
                                             onerror="this.src='https://via.placeholder.com/60x60?text=No+Image'">
                                    </td>
                                    <td><strong>${product.productName}</strong></td>
                                    <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></td>
                                    <td>${product.quantity}</td>
                                    <td>${product.category.cateName}</td>
                                    <td>
                                        <c:if test="${product.status == 1}">
                                            <span class="status-active">✅ Hoạt động</span>
                                        </c:if>
                                        <c:if test="${product.status != 1}">
                                            <span class="status-inactive">⛔ Khóa</span>
                                        </c:if>
                                    </td>
                                    <td class="actions">
                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${product.productId}" class="edit">✏️ Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.productId}" 
                                           class="delete" 
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">🗑️ Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>