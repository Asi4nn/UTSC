package Part1.Q7;

public class Q7 {
    public static void main(String[] args) {
        int a = 2;
        int b = 2;
        Integer w = new Integer(2);
        Integer x = new Integer(2);
        Integer y = x;
        Integer z = new Integer(w);

        System.out.println(a == x);     // T
        System.out.println(a == b);     // T
        System.out.println(w.equals(x));    // T
        System.out.println(x == y);     // T
        System.out.println(w == z);     // F
//        System.out.println(a.equals(x));
    }
}
