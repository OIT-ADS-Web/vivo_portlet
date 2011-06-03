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

    public VivoQueryDTO findVivoQuery(long vivoQueryId) {
        return vivoQueryDAO.findById(vivoQueryId);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void saveVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception {
        VivoQueryDTO vivoQueryDTO = vivoQueryDAO.findById(vivoQueryId);
        if (vivoQueryDTO == null) {
            vivoQueryDTO = new VivoQueryDTO(vivoQueryId, userId, queryString);
            vivoQueryDAO.persist(vivoQueryDTO);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void updateVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception {
        VivoQueryDTO vivoQueryDTO = vivoQueryDAO.findById(vivoQueryId);
        if (vivoQueryDTO != null) {
            vivoQueryDTO.setUserId(userId);
            vivoQueryDTO.setVivoQueryString(queryString);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void deleteVivoQuery(long vivoQueryId) throws Exception {
        VivoQueryDTO vivoQueryDTO = vivoQueryDAO.findById(vivoQueryId);
        if (vivoQueryDTO != null) {
            vivoQueryDAO.remove(vivoQueryDTO);
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void saveOrUpdateVivoQuery(long vivoQueryId, String userId, String queryString) throws Exception {
        VivoQueryDTO vivoQueryDTO = new VivoQueryDTO(vivoQueryId, userId, queryString);
        vivoQueryDAO.merge(vivoQueryDTO);
    }

}
