package vn.iotstar.test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;

public class TestJPA {
    public static void main(String[] args) {
        System.out.println("🔄 Đang kiểm tra kết nối JPA...");
        
        try {
            // Lấy EntityManager từ JpaConfig
            EntityManager em = JpaConfig.getEntityManager();
            
            // Bắt đầu transaction
            EntityTransaction trans = em.getTransaction();
            
            // 1. TẠO CATEGORY MỚI
            System.out.println("📝 Đang thêm danh mục mới...");
            
            Category category = new Category();
            category.setCateName("Điện thoại thông minh");
            category.setIcons("smartphone.jpg");
            category.setStatus(1);
            
            trans.begin();
            em.persist(category);
            trans.commit();
            
            System.out.println("✅ Đã thêm category thành công! ID: " + category.getCateId());
            
            // 2. LẤY TẤT CẢ DANH MỤC
            System.out.println("📊 Danh sách tất cả danh mục:");
            
            TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
            java.util.List<Category> categories = query.getResultList();
            
            System.out.println("📊 Tổng số danh mục: " + categories.size());
            
            for (Category c : categories) {
                System.out.println("   - ID: " + c.getCateId() + ", Tên: " + c.getCateName() + ", Trạng thái: " + (c.getStatus() == 1 ? "Hoạt động" : "Khóa"));
            }
            
            // 3. KIỂM TRA LẤY THEO ID
            System.out.println("🔍 Kiểm tra lấy danh mục theo ID: " + category.getCateId());
            Category foundCategory = em.find(Category.class, category.getCateId());
            if (foundCategory != null) {
                System.out.println("   ✅ Tìm thấy: " + foundCategory.getCateName());
            }
            
            // Đóng EntityManager
            em.close();
            JpaConfig.close();
            
            System.out.println("✅ Test JPA thành công!");
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi kiểm tra JPA:");
            e.printStackTrace();
        }
    }
}