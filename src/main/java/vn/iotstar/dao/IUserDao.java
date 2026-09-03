package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    void insert(User user);
    User get(String username);
    User getByEmail(String email);
    void update(User user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    void updatePassword(String email, String newPassword);
    void updateProfile(User user);
}