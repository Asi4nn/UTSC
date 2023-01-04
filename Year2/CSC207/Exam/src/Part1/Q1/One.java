package Part1.Q1;

public class One {

    int value = 1;

    public void fun(One one) {
        System.out.println("one fun is called");
        System.out.println(one.getValue());
    }

    public int getValue() {
        return value;
    }

    public static void main(String[] args) {
        One num = new Two();
        Two arg = new Two();
        num.fun(arg);

    }
}
