package vn.iotstar.service.impl;

import vn.iotstar.dao.impl.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;

public class UserServiceImpl implements IUserService {
    private UserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassword())) {
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
        User user = new User(username, password, fullname, email, phone, 2);
        userDao.insert(user);
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
}