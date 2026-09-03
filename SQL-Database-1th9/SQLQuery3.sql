USE ServletCRUDMVC;
GO

-- Đếm số Products theo từng Category
SELECT 
    c.cate_id,
    c.cate_name,
    COUNT(p.product_id) AS Total_Products
FROM 
    Category c
    LEFT JOIN Products p ON c.cate_id = p.cate_id
GROUP BY 
    c.cate_id, c.cate_name
ORDER BY 
    Total_Products DESC;