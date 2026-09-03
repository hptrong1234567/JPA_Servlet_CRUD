package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();
    List<Product> findNewest(int limit);
    List<Product> findByCategory(int cateId);
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> searchByName(String keyword);
}