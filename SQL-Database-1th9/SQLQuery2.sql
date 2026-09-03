USE ServletCRUDMVC;
GO

CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    quantity INT DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    image_url NVARCHAR(500) NULL,
    status INT DEFAULT 1,
    created_date DATETIME DEFAULT GETDATE(),
    cate_id INT NOT NULL,
    CONSTRAINT FK_Products_Category FOREIGN KEY (cate_id) REFERENCES Category(cate_id)
);
GO

-- Thêm dữ liệu mẫu
INSERT INTO Products (product_name, price, quantity, description, image_url, status, created_date, cate_id)
VALUES 
    (N'iPhone 15 Pro Max', 29990000, 10, N'Điện thoại cao cấp nhất của Apple', 'iphone15.jpg', 1, GETDATE(), 1),
    (N'Samsung Galaxy S24', 22990000, 15, N'Điện thoại Samsung flagship', 'samsung24.jpg', 1, GETDATE(), 1),
    (N'Laptop Dell XPS 16', 35990000, 5, N'Laptop cao cấp cho dân văn phòng', 'dellxps.jpg', 1, GETDATE(), 2),
    (N'MacBook Pro M3', 40990000, 8, N'Laptop Apple mạnh mẽ với chip M3', 'macbookm3.jpg', 1, GETDATE(), 2),
    (N'Tai nghe Sony WH-1000XM5', 8990000, 20, N'Tai nghe chống ồn tốt nhất', 'sonywh1000xm5.jpg', 1, GETDATE(), 3),
    (N'Chuột Logitech MX Master 3S', 2990000, 25, N'Chuột cao cấp cho dân văn phòng', 'mxmaster3s.jpg', 1, GETDATE(), 3),
    (N'iPhone 15', 21990000, 20, N'iPhone 15 chính hãng', 'iphone15.jpg', 1, GETDATE(), 1),
    (N'Samsung Galaxy Z Fold 5', 34990000, 7, N'Điện thoại gập cao cấp', 'fold5.jpg', 1, GETDATE(), 1),
    (N'Laptop ASUS ROG Zephyrus', 29990000, 6, N'Laptop gaming mạnh mẽ', 'rogzephyrus.jpg', 1, GETDATE(), 2),
    (N'AirPods Pro 2', 7990000, 30, N'Tai nghe Apple chống ồn', 'airpodspro2.jpg', 1, GETDATE(), 3);
GO

SELECT * FROM Products;