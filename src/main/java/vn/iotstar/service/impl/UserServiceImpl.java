package vn.iotstar.service.impl;

import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailUtil;

public class UserServiceImpl implements IUserService {
    private UserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassword())) {
            if (user.getStatus() != 1) {
                System.out.println("❌ Tài khoản chưa kích hoạt: " + username);
                return null;
            }
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public boolean register(String username, String password, String fullname, String email, String phone) {
        if (checkExistUsername(username) || checkExistEmail(email)) {
            return false;
        }
        
        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
        System.out.println("📧 OTP cho " + email + ": " + otp);
        
        User user = new User(username, password, fullname, email, phone, 2);
        user.setStatus(0);
        user.setOtpCode(otp);
        
        userDao.insert(user);
        EmailUtil.sendOTPEmail(email, otp);
        
        return true;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean activateAccount(String email, String otp) {
        User user = userDao.getByEmail(email);
        if (user != null && otp.equals(user.getOtpCode())) {
            user.setStatus(1);
            user.setOtpCode(null);
            userDao.update(user);
            System.out.println("✅ Tài khoản đã kích hoạt: " + user.getUsername());
            return true;
        }
        System.out.println("❌ Mã OTP không đúng cho email: " + email);
        return false;
    }

    @Override
    public void saveOTP(String email, String otp) {
        User user = userDao.getByEmail(email);
        if (user != null) {
            user.setOtpCode(otp);
            userDao.update(user);
        }
    }

    @Override
    public boolean sendOTPForgotPassword(String email) {
        User user = userDao.getByEmail(email);
        if (user == null) {
            System.out.println("❌ Email không tồn tại: " + email);
            return false;
        }
        
        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
        System.out.println("📧 OTP quên mật khẩu cho " + email + ": " + otp);
        
        user.setOtpCode(otp);
        userDao.update(user);
        
        String subject = "🔐 Mã OTP đặt lại mật khẩu";
        String message = "Mã OTP của bạn là: " + otp + "\nMã có hiệu lực trong 5 phút.";
        EmailUtil.sendEmail(email, subject, message);
        
        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDao.getByEmail(email);
        if (user == null) {
            System.out.println("❌ Email không tồn tại: " + email);
            return false;
        }
        
        if (otp.equals(user.getOtpCode())) {
            userDao.updatePassword(email, newPassword);
            System.out.println("✅ Đặt lại mật khẩu thành công cho: " + email);
            return true;
        }
        
        System.out.println("❌ OTP không đúng cho email: " + email);
        return false;
    }
    
    @Override
    public void update(User user) {
        userDao.update(user);
    }

    // 🔥 THÊM PHƯƠNG THỨC NÀY
    @Override
    public User updateProfile(User user) {
        User existingUser = userDao.get(user.getUsername());
        if (existingUser == null) {
            return null;
        }
        
        if (user.getFullname() != null && !user.getFullname().isEmpty()) {
            existingUser.setFullname(user.getFullname());
        }
        if (user.getPhone() != null) {
            existingUser.setPhone(user.getPhone());
        }
        if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
            existingUser.setAvatar(user.getAvatar());
        }
        
        userDao.updateProfile(existingUser);
        return existingUser;
    }
}