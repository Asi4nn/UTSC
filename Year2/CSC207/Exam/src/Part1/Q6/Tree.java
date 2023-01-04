package Part1.Q6;

public class Tree {
    int numRings;

    public Tree(int numRings) {
        this.numRings = numRings;
    }

    public void grow() {
        numRings++;
    }

    public int getNumRings() {
        return numRings;
    }
}
