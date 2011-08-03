package vivo.server.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import vivo.server.dao.VivoQueryDAO;
import vivo.shared.dto.VivoQueryDTO;
import vivo.shared.services.VivoQueryService;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.util.List;

@Service("vivoQueryService")
public class VivoQueryServiceImpl implements VivoQueryService {

    @Autowired
    private VivoQueryDAO vivoQueryDAO;

    @PostConstruct
    public void init() throws Exception {
    }

    @PreDestroy
    public void destroy() {
    }

    public VivoQueryDTO findVivoQuery(String userId) {
        VivoQueryDTO result = null;
        List<VivoQueryDTO> results = vivoQueryDAO.findByUserId(userId);
        if (results != null && results.size()>0) {
            result = results.get(0);
        }
        return result;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void deleteVivoQuery(String userId) throws Exception {
        List<VivoQueryDTO> results = vivoQueryDAO.findByUserId(userId);
        if (results != null) {
            for (int i=0; i<results.size(); i++) {
                vivoQueryDAO.remove(results.get(i));
            }
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void saveOrUpdateVivoQuery(String userId, String history) throws Exception {
        VivoQueryDTO vivoQueryDTO = new VivoQueryDTO(userId, history);
        vivoQueryDAO.merge(vivoQueryDTO);
    }

}
