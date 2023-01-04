import java.util.List;

public class AlienTrader extends Trader {

    public AlienTrader (double money, List<Tradable> inventory, boolean bilingual) {
        super(money, inventory, bilingual);
    }

    @Override
    public boolean isHuman() {
        return false;
    }
}