package Part1.Q6;

public class Maple extends Tree {
    boolean hasSap;

    public Maple(int numRings) {
        super(numRings);
        hasSap = false;
    }

    @Override
    public void grow() {
        numRings++;
        hasSap = true;
    }

    public boolean getHasSap() {
        return hasSap;
    }
}
