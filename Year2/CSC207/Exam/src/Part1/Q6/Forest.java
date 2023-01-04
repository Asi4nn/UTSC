package Part1.Q6;

public class Forest {
    String location;

    public Forest(int numTrees, String location) {
        this.location = location;
        createTrees(numTrees);
    }

    public void createTrees(int numTrees) {
        return;
    }

    public void plant(Maple tree) {
        return;
    }

    public static void main(String[] args) {
        Tree t = new Tree(20);
        Tree x = new Maple(30);
        Maple m = new Maple(40);
        int z = m.getNumRings();
        x.grow();
        m.grow();
        Forest forest = new Forest(10, "High Park");
//        forest.plant(x);      // this is the first compile error because you try to pass in a Tree instead of a required Maple
        forest.createTrees(3);
//        boolean b = t.getHasSap();
    }
}
