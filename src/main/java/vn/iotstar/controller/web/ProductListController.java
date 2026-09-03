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

@WebServlet(urlPatterns = {"/product"})
public class ProductListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductServiceImpl productService = new ProductServiceImpl();
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Lấy trang hiện tại
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Lấy tổng số sản phẩm và tính tổng số trang
        int totalProducts = productService.count();
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
        
        // Giới hạn trang
        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;
        
        // Lấy danh sách sản phẩm theo trang
        List<Product> products = productService.findAll(page - 1, PAGE_SIZE);
        
        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);
        
        req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
    }
}