<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
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
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn-danger:hover { background: #c0392b; }
        .btn-warning { background: #f39c12; color: white; }
        .btn-warning:hover { background: #e67e22; }

        .table-container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .table-header h2 { color: #2c3e50; }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th {
            background: #f8f9fa;
            text-align: left;
            padding: 12px 15px;
            border-bottom: 2px solid #dee2e6;
        }
        table td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
        }
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
    </style>
</head>
<body>

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-content">
        <jsp:include page="layout/header.jsp" />

        <div class="table-container">
            <div class="table-header">
                <h2>📋 Danh sách danh mục</h2>
                <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success">➕ Thêm danh mục</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình ảnh</th>
                        <th>Tên danh mục</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listcate}">
                            <tr>
                                <td colspan="5" class="empty-msg">📭 Chưa có danh mục nào. Hãy thêm danh mục mới!</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${listcate}" var="cate" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty cate.icons}">
                                                <img src="${pageContext.request.contextPath}/image?fname=${cate.icons}" 
                                                     alt="${cate.cateName}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 6px;">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width: 60px; height: 60px; background: #ecf0f1; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #bdc3c7; font-size: 12px;">No Image</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${cate.cateName}</strong></td>
                                    <td>
                                        <c:if test="${cate.status == 1}">
                                            <span class="status-active">✅ Hoạt động</span>
                                        </c:if>
                                        <c:if test="${cate.status != 1}">
                                            <span class="status-inactive">⛔ Khóa</span>
                                        </c:if>
                                    </td>
                                    <td class="actions">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.cateId}" class="edit">✏️ Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.cateId}" 
                                           class="delete" 
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">🗑️ Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <jsp:include page="layout/footer.jsp" />
    </div>

</body>
</html>