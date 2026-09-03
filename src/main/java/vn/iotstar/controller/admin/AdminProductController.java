package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { 
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete" 
})
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductServiceImpl productService = new ProductServiceImpl();
    private CategoryServiceImpl categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            // Lấy danh sách sản phẩm
            List<Product> products = productService.findAll();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/add")) {
            // Lấy danh sách category để chọn
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/edit")) {
            // Lấy sản phẩm theo id để sửa
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/delete")) {
            // Xóa sản phẩm
            int id = Integer.parseInt(req.getParameter("id"));
            productService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            // Thêm sản phẩm mới
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String description = req.getParameter("description");
            String imageUrl = req.getParameter("imageUrl");
            int status = Integer.parseInt(req.getParameter("status"));
            int cateId = Integer.parseInt(req.getParameter("cateId"));

            Category category = categoryService.findById(cateId);
            Product product = new Product(productName, price, quantity, description, imageUrl, status, category);
            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/update")) {
            // Cập nhật sản phẩm
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String description = req.getParameter("description");
            String imageUrl = req.getParameter("imageUrl");
            int status = Integer.parseInt(req.getParameter("status"));
            int cateId = Integer.parseInt(req.getParameter("cateId"));

            Product product = productService.findById(productId);
            if (product != null) {
                Category category = categoryService.findById(cateId);
                product.setProductName(productName);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setDescription(description);
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    product.setImageUrl(imageUrl);
                }
                product.setStatus(status);
                product.setCategory(category);
                productService.update(product);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}