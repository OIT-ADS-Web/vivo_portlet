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
        VivoQueryDTO result = vivoQueryDAO.findByUserId(userId);
        if (result != null) {
            System.out.println("findVivoQuery(" + userId + ") returned history '" + result.getHistory() + "'");
        }
        else {
            System.out.println("findVivoQuery(" + userId + ") returned null");
        }
        return result;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void deleteVivoQuery(String userId) throws Exception {
        VivoQueryDTO result = vivoQueryDAO.findByUserId(userId);
        if (result != null) {
            System.out.println("deleting vivo query for userId '" + userId + "'");
            vivoQueryDAO.remove(result);
        }
        else {
            System.out.println("no vivo query to delete for userId '" + userId + "'");
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void saveOrUpdateVivoQuery(String userId, String history) throws Exception {
        System.out.println("Updating DB with userId '" + userId + "' history '" + history + "'");
        VivoQueryDTO vivoQueryDTO = findVivoQuery(userId);
        if(vivoQueryDTO == null) {
            vivoQueryDTO = new VivoQueryDTO(userId, history);
            vivoQueryDAO.persist(vivoQueryDTO);
        } else {
            vivoQueryDTO.setHistory(history);
            vivoQueryDAO.save(vivoQueryDTO);
        }
    }
}
