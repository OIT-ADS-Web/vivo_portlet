package vivo.shared.services;

import com.google.gwt.user.client.rpc.RemoteService;
import com.google.gwt.user.client.rpc.RemoteServiceRelativePath;
import vivo.shared.dto.VivoQueryDTO;

@RemoteServiceRelativePath("springGwtServices/vivoQueryService")
public interface VivoQueryService extends RemoteService {

    public VivoQueryDTO findVivoQuery(String userId);

    public void saveOrUpdateVivoQuery(String userId, String queryString) throws Exception;

    public void deleteVivoQuery(String userId) throws Exception;

}
