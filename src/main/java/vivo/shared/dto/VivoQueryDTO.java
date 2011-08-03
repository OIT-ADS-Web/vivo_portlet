package vivo.shared.dto;

import javax.persistence.*;

@Entity
@Table(name = "VIVO_QUERY")
public class VivoQueryDTO implements java.io.Serializable {

    private static final long serialVersionUID = 2398892972397428398L;

    @Id
    @Column(unique=true, nullable=false, name = "vivo_query_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY) // or GenerationType.AUTO
    private Long vivoQueryId;

    // allow null user_id. is needed to store data for testing/development in html outside of the portal (for now)
    @Column(unique=true, name = "user_id", nullable=true, length = 30)
    private String userId;

    @Column(name = "history", nullable = true, length = 30)
    private String history;

    public VivoQueryDTO() {
    }

    public VivoQueryDTO(String userId, String history) {
        this.userId = userId;
        this.history = history;
    }

    public Long getVivoQueryId() {
        return vivoQueryId;
    }

    public void setVivoQueryId(Long vivoQueryId) {
        this.vivoQueryId = vivoQueryId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getHistory() {
        return history;
    }

    public void setHistory(String history) {
        this.history = history;
    }
}