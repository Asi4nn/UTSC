import java.util.Random;

public class CandyPlayer {
    private int numCandies;
    private int id;
    private static int totalCandy = (new Random()).nextInt(100);
    private static int turn;
    private static int players;
    
    public CandyPlayer (int numCandies) {
        this.numCandies = numCandies;
        this.id = players++;
    }

    public int getMyCandy() {
        return this.numCandies;
    }

    public static int getMountainCandy() {
        return totalCandy;
    }

    public static int getTurn() {
        return turn;
    }

    public static int getNumberOfPlayers() {
        return players;
    }

    public static void setTurn(int turn) {
        CandyPlayer.turn = turn;
    }

    public static void setNumberOfPlayers(int players) {
        CandyPlayer.players = players;
    }

    public boolean play(int candies) {
        boolean success = true;
        if (this.id != CandyPlayer.turn || candies > this.numCandies) {
            success = false;
        }
        if (this.id == CandyPlayer.turn) {
            CandyPlayer.turn++;
            if (CandyPlayer.turn > CandyPlayer.players - 1) {
                CandyPlayer.turn = 0;
            }
        }
        if (success) {
            if (2*getMountainCandy() >= candies) {
                this.numCandies += candies;
                CandyPlayer.totalCandy -= candies;
            }
            else {
                this.numCandies -= candies;
                CandyPlayer.totalCandy += candies;
            }
        }

        return success;
    }

}