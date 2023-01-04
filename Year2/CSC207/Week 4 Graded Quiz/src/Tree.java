//package forest;

public class Tree {

    public boolean hasLeaves;
    public int numRings = 100;
    public static int numTrees;

    public Tree(boolean hasLeaves) {
        this.hasLeaves = hasLeaves;
        numTrees++;
    }

    public boolean getHasLeaves() {
        return hasLeaves;
    }

    public static int getNumTrees() {
        return numTrees;
    }

    public void grow() {
        numRings++;
    }

    public int getNumRings() {
        return numRings;
    }

    public String toString() {
        return "This is a tree.";
    }

}
