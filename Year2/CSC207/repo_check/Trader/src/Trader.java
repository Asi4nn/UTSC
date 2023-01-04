import java.util.ArrayList;
import java.util.List;

public abstract class Trader {
    private List<Tradable> inventory;
    private List<Tradable> wishlist;
    private double money;
    private boolean bilingual;

    public Trader (double money, List<Tradable> inventory, boolean bilingual) {
        this.money = money;
        this.inventory = inventory;
        this.bilingual = bilingual;
        this.wishlist = new ArrayList<Tradable>();
    }

    public List<Tradable> getWishlist() {
        return this.wishlist;
    }

    public double getMoney() {
        return this.money;
    }

    public List<Tradable> getInventory() {
        return this.inventory;
    }

    public abstract boolean isHuman();

    public void addToWishlist (Tradable wish) {
        this.wishlist.add(wish);
    }

    public boolean sellTo(Trader buyer) {
        boolean success = false;
        if (this.isHuman() == buyer.isHuman() || this.bilingual || buyer.bilingual) {
            success = true;
            List<Tradable> removal = new ArrayList<Tradable>();
            System.out.println(buyer.getWishlist());
            System.out.println(this.getInventory());
            for (Tradable item: this.getInventory()) {
                if (buyer.getWishlist().contains(item)) {
                    if (buyer.isHuman() && buyer.getMoney() >= item.getHumanPrice()) {
                        if (this.isHuman()) {
                            this.money += item.getHumanPrice();
                        }
                        else {
                            this.money += item.getAlienPrice();
                        }
                        buyer.money -= item.getHumanPrice();
                        buyer.wishlist.remove(item);
                        buyer.inventory.add(item);
                        removal.add(item);
                    }
                    else if (!buyer.isHuman() && buyer.money >= item.getAlienPrice()) {
                        if (this.isHuman()) {
                            this.money += item.getHumanPrice();
                        }
                        else {
                            this.money += item.getAlienPrice();
                        }
                        buyer.money -= item.getAlienPrice();
                        buyer.wishlist.remove(item);
                        buyer.inventory.add(item);
                        removal.add(item);
                    }
                }
            }
            for (Tradable item : removal) {
                this.inventory.remove(item);
            }
        }
        return success;
    }

    public boolean buyFrom(Trader seller) {
        return seller.sellTo(this);
    }

}