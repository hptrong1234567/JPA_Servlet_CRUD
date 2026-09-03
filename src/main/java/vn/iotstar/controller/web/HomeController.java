package vn.iotstar.controller.web;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.service.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductServiceImpl productService = new ProductServiceImpl();
    private static final int NEWEST_LIMIT = 10;  // 🔥 GIỚI HẠN 10 SẢN PHẨM

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 🔥 SỬA: Chỉ lấy 10 sản phẩm mới nhất
        List<Product> newestProducts = productService.findNewest(NEWEST_LIMIT);
        req.setAttribute("newestProducts", newestProducts);
        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}