public abstract class Bag {
    private String color;
    private int capacity;
    private int numberOfContents;
    private String[] contents;

    public Bag (String color, int capacity) {
        this.color = color;
        this.capacity = capacity;
        this.numberOfContents = 0;
        this.contents = new String[capacity];
    }

    public String getColor() {
        return color;
    }

    public int getNumberOfContents() {
        return numberOfContents;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String addItem(String item) {
        if (numberOfContents == capacity) {
            return item;
        }

        for (int i = 0; i < contents.length; i++) {
            if (contents[i] == null) {
                contents[i] = item;
                numberOfContents++;
                return null;
            }
        }
    }

    public String popItem() {
        if (numberOfContents == 0) {
            return null;
        }

        for (int i = 0; i < contents.length; i++) {
            if (contents[i+1] == null) {
                String last = contents[i];
                contents[i] = null;
                numberOfContents--;
                return last;
            }
        }
    }

    public abstract void enhance();
}