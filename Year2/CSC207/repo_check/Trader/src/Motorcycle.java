public class Motorcycle implements Vehicle, Tradable{
    private double humanPrice;
    private double alienPrice;
    private int speed;

    public Motorcycle (double humanPrice, double alienPrice) {
        this.humanPrice = humanPrice;
        this.alienPrice = alienPrice;
        this.speed = 0;
    }

    @Override
    public void speedUp() {
        this.speed += 1;
    }

    @Override
    public void speedDown() {
        this.speed -= 1;
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
        return this.alienPrice;
    }
}
