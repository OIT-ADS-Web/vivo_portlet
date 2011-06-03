package vivo.server.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vivo.shared.dto.VivoQueryDTO;

import javax.annotation.PostConstruct;
import javax.persistence.EntityManagerFactory;


@Repository("vivoDAO")
public class VivoQueryDAO extends JpaDAO<Long, VivoQueryDTO> {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    @PostConstruct
    public void init() {
        super.setEntityManagerFactory(entityManagerFactory);
    }
}