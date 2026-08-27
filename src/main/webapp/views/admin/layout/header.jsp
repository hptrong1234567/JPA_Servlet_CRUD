<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
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
.header h1 {
    color: #2c3e50;
    margin: 0;
    font-size: 24px;
}
.header-right {
    display: flex;
    align-items: center;
    gap: 20px;
}
.header-right span {
    color: #2c3e50;
}
.header-right a {
    color: #e74c3c;
    text-decoration: none;
    font-weight: 600;
    padding: 8px 16px;
    border-radius: 6px;
    background: #fde8e8;
    transition: background 0.3s;
}
.header-right a:hover {
    background: #fcc;
}
</style>

<div class="header">
    <div class="header-left">
        <h1>Quản lý danh mục</h1>
    </div>
    <div class="header-right">
        <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
        <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
    </div>
</div>