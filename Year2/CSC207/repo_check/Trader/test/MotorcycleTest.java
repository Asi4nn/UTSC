import org.junit.*;

import static org.junit.Assert.*;

public class MotorcycleTest {

    // the Motorcycle constructor
    @Test(timeout = 50)
    public void testMotorcycle() {
        Motorcycle m = new Motorcycle(100, 8000);
        Vehicle v = new Motorcycle(100, 8000);
        Tradable t = new Motorcycle(100, 8000);
    }

    // test Motorcycle speed methods
    @Test(timeout = 50)
    public void testMotorSpeed() {
        Vehicle v = new Motorcycle(100, 8000);
        assertTrue("incorrect initial speed\n", v.getSpeed() == 0);
        v.speedUp();
        assertTrue("incorrect speed after speedUp() called\n", v.getSpeed() == 1);
        v.speedDown();
        v.speedDown();
        assertTrue("incorrect speed after speedDown() called twice\n", v.getSpeed() == -1);
    }

    // test Motorcycle price methods
    @Test(timeout = 50)
    public void testMotorPrice() {
        Tradable t = new Motorcycle(100, 8000);
        assertEquals("incorrect human price\n", 100, t.getHumanPrice(), 0.01);
        assertEquals("incorrect alien price\n", 8000, t.getAlienPrice(), 0.01);
    }


}
