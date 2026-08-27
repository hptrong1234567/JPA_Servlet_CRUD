package vn.iotstar.service.impl;

import java.util.List;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.impl.CategoryDao;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {
    private ICategoryDao categoryDao = new CategoryDao();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) {
        try {
            categoryDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public Category findByCategoryName(String name) {
        try {
            return categoryDao.findByCategoryName(name);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword);
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        return categoryDao.findAll(page, pageSize);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }
}