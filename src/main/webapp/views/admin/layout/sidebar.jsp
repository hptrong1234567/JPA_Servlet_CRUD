<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
.sidebar {
    width: 260px;
    background: #2c3e50;
    color: white;
    padding: 20px 0;
    position: fixed;
    height: 100vh;
    overflow-y: auto;
    top: 0;
    left: 0;
}
.sidebar .logo {
    text-align: center;
    padding: 20px;
    border-bottom: 1px solid #34495e;
}
.sidebar .logo h3 {
    color: #ecf0f1;
    margin: 0;
}
.sidebar .nav-menu {
    list-style: none;
    padding: 0;
    margin: 0;
}
.sidebar .nav-menu li {
    border-bottom: 1px solid #34495e;
}
.sidebar .nav-menu li a {
    display: block;
    padding: 15px 25px;
    color: #bdc3c7;
    text-decoration: none;
    transition: all 0.3s;
}
.sidebar .nav-menu li a:hover {
    background: #34495e;
    color: white;
}
.sidebar .nav-menu li a.active {
    background: #1abc9c;
    color: white;
}
</style>

<div class="sidebar">
    <div class="logo">
        <h3>Admin Panel</h3>
    </div>
    <ul class="nav-menu">
        <li><a href="${pageContext.request.contextPath}/admin/home">📊 Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/categories" class="active">📂 Quản lý danh mục</a></li>
        <li><a href="#">🛒 Quản lý sản phẩm</a></li>
        <li><a href="#">👤 Quản lý người dùng</a></li>
        <li><a href="#">📦 Quản lý đơn hàng</a></li>
        <li><a href="#">⚙️ Cài đặt</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a></li>
    </ul>
</div>