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

    @Column(name = "query", nullable = false, length = 30)
    private String vivoQueryString;

    public VivoQueryDTO() {
    }

    public VivoQueryDTO(int vivoQueryId) {
        this.vivoQueryId = vivoQueryId;
    }

    public VivoQueryDTO(long vivoQueryId, String userId, String vivoQueryString) {
        this.vivoQueryId = vivoQueryId;
        this.userId = userId;
        this.vivoQueryString = vivoQueryString;
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

    public String getVivoQueryString() {
        return vivoQueryString;
    }

    public void setVivoQueryString(String vivoQueryString) {
        this.vivoQueryString = vivoQueryString;
    }
}