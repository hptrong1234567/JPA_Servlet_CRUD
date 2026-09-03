<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload File với Commons FileUpload</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); max-width: 500px; width: 100%; }
        h2 { color: #2c3e50; text-align: center; }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-weight: 600; margin-bottom: 5px; color: #555; }
        input[type="file"] { width: 100%; padding: 10px; border: 2px dashed #ddd; border-radius: 8px; background: #fafafa; cursor: pointer; }
        input[type="text"] { width: 100%; padding: 12px; border: 2px solid #e8e8e8; border-radius: 8px; font-size: 15px; }
        .btn { width: 100%; padding: 14px; background: #2ecc71; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; }
        .btn:hover { background: #27ae60; }
        .back { display: block; text-align: center; margin-top: 15px; color: #7f8c8d; }
    </style>
</head>
<body>
    <div class="container">
        <h2>📤 Upload File với Commons FileUpload</h2>
        <form method="post" action="${pageContext.request.contextPath}/uploadcommons" enctype="multipart/form-data">
            <div class="form-group">
                <label>Chọn file:</label>
                <input type="file" name="uploadFile" />
            </div>
            <div class="form-group">
                <label>Tên file (không bắt buộc):</label>
                <input type="text" name="name" placeholder="Nhập tên file..." />
            </div>
            <button type="submit" class="btn">📤 Upload</button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/home" class="back">🏠 Quay lại Admin</a>
    </div>
</body>
</html>