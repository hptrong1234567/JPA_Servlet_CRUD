package vn.iotstar.entity;

import java.io.Serializable;
import java.sql.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "[User]")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "username", columnDefinition = "NVARCHAR(50) NOT NULL UNIQUE")
    private String username;

    @Column(name = "password", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String password;

    @Column(name = "fullname", columnDefinition = "NVARCHAR(100) NOT NULL")
    private String fullname;

    @Column(name = "email", columnDefinition = "NVARCHAR(100) NOT NULL UNIQUE")
    private String email;

    @Column(name = "phone", columnDefinition = "NVARCHAR(20) NULL")
    private String phone;

    @Column(name = "roleid")
    private int roleid;

    @Column(name = "createdDate")
    private Date createdDate;

    public User() {
        super();
    }

    public User(String username, String password, String fullname, String email, String phone, int roleid) {
        super();
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.roleid = roleid;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}