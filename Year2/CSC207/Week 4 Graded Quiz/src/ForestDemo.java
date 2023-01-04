public class ForestDemo {
    public static void main(String[] args) {
        Tree t1 = new Tree(false);
        Tree t2 = new Maple();
        Maple t3 = new Maple();
        Tree t4 = t3;
        Maple t5 = (Maple) t2;
        Tree t6 = t1;

        System.out.println(t4);
    }
}