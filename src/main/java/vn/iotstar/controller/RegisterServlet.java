package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        
        UserServiceImpl userService = new UserServiceImpl();
        
        // Kiểm tra username đã tồn tại
        if (userService.checkExistUsername(username)) {
            String alertMsg = "Tên đăng nhập đã tồn tại!";
            resp.sendRedirect(req.getContextPath() + "/register.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
            return;
        }
        
        // Kiểm tra email đã tồn tại
        if (userService.checkExistEmail(email)) {
            String alertMsg = "Email đã được sử dụng!";
            resp.sendRedirect(req.getContextPath() + "/register.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
            return;
        }
        
        // Đăng ký
        boolean success = userService.register(username, password, fullname, email, phone);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode("Đăng ký thành công! Vui lòng đăng nhập.", "UTF-8"));
        } else {
            String alertMsg = "Đăng ký thất bại! Vui lòng thử lại.";
            resp.sendRedirect(req.getContextPath() + "/register.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
        }
    }
}