package vn.iotstar.entity;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateId;

    @Column(name = "cate_name", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String cateName;

    @Column(name = "icons", columnDefinition = "NVARCHAR(255) NULL")
    private String icons;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "category")
    private List<Video> videos;

    public Category() {
        super();
    }

    public Category(int cateId, String cateName, String icons, int status) {
        super();
        this.cateId = cateId;
        this.cateName = cateName;
        this.icons = icons;
        this.status = status;
    }

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getIcons() {
        return icons;
    }

    public void setIcons(String icons) {
        this.icons = icons;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }

    @Override
    public String toString() {
        return "Category [cateId=" + cateId + ", cateName=" + cateName + ", status=" + status + "]";
    }
}