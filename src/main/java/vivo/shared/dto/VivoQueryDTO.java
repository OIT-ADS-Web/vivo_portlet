package vivo.shared.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "VIVO_QUERY")
public class VivoQueryDTO implements java.io.Serializable {

    private static final long serialVersionUID = 2398892972397428398L;

    @Id
    @Column(name = "vivo_query_id")
    private long vivoQueryId;

    @Column(name = "user_id", nullable = false, length = 30)
    private String userId;

    @Column(name = "history", nullable = false, length = 30)
    private String history;

    public VivoQueryDTO() {
    }

    public VivoQueryDTO(int vivoQueryId) {
        this.vivoQueryId = vivoQueryId;
    }

    public VivoQueryDTO(long vivoQueryId, String userId, String history) {
        this.vivoQueryId = vivoQueryId;
        this.userId = userId;
        this.history = history;
    }

    public long getVivoQueryId() {
        return vivoQueryId;
    }

    public void setVivoQueryId(long vivoQueryId) {
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