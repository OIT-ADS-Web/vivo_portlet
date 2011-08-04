package vivo;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.Iterator;

import vivo.shared.dto.VivoQueryDTO;
import vivo.shared.services.VivoQueryService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"test-vivo.xml"})
public class SystemTest extends AbstractDependencyInjectionSpringContextTests {

    @Autowired
    private VivoQueryService vivoQueryServiceImpl;

    @After
    public void cleanUp() throws Throwable {
    }

    @Test
    public void testDbMethods() throws Throwable {
        String userId = "99999";
        String sampleHistory = "test|sample|query";
        String sampleHistory2 = "test|sample|query|bar";
        assertTrue("There should be nothing coming back from DB before history is created", vivoQueryServiceImpl.findVivoQuery(userId) == null);
        sleep();
        vivoQueryServiceImpl.saveOrUpdateVivoQuery(userId, sampleHistory);
        VivoQueryDTO dto = vivoQueryServiceImpl.findVivoQuery(userId);
        sleep();
        assertNotNull("Didn't return history", dto);
        sleep();
        assertEquals("Didn't return history expected.", sampleHistory, dto.getHistory());
        vivoQueryServiceImpl.saveOrUpdateVivoQuery(userId, sampleHistory2);
        assertEquals("Didn't return history2 expected.", sampleHistory2, vivoQueryServiceImpl.findVivoQuery(userId).getHistory());
        vivoQueryServiceImpl.deleteVivoQuery(userId);
        assertTrue("After deletion, there should be nothing coming back from DB", vivoQueryServiceImpl.findVivoQuery(userId) == null);
    }

    private void sleep() throws Throwable {
        Thread.sleep(500);
    }
}
