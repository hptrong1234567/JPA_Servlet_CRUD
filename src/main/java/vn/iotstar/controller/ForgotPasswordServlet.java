package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String email = req.getParameter("email");
        
        UserServiceImpl userService = new UserServiceImpl();
        boolean success = userService.sendOTPForgotPassword(email);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/reset-password.html?alert=" 
                    + URLEncoder.encode("✅ Mã OTP đã được gửi đến email của bạn! Vui lòng kiểm tra.", "UTF-8"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/forgot-password.html?alert=" 
                    + URLEncoder.encode("❌ Email không tồn tại trong hệ thống. Vui lòng kiểm tra lại!", "UTF-8"));
        }
    }
}