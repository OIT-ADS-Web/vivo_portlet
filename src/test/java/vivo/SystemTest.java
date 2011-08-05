package vivo;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import vivo.shared.dto.VivoQueryDTO;
import vivo.shared.services.VivoQueryService;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;

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
        printDump("Before any DB operations");
        assertTrue("There should be nothing coming back from DB before history is created", vivoQueryServiceImpl.findVivoQuery(userId) == null);
        vivoQueryServiceImpl.saveOrUpdateVivoQuery(userId, sampleHistory);
        printDump("After setting userId=" + userId + " history=" + sampleHistory);
        VivoQueryDTO dto = vivoQueryServiceImpl.findVivoQuery(userId);
        assertNotNull("Didn't return history", dto);
        assertEquals("Didn't return history expected.", sampleHistory, dto.getHistory());
        vivoQueryServiceImpl.saveOrUpdateVivoQuery(userId, sampleHistory2);
        printDump("After setting userId=" + userId + " history=" + sampleHistory2);
        assertEquals("Didn't return history2 expected.", sampleHistory2, vivoQueryServiceImpl.findVivoQuery(userId).getHistory());
        vivoQueryServiceImpl.deleteVivoQuery(userId);
        assertTrue("After deletion, there should be nothing coming back from DB", vivoQueryServiceImpl.findVivoQuery(userId) == null);
        printDump("After removing userId=" + userId);
    }

    public static void printDump(String label) throws Throwable {
        System.out.println("------------------------------------");
        System.out.println("====================================");
        System.out.println("DATABASE DUMP " + label);
        System.out.println("====================================");
        System.out.println("------------------------------------");
        org.h2.tools.Script.main(new String[]{"-url", "jdbc:h2:mem:vivoportletdb", "-user", "sa", "-password", ""});

        FileInputStream fis = null;
        try {
            fis = new FileInputStream("backup.sql");
            DataInputStream in = new DataInputStream(fis);
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            String strLine;
            while ((strLine = br.readLine()) != null) {
                System.out.println(strLine);
            }
            in.close();
        } catch (Throwable t1) {//Catch exception if any
            t1.printStackTrace();
            try {
                fis.close();
            }
            catch(Throwable t2) {
                t2.printStackTrace();
            }
        }
    }
}
