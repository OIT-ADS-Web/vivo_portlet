package vivo.server.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vivo.shared.dto.VivoQueryDTO;

import javax.annotation.PostConstruct;
import javax.persistence.EntityManagerFactory;
import java.util.List;


@Repository("vivoDAO")
public class VivoQueryDAO extends JpaDAO<Long, VivoQueryDTO> {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @PostConstruct
    public void init() {
        super.setEntityManagerFactory(entityManagerFactory);
    }

    public List<VivoQueryDTO> findByUserId(String userId) {
        return (List<VivoQueryDTO>)getJpaTemplate().find("select q from " + entityClass.getName() + " q where q.userId = ?", userId);
    }
}