import org.junit.*;

import static org.junit.Assert.*;

public class PikachuTest {

    // the Pikachu constructor
    @Test(timeout = 50)
    public void testPikachu() {
        Pikachu p = new Pikachu(100, 8000);
        AlienAnimal a = new Pikachu(100, 8000);
        Tradable t = new Pikachu(100, 8000);
    }

    // test Pikachu methods
    @Test(timeout = 50)
    public void testPikachuMethods() {
        Pikachu p = new Pikachu(100, 8000);
        p.sound();
        assertEquals("incorrect human price\n", 100, p.getHumanPrice(), 0.01);
        assertEquals("incorrect alien price\n", 8000, p.getAlienPrice(), 0.01);
    }

}
