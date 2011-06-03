package vivo.shared.services;

import com.google.gwt.user.client.rpc.RemoteService;
import com.google.gwt.user.client.rpc.RemoteServiceRelativePath;
import vivo.shared.dto.VivoQueryDTO;

@RemoteServiceRelativePath("springGwtServices/vivoQueryService")
public interface VivoQueryService extends RemoteService {

    public VivoQueryDTO findVivoQuery(long vivoQueryId);

    public void saveVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception;

    public void updateVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception;

    public void saveOrUpdateVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception;

    public void deleteVivoQuery(long vivoQueryId) throws Exception;

}
