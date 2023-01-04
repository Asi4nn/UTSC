public class Pikachu implements AlienAnimal, Tradable{
    private double humanPrice;
    private double alienPrice;

    public Pikachu (double humanPrice, double alienPrice) {
        this.humanPrice = humanPrice;
        this.alienPrice = alienPrice;
    }

    @Override
    public String sound() {
        return "pika pika";
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
