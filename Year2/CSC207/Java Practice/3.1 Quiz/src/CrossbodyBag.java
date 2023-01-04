public class CrossbodyBag extends Bag {
    private int straps;

    public CrossbodyBag(String color, int capacity, int straps) {
        super(color, capacity);
        this.straps = straps;
    }

    public int getStraps() {
        return straps;
    }

    @Override
    public void enhance() {
        super.update(2);
    }
}
