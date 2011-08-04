package vivo.server.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vivo.shared.dto.VivoQueryDTO;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;


@Repository("vivoDAO")
public class VivoQueryDAO {

    @Autowired
    EntityManagerFactory entityManagerFactory;

    public void persist(VivoQueryDTO vivoQueryDTO) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.persist(vivoQueryDTO);
        em.getTransaction().commit();
    }

    public void remove(VivoQueryDTO vivoQueryDTO) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.remove(vivoQueryDTO);
        em.getTransaction().commit();
    }

    public VivoQueryDTO findByUserId(String userId) {
        VivoQueryDTO result = null;
        EntityManager em = entityManagerFactory.createEntityManager();
        List<VivoQueryDTO> list = em.createQuery("select q from " + VivoQueryDTO.class.getName() + " q where q.userId = :uid").setParameter("uid", userId).getResultList();
        if (list!=null && list.size()>0) {
            result = list.get(0);
        }
        return result;
    }
}