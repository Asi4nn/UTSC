public class Momo implements AlienAnimal, Tradable{
    private double alienPrice;

    public Momo (double alienPrice) {
        this.alienPrice = alienPrice;
    }

    @Override
    public String sound() {
        return "momo momo";
    }

    @Override
    public double getHumanPrice() {
        return this.alienPrice / 100;
    }

    @Override
    public double getAlienPrice() {
        return this.alienPrice;
    }
}
