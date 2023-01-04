import org.junit.*;

import static org.junit.Assert.*;

public class MomoTest {

    // the Momo constructor
    @Test(timeout = 50)
    public void testMomo() {
        Momo m = new Momo(8000);
        AlienAnimal a = new Momo(8000);
        Tradable t = new Momo(8000);
    }

    // test Momo methods
    @Test(timeout = 50)
    public void testMomoMethods() {
        Momo m = new Momo(8000);
        m.sound();
        assertEquals("incorrect human price\n", 80, m.getHumanPrice(), 0.01);
        assertEquals("incorrect alien price\n", 8000, m.getAlienPrice(), 0.01);
    }

}
