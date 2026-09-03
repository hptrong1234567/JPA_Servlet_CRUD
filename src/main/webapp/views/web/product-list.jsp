<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm</title>
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
        .header-right .logout { background: #fde8e8; color: #e74c3c; }
        .header-right .logout:hover { background: #fcc; }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        @media (max-width: 768px) { .product-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 480px) { .product-grid { grid-template-columns: 1fr; } }
        
        .product-card {
            background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden; transition: transform 0.3s, box-shadow 0.3s; cursor: pointer;
        }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .product-card img {
            width: 100%; height: 200px; object-fit: cover;
            background: #ecf0f1;
        }
        .product-card .info { padding: 15px; }
        .product-card .info h3 { 
            font-size: 16px; color: #2c3e50; margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 48px;
        }
        .product-card .info .price { font-size: 18px; font-weight: 700; color: #e74c3c; }
        .product-card .info .category { font-size: 12px; color: #7f8c8d; margin-top: 5px; }
        
        .pagination {
            display: flex; justify-content: center; align-items: center;
            gap: 8px; flex-wrap: wrap;
            background: white; padding: 20px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .pagination a, .pagination span {
            padding: 8px 14px; border-radius: 6px; text-decoration: none;
            color: #3498db; border: 1px solid #e8e8e8; transition: 0.3s;
            min-width: 40px; text-align: center;
        }
        .pagination a:hover { background: #3498db; color: white; border-color: #3498db; }
        .pagination .active { background: #3498db; color: white; border-color: #3498db; }
        .pagination .disabled { color: #bbb; cursor: not-allowed; border-color: #f0f0f0; }
        .pagination .info { color: #7f8c8d; border: none; }
        
        .footer { background: white; padding: 15px 30px; border-radius: 10px; text-align: center; margin-top: 30px; color: #7f8c8d; }
        .empty { text-align: center; padding: 60px; color: #7f8c8d; font-size: 16px; background: white; border-radius: 10px; }
        .total-info { text-align: center; color: #7f8c8d; margin-bottom: 20px; font-size: 14px; }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <h1>🛍️ Danh sách sản phẩm</h1>
            <div class="header-right">
                <span>Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/home" class="back-home">🏠 Trang chủ</a>
                <a href="${pageContext.request.contextPath}/logout" class="logout">🚪 Đăng xuất</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div class="empty">📭 Không có sản phẩm nào.</div>
            </c:when>
            <c:otherwise>
                <div class="total-info">
                    Hiển thị <strong>${products.size()}</strong> sản phẩm trên trang <strong>${currentPage}/${totalPages}</strong> (Tổng: ${totalProducts} sản phẩm)
                </div>
                
                <div class="product-grid">
                    <c:forEach items="${products}" var="product">
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

                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">◀</a>
                    </c:if>
                    <c:if test="${currentPage <= 1}">
                        <span class="disabled">◀</span>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="active">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">▶</a>
                    </c:if>
                    <c:if test="${currentPage >= totalPages}">
                        <span class="disabled">▶</span>
                    </c:if>
                    
                    <span class="info">${currentPage}/${totalPages}</span>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="footer">
            <p>© 2026 JPA Servlet CRUD</p>
        </div>
    </div>

</body>
</html>