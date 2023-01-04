import java.util.List;

public class HumanTrader extends Trader {

    public HumanTrader (double money, List<Tradable> inventory, boolean bilingual) {
        super(money, inventory, bilingual);
    }

    @Override
    public boolean isHuman() {
        return true;
    }
}