<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
        .header-right { display: flex; align-items: center; gap: 20px; }
        .header-right span { color: #2c3e50; }
        .header-right a { 
            color: #e74c3c; 
            text-decoration: none; 
            font-weight: 600; 
            padding: 8px 16px; 
            border-radius: 6px; 
            background: #fde8e8; 
        }
        .header-right a:hover { background: #fcc; }
        
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
        }
        .card .number { font-size: 32px; font-weight: bold; color: #2c3e50; }
        .card .label { color: #7f8c8d; margin-top: 5px; }
        .card.blue { border-left: 4px solid #3498db; }
        .card.green { border-left: 4px solid #2ecc71; }
        .card.orange { border-left: 4px solid #f39c12; }
        .card.red { border-left: 4px solid #e74c3c; }
        
        .profile-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .profile-card h3 { color: #2c3e50; margin-bottom: 15px; }
        .profile-card .info { display: flex; gap: 30px; flex-wrap: wrap; }
        .profile-card .info .item { display: flex; gap: 10px; }
        .profile-card .info .item .label { color: #7f8c8d; }
        .profile-card .info .item .value { font-weight: 600; }
        
        .quick-actions {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .quick-actions h3 { margin-bottom: 20px; color: #2c3e50; }
        .quick-actions .action-buttons { display: flex; gap: 15px; flex-wrap: wrap; }
        .quick-actions .action-buttons a {
            padding: 12px 25px;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }
        .quick-actions .action-buttons a.green { background: #2ecc71; }
        .quick-actions .action-buttons a.green:hover { background: #27ae60; }
        .quick-actions .action-buttons a.blue { background: #3498db; }
        .quick-actions .action-buttons a.blue:hover { background: #2980b9; }
        .quick-actions .action-buttons a.orange { background: #f39c12; }
        .quick-actions .action-buttons a.orange:hover { background: #e67e22; }
        .quick-actions .action-buttons a.red { background: #e74c3c; }
        .quick-actions .action-buttons a.red:hover { background: #c0392b; }
        
        .footer {
            background: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-align: center;
            margin-top: 30px;
            color: #7f8c8d;
            font-size: 14px;
        }
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
        .sidebar .logo { text-align: center; padding: 20px; border-bottom: 1px solid #34495e; }
        .sidebar .logo h3 { color: #ecf0f1; margin: 0; }
        .sidebar .nav-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar .nav-menu li { border-bottom: 1px solid #34495e; }
        .sidebar .nav-menu li a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: all 0.3s; }
        .sidebar .nav-menu li a:hover { background: #34495e; color: white; }
        .sidebar .nav-menu li a.active { background: #1abc9c; color: white; }
        
        @media (max-width: 768px) {
            .sidebar { width: 200px; }
            .main-content { margin-left: 200px; }
            .dashboard-cards { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 480px) {
            .sidebar { display: none; }
            .main-content { margin-left: 0; }
            .dashboard-cards { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <jsp:include page="layout/sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📊 Dashboard</h1>
            <div class="header-right">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
            </div>
        </div>

        <div class="dashboard-cards">
            <div class="card blue">
                <div class="number">0</div>
                <div class="label">Danh mục</div>
            </div>
            <div class="card green">
                <div class="number">0</div>
                <div class="label">Sản phẩm</div>
            </div>
            <div class="card orange">
                <div class="number">0</div>
                <div class="label">Đơn hàng mới</div>
            </div>
            <div class="card red">
                <div class="number">0</div>
                <div class="label">Người dùng mới</div>
            </div>
        </div>

        <div class="profile-card">
            <h3>👤 Thông tin tài khoản</h3>
            <div class="info">
                <div class="item">
                    <span class="label">Tên đăng nhập:</span>
                    <span class="value">${sessionScope.account.username}</span>
                </div>
                <div class="item">
                    <span class="label">Họ và tên:</span>
                    <span class="value">${sessionScope.account.fullname}</span>
                </div>
                <div class="item">
                    <span class="label">Email:</span>
                    <span class="value">${sessionScope.account.email}</span>
                </div>
                <div class="item">
                    <span class="label">Số điện thoại:</span>
                    <span class="value">${sessionScope.account.phone}</span>
                </div>
            </div>
        </div>

        <div class="quick-actions">
            <h3>⚡ Thao tác nhanh</h3>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/category/add" class="green">➕ Thêm danh mục mới</a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="blue">📋 Xem danh sách danh mục</a>
                <a href="${pageContext.request.contextPath}/logout" class="red">🚪 Đăng xuất</a>
            </div>
        </div>

        <jsp:include page="layout/footer.jsp" />
    </div>

</body>
</html>