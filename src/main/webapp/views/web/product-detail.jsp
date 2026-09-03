<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header {
            background: white; padding: 20px 30px; border-radius: 10px;
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            flex-wrap: wrap;
            gap: 10px;
        }
        .header h1 { color: #2c3e50; font-size: 24px; }
        .header-right { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }
        .header-right span { color: #2c3e50; }
        .header-right a { 
            text-decoration: none; font-weight: 600;
            padding: 8px 16px; border-radius: 6px;
            transition: background 0.3s;
        }
        .header-right .back-home { background: #3498db; color: white; }
        .header-right .back-home:hover { background: #2980b9; }
        .header-right .back-list { background: #2ecc71; color: white; }
        .header-right .back-list:hover { background: #27ae60; }
        .header-right .logout { background: #fde8e8; color: #e74c3c; }
        .header-right .logout:hover { background: #fcc; }
        
        .detail-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 30px;
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }
        .detail-image {
            flex: 1 1 300px;
            max-width: 500px;
        }
        .detail-image img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
            background: #ecf0f1;
        }
        .detail-info {
            flex: 1 1 300px;
        }
        .detail-info h2 { font-size: 28px; color: #2c3e50; margin-bottom: 15px; }
        .detail-info .price { font-size: 30px; font-weight: 700; color: #e74c3c; margin-bottom: 15px; }
        .detail-info .category { font-size: 16px; color: #7f8c8d; margin-bottom: 10px; }
        .detail-info .status { 
            display: inline-block; 
            padding: 5px 15px; 
            border-radius: 20px; 
            font-size: 14px; 
            font-weight: 600;
            margin-bottom: 20px;
        }
        .status.in-stock { background: #dcfce7; color: #16a34a; }
        .status.out-stock { background: #fee2e2; color: #dc2626; }
        
        .detail-info .description { 
            color: #555; 
            line-height: 1.8; 
            margin-top: 10px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .detail-info .quantity { font-size: 14px; color: #7f8c8d; margin-top: 10px; }
        
        .back-link { margin-top: 30px; }
        .back-link a { 
            display: inline-block; 
            padding: 10px 25px; 
            background: #3498db; 
            color: white; 
            text-decoration: none;
            border-radius: 8px; 
            font-weight: 600;
            transition: background 0.3s;
        }
        .back-link a:hover { background: #2980b9; }
        
        .footer { background: white; padding: 15px 30px; border-radius: 10px; text-align: center; margin-top: 30px; color: #7f8c8d; }
        .not-found { text-align: center; padding: 60px; color: #7f8c8d; font-size: 18px; background: white; border-radius: 10px; }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h1>📦 Chi tiết sản phẩm</h1>
            <div class="header-right">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/home" class="back-home">🏠 Trang chủ</a>
                <a href="${pageContext.request.contextPath}/product" class="back-list">📋 Danh sách</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout">🚪 Đăng xuất</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty product}">
                <div class="not-found">
                    <h2>❌ Không tìm thấy sản phẩm</h2>
                    <p>Sản phẩm bạn yêu cầu không tồn tại hoặc đã bị xóa.</p>
                    <br>
                    <a href="${pageContext.request.contextPath}/product">🛍️ Quay lại danh sách sản phẩm</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="detail-container">
                    <div class="detail-image">
                        <img src="${pageContext.request.contextPath}/image?fname=${product.imageUrl}" 
                             alt="${product.productName}"
                             onerror="this.src='https://via.placeholder.com/500x400?text=No+Image'">
                    </div>
                    <div class="detail-info">
                        <h2>${product.productName}</h2>
                        <div class="category">📂 Danh mục: ${product.category.cateName}</div>
                        <div class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/></div>
                        
                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <span class="status in-stock">✅ Còn hàng</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status out-stock">❌ Hết hàng</span>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="quantity">📦 Số lượng: ${product.quantity}</div>
                        
                        <div class="description">
                            <strong>📝 Mô tả:</strong><br>
                            ${not empty product.description ? product.description : 'Chưa có mô tả cho sản phẩm này.'}
                        </div>
                        
                        <div style="margin-top: 20px; font-size: 13px; color: #95a5a6;">
                            🕐 Ngày đăng: ${product.createdDate}
                        </div>
                    </div>
                </div>
                
                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/product">⬅️ Quay lại danh sách sản phẩm</a>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="footer">
            <p>© 2026 JPA Servlet CRUD</p>
        </div>
    </div>

</body>
</html>