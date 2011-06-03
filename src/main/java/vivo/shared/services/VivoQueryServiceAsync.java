package vivo.shared.services;

import com.google.gwt.user.client.rpc.AsyncCallback;
import vivo.shared.dto.VivoQueryDTO;

public interface VivoQueryServiceAsync {

    void deleteVivoQuery(long vivoQueryId, AsyncCallback<Void> callback);

    void findVivoQuery(long vivoQueryId, AsyncCallback<VivoQueryDTO> callback);

    void saveVivoQuery(long vivoQueryId, String userId, String queryString,
                       AsyncCallback<Void> callback);

    void saveOrUpdateVivoQuery(long vivoQueryId, String userId, String queryString,
                               AsyncCallback<Void> callback);

    void updateVivoQuery(long vivoQueryId, String userId, String queryString,
                         AsyncCallback<Void> callback);

}
