import org.junit.*;

import static org.junit.Assert.*;

public class ZealotTest {

    // the Zealot constructor
    @Test(timeout = 50)
    public void testZealot() {
        Zealot z = new Zealot();
        AlienAnimal a = new Zealot();
    }

    // test Zealot methods
    @Test(timeout = 50)
    public void testZealotMethods() {
        Zealot z = new Zealot();
        z.sound();
    }


}
