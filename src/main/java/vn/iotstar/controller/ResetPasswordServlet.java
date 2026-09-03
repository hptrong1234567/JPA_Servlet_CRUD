package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");
        
        // Kiểm tra mật khẩu khớp
        if (!newPassword.equals(confirmPassword)) {
            resp.sendRedirect(req.getContextPath() + "/reset-password.html?alert=" 
                    + URLEncoder.encode("❌ Mật khẩu xác nhận không khớp!", "UTF-8"));
            return;
        }
        
        UserServiceImpl userService = new UserServiceImpl();
        boolean success = userService.resetPassword(email, otp, newPassword);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode("✅ Đặt lại mật khẩu thành công! Vui lòng đăng nhập.", "UTF-8"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/reset-password.html?alert=" 
                    + URLEncoder.encode("❌ Mã OTP không đúng hoặc đã hết hạn. Vui lòng thử lại!", "UTF-8"));
        }
    }
}