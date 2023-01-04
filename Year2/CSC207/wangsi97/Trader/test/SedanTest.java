import org.junit.*;

import static org.junit.Assert.*;

public class SedanTest {

    // the Sedan constructor
    @Test(timeout = 50)
    public void testSedan() {
        Sedan s = new Sedan(200);
        Vehicle v = new Sedan(200);
        Tradable t = new Sedan(200);
    }

    // test Sedan speed methods
    @Test(timeout = 50)
    public void testSedanSpeed() {
        Vehicle v = new Sedan(200);
        assertTrue("incorrect initial speed\n", v.getSpeed() == 0);
        v.speedUp();
        assertTrue("incorrect speed after speedUp() called\n", v.getSpeed() == 2);
        v.speedDown();
        v.speedDown();
        assertTrue("incorrect speed after speedDown() called twice\n", v.getSpeed() == -2);
    }

    // test Sedan price methods
    @Test(timeout = 50)
    public void testSedanPrice() {
        Tradable t = new Sedan(200);
        assertEquals("incorrect human price\n", 200, t.getHumanPrice(), 0.01);
        assertEquals("incorrect alien price\n", 10000, t.getAlienPrice(), 0.01);
    }

}