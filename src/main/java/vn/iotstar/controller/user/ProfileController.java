package vn.iotstar.controller.user;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constants;

@WebServlet(urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 25
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserServiceImpl userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/Login.html");
            return;
        }
        
        User updatedUser = userService.get(user.getUsername());
        if (updatedUser != null) {
            req.setAttribute("user", updatedUser);
        } else {
            req.setAttribute("user", user);
        }
        
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("account");
        
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/Login.html");
            return;
        }
        
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        
        User user = new User();
        user.setUsername(sessionUser.getUsername());
        user.setFullname(fullname);
        user.setPhone(phone);
        
        // 🔥 ===== XỬ LÝ AVATAR =====
        String uploadPath = Constants.UPLOAD_DIRECTORY + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String avatarPath = sessionUser.getAvatar(); // Giữ avatar cũ làm mặc định
        
        try {
            Part filePart = req.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Tạo tên file duy nhất
                    String fileExtension = "";
                    int dotIndex = fileName.lastIndexOf(".");
                    if (dotIndex > 0) {
                        fileExtension = fileName.substring(dotIndex);
                    }
                    String newFileName = System.currentTimeMillis() + fileExtension;
                    
                    // Lưu file
                    filePart.write(uploadPath + File.separator + newFileName);
                    
                    // Cập nhật đường dẫn avatar mới
                    avatarPath = "avatars/" + newFileName;
                }
            }
            // Nếu không chọn file, giữ nguyên avatar cũ (avatarPath đã được set ở trên)
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
        }
        
        user.setAvatar(avatarPath); // Luôn set avatar (có thể là cũ hoặc mới)
        // ===== KẾT THÚC XỬ LÝ AVATAR =====
        
        User updatedUser = userService.updateProfile(user);
        
        if (updatedUser != null) {
            session.setAttribute("account", updatedUser);
            req.setAttribute("success", "✅ Cập nhật hồ sơ thành công!");
            req.setAttribute("user", updatedUser);
        } else {
            req.setAttribute("error", "❌ Cập nhật hồ sơ thất bại!");
            req.setAttribute("user", sessionUser);
        }
        
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            String[] tokens = contentDisposition.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf("=") + 2, token.length() - 1);
                }
            }
        }
        return null;
    }
}