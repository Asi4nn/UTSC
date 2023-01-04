package Part1.Q1;

public class Two extends One {

    int value = 2;

    @Override
    public int getValue() {
        return value;
    }

    void fun(Two two) {
        System.out.println(two.getValue());
    }
}