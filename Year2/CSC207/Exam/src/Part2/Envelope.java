package Part2;

public class Envelope extends Parcel {
    private PostageCalculator pc;

    public Envelope() {
        super();
    }

    public Envelope(PostageCalculator pc) {
        super();
        this.pc = pc;
    }
}

public class Box extends Parcel {
    private PostageCalculator pc;

    public Box() {
        super();
    }

    public Box(PostageCalculator pc) {
        super();
        this.pc = pc;
    }
}


public Parcel getParcel(String parcelType, String calculator) {
    PostageCalculator calc;
    if (calculator.equals("Canada")) {
        calc = new CanadianPostageCalculator();
    }
    else {
        calc = new AmericanPostageCalculator();
    }

    switch(parcelType) {
        case "Box":
            return new Box(calc);
        case "Envelope":
            return new Envelope(calc);
        default:
            return new Envelope(calc);
    }
}