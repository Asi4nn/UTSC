import org.junit.*;

import static org.junit.Assert.*;

public class Tests {
    static int initial;

    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        initial = CandyPlayer.getMountainCandy();
    }

    // initial number of candies
    @Test(timeout = 50)
    public void testGetMountainCandy() {
        assertTrue("the initial number of candies in the Candy mountain should be in a range of 0~100\n", initial >= 0 && initial <= 100);
    }

    //the CandyPlayer constructor
    @Test(timeout = 50)
    public void testCandyPlayer() {
        new CandyPlayer(100);
    }

    // test getMyCandy()
    @Test(timeout = 50)
    public void testGetMyCandy() {
        CandyPlayer p = new CandyPlayer(100);
        assertEquals(100, p.getMyCandy());
    }

    // single player gets candies
    @Test(timeout = 50)
    public void testSinglePlayer1() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p = new CandyPlayer(100);
        assertTrue("play() should return true\n", p.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100 + give, p.getMyCandy());
    }

    // single player loses candies
    @Test(timeout = 50)
    public void testSinglePlayer2() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        CandyPlayer p = new CandyPlayer(100);
        assertTrue("play() should return true\n", p.play(100));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total + 100, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 0, p.getMyCandy());
    }

    // play() returning false
    @Test(timeout = 50)
    public void testSinglePlayer3() {
        int total = CandyPlayer.getMountainCandy();
        CandyPlayer p = new CandyPlayer(100);
        assertTrue("play() should return false\n", !p.play(101));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100, p.getMyCandy());
    }

    // multiple players
    @Test(timeout = 50)
    public void testMultiplePlayer1() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p = new CandyPlayer(100);
        CandyPlayer p2 = new CandyPlayer(200);

        assertTrue("play() should return true\n", p.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100 + give, p.getMyCandy());

        total = CandyPlayer.getMountainCandy();
        give = total / 3;
        assertTrue("play() should return true\n", p2.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 200 + give, p2.getMyCandy());
    }

    // setTurn()
    @Test
    public void testSetTurn() {
        CandyPlayer.setTurn(5);
        assertEquals(5, CandyPlayer.getTurn());
    }

    // setNumberOfPlayers()
    @Test
    public void testSetNumberOfPlayers() {
        CandyPlayer.setNumberOfPlayers(3);
        assertEquals(3, CandyPlayer.getNumberOfPlayers());
    }

    // single player
    @Test
    public void testSinglePlayer() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p1 = new CandyPlayer(100);

        assertTrue("play() should return true\n", p1.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100 + give, p1.getMyCandy());
        assertEquals("single player always gets its turn\n", 0, CandyPlayer.getTurn());
        assertTrue("play() should return true\n", p1.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - 2 * give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100 + 2 * give, p1.getMyCandy());
    }

    // multiple players
    @Test
    public void testMultiplePlayers() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p1 = new CandyPlayer(100);
        CandyPlayer p2 = new CandyPlayer(200);

        assertTrue("play() should return true if this CandyPlayer has its turn\n", p1.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 100 + give, p1.getMyCandy());
        assertEquals("turn is not updated properly\n", 1, CandyPlayer.getTurn());
        assertTrue("play() should return true if this CandyPlayer has its turn\n", p2.play(give));
        assertEquals("the number of candies in the mountain is not updated correctly\n", total - 2 * give, CandyPlayer.getMountainCandy());
        assertEquals("the number of candies of the player is not updated correctly\n", 200 + give, p2.getMyCandy());
        assertEquals("turn is not updated properly\n", 0, CandyPlayer.getTurn());
    }

    // multiple players
    @Test
    public void testMultiplePlayers2() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p1 = new CandyPlayer(100);
        CandyPlayer p2 = new CandyPlayer(200);

        assertTrue("play() should return true if this CandyPlayer has its turn\n", p1.play(give));
        assertTrue("play() should return false if this CandyPlayer doesn't have its turn\n", !p1.play(give));
        assertEquals(1, CandyPlayer.getTurn());
    }

    // multiple players
    @Test
    public void testMultiplePlayers3() {
        CandyPlayer.setTurn(0);
        CandyPlayer.setNumberOfPlayers(0);
        int total = CandyPlayer.getMountainCandy();
        int give = total / 3;
        CandyPlayer p1 = new CandyPlayer(100);
        CandyPlayer p2 = new CandyPlayer(200);

        assertTrue("play() should return false if the input is greater than the number of candies of this CandyPlayer\n", !p1.play(200));
        assertEquals("turn is not updated properly\n", 1, CandyPlayer.getTurn());
        assertTrue("play() should return true if this CandyPlayer has its turn\n", !p1.play(give));
        assertEquals("turn is not updated properly\n", 1, CandyPlayer.getTurn());
    }

}
