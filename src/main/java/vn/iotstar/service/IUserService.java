package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    boolean register(String username, String password, String fullname, String email, String phone);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}