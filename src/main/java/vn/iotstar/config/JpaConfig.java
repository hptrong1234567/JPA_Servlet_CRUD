package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaConfig {
    private static EntityManagerFactory factory;

    static {
        try {
            factory = Persistence.createEntityManagerFactory("jpa-hibernate-sqlserver");
            System.out.println("✅ JPA EntityManagerFactory initialized successfully!");
        } catch (Exception e) {
            System.err.println("❌ Failed to initialize JPA EntityManagerFactory!");
            e.printStackTrace();
        }
    }

    public static EntityManager getEntityManager() {
        if (factory == null) {
            throw new RuntimeException("EntityManagerFactory is null. Check your persistence.xml configuration.");
        }
        return factory.createEntityManager();
    }

    public static void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}