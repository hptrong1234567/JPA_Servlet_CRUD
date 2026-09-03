<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả upload</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); max-width: 500px; width: 100%; text-align: center; }
        .success { color: #2ecc71; font-size: 20px; }
        .error { color: #e74c3c; font-size: 20px; }
        .back { display: inline-block; margin-top: 20px; padding: 10px 25px; background: #3498db; color: white; text-decoration: none; border-radius: 6px; }
        .back:hover { background: #2980b9; }
        h2 { color: #2c3e50; }
    </style>
</head>
<body>
    <div class="container">
        <h2>📤 Kết quả upload</h2>
        <hr>
        <c:choose>
            <c:when test="${not empty message}">
                <p class="${message.contains('thành công') ? 'success' : 'error'}">${message}</p>
            </c:when>
            <c:otherwise>
                <p class="error">❌ Không có thông báo nào!</p>
            </c:otherwise>
        </c:choose>
        <br>
        <a href="${pageContext.request.contextPath}/admin/home" class="back">🏠 Quay lại Admin</a>
        <br>
        <a href="${pageContext.request.contextPath}/uploadmulti" class="back" style="background: #2ecc71; margin-top: 10px;">📤 Upload tiếp</a>
    </div>
</body>
</html>