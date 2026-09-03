package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int id);
    Product findById(int id);
    List<Product> findAll();
    List<Product> findNewest(int limit);
    List<Product> findByCategory(int cateId);
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> searchByName(String keyword);
}