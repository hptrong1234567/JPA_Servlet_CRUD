<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
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
            flex-wrap: wrap;
            gap: 10px;
        }
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header-right { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        .header-right span { color: #2c3e50; }
        .header-right a { 
            text-decoration: none; 
            font-weight: 600; 
            padding: 8px 16px; 
            border-radius: 6px; 
            transition: background 0.3s;
        }
        .header-right .logout { 
            color: #e74c3c; 
            background: #fde8e8; 
        }
        .header-right .logout:hover { background: #fcc; }
        .header-right .admin-link { 
            color: white; 
            background: #3498db; 
        }
        .header-right .admin-link:hover { background: #2980b9; }
        
        .welcome-card {
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
            margin-bottom: 30px;
        }
        .welcome-card h2 { color: #2c3e50; font-size: 24px; }
        .welcome-card p { color: #7f8c8d; font-size: 16px; margin-top: 5px; }
        
        /* 🔥🔥🔥 ===== THÊM MỚI: CSS CHO SẢN PHẨM ===== 🔥🔥🔥 */
        .section-title { 
            font-size: 24px; 
            color: #2c3e50; 
            margin-bottom: 20px; 
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .product-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        .product-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 5px 20px rgba(0,0,0,0.1); 
        }
        .product-card img {
            width: 100%; 
            height: 200px; 
            object-fit: cover;
            background: #ecf0f1;
        }
        .product-card .info { padding: 15px; }
        .product-card .info h3 { 
            font-size: 16px; 
            color: #2c3e50; 
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 48px;
        }
        .product-card .info .price { 
            font-size: 18px; 
            font-weight: 700; 
            color: #e74c3c; 
        }
        .product-card .info .category { 
            font-size: 12px; 
            color: #7f8c8d; 
            margin-top: 5px; 
        }
        
        .view-all { 
            text-align: center; 
            margin-top: 10px;
            margin-bottom: 30px;
        }
        .view-all a { 
            display: inline-block; 
            padding: 12px 30px; 
            background: #3498db; 
            color: white; 
            text-decoration: none;
            border-radius: 8px; 
            font-weight: 600;
            transition: background 0.3s;
        }
        .view-all a:hover { background: #2980b9; }
        /* 🔥🔥🔥 ===== KẾT THÚC THÊM MỚI ===== 🔥🔥🔥 */
        
        .footer {
            background: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-align: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        .empty { 
            text-align: center; 
            padding: 40px; 
            color: #7f8c8d; 
            font-size: 16px; 
            background: white; 
            border-radius: 10px; 
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>🏠 Trang chủ</h1>
            <div class="header-right">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <c:if test="${sessionScope.account.roleid == 1}">
                    <a href="${pageContext.request.contextPath}/admin/home" class="admin-link">⚙️ Admin</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" class="logout">🚪 Đăng xuất</a>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="welcome-card">
            <h2>👋 Chào mừng bạn đến với trang chủ!</h2>
            <p>Bạn đã đăng nhập thành công với tư cách là <strong>${sessionScope.account.fullname}</strong></p>
            <p style="margin-top: 5px; color: #888; font-size: 14px;">
                <strong>Username:</strong> ${sessionScope.account.username} &nbsp;|&nbsp; 
                <strong>Email:</strong> ${sessionScope.account.email}
            </p>
        </div>

        <!-- 🔥🔥🔥 ===== THÊM MỚI: DANH SÁCH SẢN PHẨM MỚI NHẤT ===== 🔥🔥🔥 -->
        <h2 class="section-title">🆕 Sản phẩm mới nhất</h2>
        
        <c:choose>
            <c:when test="${empty newestProducts}">
                <div class="empty">📭 Chưa có sản phẩm nào.</div>
            </c:when>
            <c:otherwise>
                <div class="product-grid">
                    <c:forEach items="${newestProducts}" var="product">
                        <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${product.productId}'">
                            <img src="${pageContext.request.contextPath}/image?fname=${product.imageUrl}" 
                                 alt="${product.productName}" 
                                 onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                            <div class="info">
                                <h3>${product.productName}</h3>
                                <div>
                                    <span class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></span>
                                </div>
                                <div class="category">📂 ${product.category.cateName}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/product">🛍️ Xem tất cả sản phẩm</a>
                </div>
            </c:otherwise>
        </c:choose>
        <!-- 🔥🔥🔥 ===== KẾT THÚC THÊM MỚI ===== 🔥🔥🔥 -->

        <!-- Footer -->
        <div class="footer">
            <p>© 2026 JPA Servlet CRUD</p>
        </div>
    </div>

</body>
</html>