package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        UserServiceImpl userService = new UserServiceImpl();
        User user = userService.get(username);  // Lấy user để kiểm tra
        
        // 🔥 TRƯỜNG HỢP 1: Tài khoản không tồn tại
        if (user == null) {
            String alertMsg = "Tài khoản không tồn tại!";
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
            return;
        }
        
        // 🔥 TRƯỜNG HỢP 2: Sai mật khẩu
        if (!password.equals(user.getPassword())) {
            String alertMsg = "Mật khẩu không đúng!";
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
            return;
        }
        
        // 🔥 TRƯỜNG HỢP 3: Tài khoản chưa kích hoạt
        if (user.getStatus() == 0) {
            String alertMsg = "⚠️ Tài khoản chưa được kích hoạt! Vui lòng kiểm tra email và nhập mã OTP để xác thực.";
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
            return;
        }
        
        // ✅ ĐĂNG NHẬP THÀNH CÔNG
        HttpSession session = req.getSession(true);
        session.setAttribute("account", user);
        session.setMaxInactiveInterval(30 * 60);
        
        if (user.getRoleid() == 1) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}