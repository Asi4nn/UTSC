//package forest;

public class Maple extends Tree {

    public boolean hasLeaves = false;
    public int numRings = 200;
    public static int numTrees;

    public Maple() {
        super(true);
        numTrees++;
    }

    public boolean getHasLeaves() {
        return hasLeaves;
    }

    public static int getNumTrees() {
        return numTrees;
    }

    public int getNumRings() {
        return numRings;
    }

    public void grow() {
        System.out.println("This Maple tree is growing.");
    }

    public String toString() {
        return "This is Maple tree.";
    }

    public boolean equals(Maple m){
        System.out.println("Used Maple equals");
        return true;
    }

}
