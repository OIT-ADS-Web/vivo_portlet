package vivo.shared.dto;

import vivo.VivoConstants;

import javax.persistence.*;

@Entity
@Table(name = "VIVO_QUERY")
@SequenceGenerator(allocationSize = 1, name = "S_vivo_query_id", sequenceName = "S_vivo_query_id")
public class VivoQueryDTO implements java.io.Serializable {

    private static final long serialVersionUID = 2398892972397428398L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "S_vivo_query_id")
    @Column(unique=true, nullable=false, name = "vivo_query_id")
    private long vivoQueryId;

    // allow null user_id. is needed to store data for testing/development in html outside of the portal (for now)
    @Column(unique=true, name = "user_id", nullable=true, length = 512)
    private String userId;

    @Column(name = "history", nullable = true, length = VivoConstants.MAX_HISTORY_LENGTH)
    private String history;

    public VivoQueryDTO() {
    }

    public VivoQueryDTO(String userId, String history) {
        this.userId = userId;
        this.history = history;
    }

    public long getVivoQueryId() {
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