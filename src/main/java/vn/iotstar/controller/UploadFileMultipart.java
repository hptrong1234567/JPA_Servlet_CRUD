package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/uploadmulti")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UploadFileMultipart extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/uploadfilemulti.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Lấy đường dẫn upload
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String fileName = "";
        try {
            // Lấy phần file upload
            Part filePart = req.getPart("uploadFile");  // ← TÊN FIELD PHẢI KHỚP VỚI FORM
            if (filePart != null && filePart.getSize() > 0) {
                fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Lưu file
                    filePart.write(uploadPath + File.separator + fileName);
                    req.setAttribute("message", "✅ File " + fileName + " đã upload thành công!");
                } else {
                    req.setAttribute("message", "❌ Tên file không hợp lệ!");
                }
            } else {
                req.setAttribute("message", "❌ Vui lòng chọn file để upload!");
            }
        } catch (Exception e) {
            req.setAttribute("message", "❌ Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/views/result.jsp").forward(req, resp);
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