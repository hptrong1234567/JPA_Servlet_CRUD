package vn.iotstar.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {
    
    // 🔥 THAY ĐỔI THÔNG TIN EMAIL CỦA BẠN VÀO ĐÂY
    private static final String EMAIL = "phutronglabattt@gmail.com";      // Email của bạn
    private static final String PASSWORD = "bnnl lkei ojjk myse";     // Mật khẩu ứng dụng Gmail
    
    public static void sendOTPEmail(String toEmail, String otp) {
        // Cấu hình SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("🔐 Mã OTP xác thực tài khoản");
            
            // Nội dung email HTML
            String htmlContent = "<html>"
                    + "<body style='font-family: Arial, sans-serif;'>"
                    + "<div style='max-width: 500px; margin: 0 auto; padding: 30px; "
                    + "border: 1px solid #e0e0e0; border-radius: 10px;'>"
                    + "<h2 style='color: #667eea;'>🔐 Xác thực tài khoản</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Cảm ơn bạn đã đăng ký tài khoản. Vui lòng nhập mã OTP dưới đây để kích hoạt:</p>"
                    + "<div style='text-align: center; padding: 20px;'>"
                    + "<h1 style='color: #764ba2; letter-spacing: 10px; font-size: 36px;'>"
                    + otp
                    + "</h1>"
                    + "</div>"
                    + "<p style='color: #888; font-size: 12px;'>Mã OTP có hiệu lực trong 5 phút.</p>"
                    + "<hr style='border: 1px solid #f0f0f0;'>"
                    + "<p style='color: #888; font-size: 12px;'>© 2026 JPA Servlet CRUD</p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("✅ Email OTP đã gửi đến: " + toEmail);
            
        } catch (MessagingException e) {
            System.err.println("❌ Lỗi gửi email: " + e.getMessage());
            e.printStackTrace();
        }
    }
 // ===== THÊM PHƯƠNG THỨC GỬI EMAIL ĐƠN GIẢN =====
    public static void sendEmail(String toEmail, String subject, String messageText) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject);
            message.setText(messageText);
            Transport.send(message);
            System.out.println("✅ Email đã gửi đến: " + toEmail);
        } catch (MessagingException e) {
            System.err.println("❌ Lỗi gửi email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}