public class Sedan implements Vehicle, Tradable {
    private double humanPrice;
    private int speed;
    public Sedan (double price) {
        this.humanPrice = price;
        this.speed = 0;
    }

    @Override
    public void speedUp() {
        this.speed += 2;
    }

    @Override
    public void speedDown() {
        this.speed -= 2;
    }

    @Override
    public int getSpeed() {
        return this.speed;
    }

    @Override
    public double getHumanPrice() {
        return this.humanPrice;
    }

    @Override
    public double getAlienPrice() {
        return this.humanPrice * 50;
    }
}

