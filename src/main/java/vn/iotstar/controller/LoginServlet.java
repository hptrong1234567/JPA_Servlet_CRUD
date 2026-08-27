package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;          // 👈 PHẢI LÀ jakarta.servlet
import jakarta.servlet.annotation.WebServlet;    // 👈 PHẢI LÀ jakarta.servlet
import jakarta.servlet.http.HttpServlet;         // 👈 PHẢI LÀ jakarta.servlet
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/Login"})   // 👈 PHẢI CÓ DÒNG NÀY
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
        User user = userService.login(username, password);
        
        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);
            
            // Kiểm tra role, nếu là admin thì vào admin, ngược lại về trang chủ
            if (user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            String alertMsg = "Tài khoản hoặc mật khẩu không đúng!";
            resp.sendRedirect(req.getContextPath() + "/Login.html?alert=" 
                    + URLEncoder.encode(alertMsg, "UTF-8"));
        }
    }
}