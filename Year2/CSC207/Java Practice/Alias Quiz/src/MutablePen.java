public class MutablePen implements Cloneable {
    private String color;

    public MutablePen(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public MutablePen clone() {
        MutablePen temp = new MutablePen(color);
        return temp;
    }


    public static void main(String[] args) {
        MutablePen pen = new MutablePen("Red");
        MutablePen pen1 = pen.clone();
        System.out.println(pen1.getColor());
    }
}
