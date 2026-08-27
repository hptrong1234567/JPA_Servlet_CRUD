package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

@WebServlet(urlPatterns = { 
    "/admin/categories", 
    "/admin/category/add", 
    "/admin/category/insert",
    "/admin/category/edit", 
    "/admin/category/update", 
    "/admin/category/delete" 
})
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/categories")) {
            // Lấy danh sách category
            List<Category> list = categoryService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/add")) {
            // Chuyển đến trang thêm
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/edit")) {
            // Lấy category theo id để sửa
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/delete")) {
            // Xóa category
            int id = Integer.parseInt(req.getParameter("id"));
            categoryService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            // Thêm category mới
            String categoryName = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String images = req.getParameter("images");

            Category category = new Category();
            category.setCateName(categoryName);
            category.setStatus(status);
            category.setIcons(images);

            categoryService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/update")) {
            // Cập nhật category
            int categoryId = Integer.parseInt(req.getParameter("categoryid"));
            String categoryName = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String images = req.getParameter("images");

            Category category = categoryService.findById(categoryId);
            if (category != null) {
                category.setCateName(categoryName);
                category.setStatus(status);
                if (images != null && !images.isEmpty()) {
                    category.setIcons(images);
                }
                categoryService.update(category);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}

