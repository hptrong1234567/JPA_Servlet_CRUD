package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    void insert(User user);
    User get(String username);
    User getByEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}