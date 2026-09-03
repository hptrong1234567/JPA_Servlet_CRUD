package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    boolean register(String username, String password, String fullname, String email, String phone);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    boolean activateAccount(String email, String otp);
    void saveOTP(String email, String otp);
    boolean sendOTPForgotPassword(String email);
    boolean resetPassword(String email, String otp, String newPassword);
    void update(User user);
    User updateProfile(User user);
}