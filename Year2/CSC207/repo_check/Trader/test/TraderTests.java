import org.junit.*;
import static org.junit.Assert.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

public class TraderTests {

    // the AlienTrader constructor
    @Test(timeout=50)
    public void testAlienTrader() {
        Trader trader = new AlienTrader(10000, new ArrayList<Tradable>(), false);
    }

    // the HumanTrader constructor
    @Test(timeout=50)
    public void testHumanTrader() {
        Trader trader = new HumanTrader(10000, new ArrayList<Tradable>(), true);
    }

    // test isHuman()
    @Test(timeout=50)
    public void testIsHuman() {
        Trader alien = new AlienTrader(10000, new ArrayList<Tradable>(), false);
        Trader human = new HumanTrader(10000, new ArrayList<Tradable>(), true);

        assertTrue("AlienTrader is not human\n", !alien.isHuman());
        assertTrue("HumanTrader is human\n", human.isHuman());
    }

    // test addToWishlist()
    @Test(timeout=50)
    public void testAddToWishlist() {
        Trader alien = new AlienTrader(10000, new ArrayList<Tradable>(), false);
        Trader human = new HumanTrader(10000, new ArrayList<Tradable>(), true);
        Tradable t = new Sedan(200);

        alien.addToWishlist(t);
        human.addToWishlist(t);
        assertTrue("addToWishlist() fails for AlienTrader\n", alien.getWishlist().contains(t));
        assertTrue("addToWishlist() fails for HumanTrader\n", human.getWishlist().contains(t));
    }

    // sellTo(): same species, no common items
    @Test(timeout=50)
    public void testSellTo1() {
        Tradable s = new Sedan(200);
        Tradable m = new Momo(8000);
        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        List<Tradable> in2 = new ArrayList<>();
        in2.add(m);
        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new HumanTrader(10000, in2, true);

        assertTrue("trade should be made\n", h1.sellTo(h2));
        assertEquals("trader's money should be unchanged\n", 20000, h1.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", h1.getInventory().contains(s));
        assertTrue("trader's wish list should be unchanged\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money should be unchanged\n", 10000, h2.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", h2.getInventory().contains(m));
        assertTrue("trader's wish list should be unchanged\n", h2.getWishlist().isEmpty());
    }

    // sellTo(): same species, sells one item
    @Test(timeout=50)
    public void testSellTo2() {
        Tradable s = new Sedan(200);
        Tradable m = new Momo(8000);
        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        List<Tradable> in2 = new ArrayList<>();
        in2.add(m);
        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new HumanTrader(10000, in2, true);
        h2.addToWishlist(s);

        assertTrue("trade should be made\n", h1.sellTo(h2));
        assertEquals("trader's money is updated incorrectly\n", 20200, h1.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money is updated incorrectly\n", 9800, h2.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(s));
    }

    // sellTo(): same species, not enough momeny
    @Test(timeout=50)
    public void testSellTo3() {
        Tradable s = new Sedan(200);
        Tradable m = new Momo(8000);
        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        List<Tradable> in2 = new ArrayList<>();
        in2.add(m);
        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new HumanTrader(0, in2, true);
        h2.addToWishlist(s);

        assertTrue("trade should be made\n", h1.sellTo(h2));
        assertEquals("trader's money should be unchanged\n", 20000, h1.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", h1.getInventory().contains(s));
        assertTrue("trader's wish list should be unchanged\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money should be unchanged\n", 0, h2.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", !h2.getInventory().contains(s));
        assertTrue("trader's wish list should be unchanged\n", h2.getWishlist().contains(s));
    }

    // sellTo(): same species, sells multiple items
    @Test(timeout=50)
    public void testSellTo4() {
        Tradable s = new Sedan(200);
        Tradable m = new Motorcycle(100, 8000);
        Tradable mm = new Momo(8000000);
        Tradable mm2 = new Momo(70000);
        Tradable p = new Pikachu(100, 8000);

        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        in1.add(m);
        in1.add(mm);
        in1.add(mm2);
        in1.add(p);

        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new HumanTrader(10000, new ArrayList<Tradable>(), true);
        h2.addToWishlist(s);
        h2.addToWishlist(m);
        h2.addToWishlist(mm);
        h2.addToWishlist(p);

        assertTrue("trade should be made\n", h1.sellTo(h2));
        assertEquals("trader's money is updated incorrectly\n", 20400, h1.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(p));
        assertTrue("trader's wish list is updated incorrectly\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money is updated incorrectly\n", 9600, h2.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(p));

        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(m));
        assertTrue("trader's wish list is updated incorrectly\n", h2.getWishlist().contains(mm));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(mm2));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(p));
    }

    // sellTo(): different species, both are bilingual
    @Test(timeout=50)
    public void testSellTo5() {
        Tradable s = new Sedan(200);
        Tradable m = new Motorcycle(100, 8000);
        Tradable mm = new Momo(8000000);
        Tradable mm2 = new Momo(70000);
        Tradable p = new Pikachu(100, 8000);

        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        in1.add(m);
        in1.add(mm);
        in1.add(mm2);
        in1.add(p);


        Trader h1 = new HumanTrader(20000, in1, true);
        Trader h2 = new AlienTrader(1000000, new ArrayList<Tradable>(), true);
        h2.addToWishlist(s);
        h2.addToWishlist(m);
        h2.addToWishlist(mm);
        h2.addToWishlist(p);

        assertTrue("trade should be made\n", h1.sellTo(h2));
        assertEquals("trader's money is updated incorrectly\n", 20400, h1.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(p));
        assertTrue("trader's wish list is updated incorrectly\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money is updated incorrectly\n", 974000, h2.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(p));

        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(m));
        assertTrue("trader's wish list is updated incorrectly\n", h2.getWishlist().contains(mm));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(mm2));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(p));
    }

    // sellTo(): different species, both are not bilingual
    @Test(timeout=50)
    public void testSellTo6() {
        Tradable s = new Sedan(200);
        Tradable m = new Momo(8000);
        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        List<Tradable> in2 = new ArrayList<>();
        in2.add(m);
        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new AlienTrader(1000000, in2, false);
        h2.addToWishlist(s);

        assertTrue("trade should not be made\n", !h1.sellTo(h2));
        assertEquals("trader's money should be unchanged\n", 20000, h1.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", h1.getInventory().contains(s));
        assertTrue("trader's wish list should be unchanged\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money should be unchanged\n", 1000000, h2.getMoney(), 0.01);
        assertTrue("trader's inventory should be unchanged\n", h2.getInventory().contains(m));
        assertTrue("trader's inventory should be unchanged\n", !h2.getInventory().contains(s));
        assertTrue("trader's wish list should be unchanged\n", h2.getWishlist().contains(s));
    }

    // buyFrom()
    @Test(timeout=50)
    public void testBuyFrom1() {
        Tradable s = new Sedan(200);
        Tradable m = new Motorcycle(100, 8000);
        Tradable mm = new Momo(8000000);
        Tradable mm2 = new Momo(70000);
        Tradable p = new Pikachu(100, 8000);

        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        in1.add(m);
        in1.add(mm);
        in1.add(mm2);
        in1.add(p);

        Trader h1 = new HumanTrader(20000, in1, false);
        Trader h2 = new HumanTrader(10000, new ArrayList<Tradable>(), true);
        h2.addToWishlist(s);
        h2.addToWishlist(m);
        h2.addToWishlist(mm);
        h2.addToWishlist(p);

        assertTrue("trade should be made\n", h2.buyFrom(h1));
        assertEquals("trader's money is updated incorrectly\n", 20400, h1.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(p));
        assertTrue("trader's wish list is updated incorrectly\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money is updated incorrectly\n", 9600, h2.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(p));

        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(m));
        assertTrue("trader's wish list is updated incorrectly\n", h2.getWishlist().contains(mm));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(mm2));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(p));
    }

    // buyFrom()
    @Test(timeout=50)
    public void testBuyFrom2() {
        Tradable s = new Sedan(200);
        Tradable m = new Motorcycle(100, 8000);
        Tradable mm = new Momo(8000000);
        Tradable mm2 = new Momo(70000);
        Tradable p = new Pikachu(100, 8000);

        List<Tradable> in1 = new ArrayList<>();
        in1.add(s);
        in1.add(m);
        in1.add(mm);
        in1.add(mm2);
        in1.add(p);


        Trader h1 = new HumanTrader(20000, in1, true);
        Trader h2 = new AlienTrader(1000000, new ArrayList<Tradable>(), true);
        h2.addToWishlist(s);
        h2.addToWishlist(m);
        h2.addToWishlist(mm);
        h2.addToWishlist(p);

        assertTrue("trade should be made\n", h2.buyFrom(h1));
        assertEquals("trader's money is updated incorrectly\n", 20400, h1.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", h1.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", !h1.getInventory().contains(p));
        assertTrue("trader's wish list is updated incorrectly\n", h1.getWishlist().isEmpty());
        assertEquals("trader's money is updated incorrectly\n", 974000, h2.getMoney(), 0.01);
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(s));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(m));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm));
        assertTrue("trader's inventory is updated incorrectly\n", !h2.getInventory().contains(mm2));
        assertTrue("trader's inventory is updated incorrectly\n", h2.getInventory().contains(p));

        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(s));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(m));
        assertTrue("trader's wish list is updated incorrectly\n", h2.getWishlist().contains(mm));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(mm2));
        assertTrue("trader's wish list is updated incorrectly\n", !h2.getWishlist().contains(p));
    }
}
