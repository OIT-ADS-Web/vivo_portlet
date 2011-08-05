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
        em.flush();
        em.getTransaction().commit();
    }

    public void save(VivoQueryDTO vivoQueryDTO) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.merge(vivoQueryDTO);
        em.flush();
        em.getTransaction().commit();
    }

    public void remove(VivoQueryDTO vivoQueryDTO) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        // remove reference, or you get: java.lang.IllegalArgumentException: Removing a detached instance vivo.shared.dto.VivoQueryDTO#1
        em.remove(em.getReference(VivoQueryDTO.class, vivoQueryDTO.getVivoQueryId()));
        em.flush();
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