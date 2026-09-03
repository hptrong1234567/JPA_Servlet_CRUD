package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        
        UserServiceImpl userService = new UserServiceImpl();
        boolean activated = userService.activateAccount(email, otp);
        
        if (activated) {
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode("✅ Tài khoản đã được kích hoạt! Vui lòng đăng nhập.", "UTF-8"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/verify-otp.html?alert=" 
                    + URLEncoder.encode("❌ Mã OTP không đúng hoặc đã hết hạn. Vui lòng thử lại!", "UTF-8"));
        }
    }
}