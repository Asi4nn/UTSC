public class MyHashing {
    private int seed = 100;

    public MyHashing() {}

    public MyHashing(int seed) {
        this.seed = seed;
    }

    public int hash(String seed) {
        char[] arr = seed.toCharArray();
        int sum = 0;
        for (char i: arr) {
            sum += i;
        }
        return sum;
    }

    public int hash(int seed) {
        int previous = this.seed;
        this.seed = seed;
        return previous;
    }

}
