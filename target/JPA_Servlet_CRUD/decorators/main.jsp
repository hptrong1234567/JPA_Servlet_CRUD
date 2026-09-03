<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="Trang chủ" /></title>
    <decorator:head />
</head>
<body>
    <!-- Header -->
    <header style="background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center;">
        <h1 style="margin: 0;">🏠 MyWebsite</h1>
        <div style="display: flex; gap: 15px; align-items: center;">
            <c:if test="${not empty sessionScope.account}">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/profile" style="color: #1abc9c; text-decoration: none;">👤 Hồ sơ</a>
                <c:if test="${sessionScope.account.roleid == 1}">
                    <a href="${pageContext.request.contextPath}/admin/home" style="color: #f39c12; text-decoration: none;">⚙️ Admin</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" style="color: #e74c3c; text-decoration: none;">🚪 Đăng xuất</a>
            </c:if>
            <c:if test="${empty sessionScope.account}">
                <a href="${pageContext.request.contextPath}/Login.html" style="color: white; text-decoration: none;">🔐 Đăng nhập</a>
            </c:if>
        </div>
    </header>

    <!-- Content -->
    <div style="max-width: 1200px; margin: 20px auto; padding: 0 20px;">
        <decorator:body />
    </div>

    <!-- Footer -->
    <footer style="background: #2c3e50; color: #bdc3c7; text-align: center; padding: 20px; margin-top: 30px;">
        <p>© 2026 MyWebsite - JPA Servlet CRUD</p>
    </footer>
</body>
</html>