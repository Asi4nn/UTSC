public class FruitStand {

    public static void main(String[] args) {

        Fruit f1 = new Fruit("New Fruit");
        Fruit f2 = new Grape();
        Fruit f3 = new Pear();
        Grape f4 = (Grape)f2;
        Fruit f5 = f2; //(Fruit)f2;
        Pear f6 = new Pear();

//        System.out.println(f1); // This is a New Fruit (e)
//        System.out.println(f2); // Grapes are fruits. (c)
//        System.out.println(f3); // Pears are fruits. (c)
//        System.out.println(f4); // Grapes are fruits. (e)
//        System.out.println(f5); // Grapes are fruits. (c)
//        System.out.println(f6); // Pears are fruits. (e)
//
//        System.out.println(f1.name); // New Fruit (b)
//        System.out.println(f2.name); // Fruit (a&b - last constructor executed was Fruit)
//        System.out.println(f3.name); // Fruit (a&b - last constructor executed was Fruit)
//        System.out.println(f4.name); // Grape (b)
//        System.out.println(f5.name); // Fruit (a&b - last constructor executed was Fruit)
//        System.out.println(f6.name); // Pear (b)
//
//        System.out.println(f1.getName()); // New Fruit (b)
//        System.out.println(f2.getName()); // Grape (c)
//        System.out.println(f3.getName()); // Pear (c)
//        System.out.println(f4.getName()); // Grape (c)
//        System.out.println(f5.getName()); // Grape (c)
//        System.out.println(f6.getName()); // Pear (c)
//
//
//        System.out.println(f1.salesCat); // produce (f)
//        System.out.println(f2.salesCat); // produce (b)
//        System.out.println(f3.salesCat); // produce (b)
//        System.out.println(f4.salesCat); // individual produce (f)
//        System.out.println(f5.salesCat); // produce (f)
//        System.out.println(f6.salesCat); // individual produce (f)
//
//        System.out.println(f1.getSalesCat()); // produce (f)
//        System.out.println(f2.getSalesCat()); // produce (c)
//        System.out.println(f3.getSalesCat()); // produce (c)
//        System.out.println(f4.getSalesCat()); // individual produce (f)
//        System.out.println(f5.getSalesCat()); // produce (f)
//        System.out.println(f6.getSalesCat()); // individual produce (f)
//
//        System.out.println(f1.getIsForSale()); // Error: DNE (f)
//        System.out.println(f2.getIsForSale()); // Error: DNE (c)
//        System.out.println(f3.getIsForSale()); // Error: DNE (c)
//        System.out.println(f4.getIsForSale()); // true (f)
//        System.out.println(f5.getIsForSale()); // Error: DNE (c)
//        System.out.println(f6.getIsForSale()); // true (f)
//
//        System.out.println(f1.numFruit); // 4 (f)
//        System.out.println(f2.numFruit); // 4 (f - sharing)
//        System.out.println(f3.numFruit); // 4 (f - sharing)
//        System.out.println(f4.numFruit); // 4 (f - casting rule)?
//        System.out.println(f5.numFruit); // 4 (f - sharing)
//        System.out.println(f6.numFruit); // 4 (f - casting rule)?
//
//        f1.whatIsThis(); // This is a fruit (f)
//        f2.whatIsThis(); // This is a fruit (a)
//        f3.whatIsThis(); // This is a fruit (a)
//        f4.whatIsThis(); // This is a fruit (a)
//        f5.whatIsThis(); // This is a fruit (a)
//        f6.whatIsThis(); // This is a fruit (a)
//
//        System.out.println(((Grape) f2).fruitSalad().getName()); // Pear (f)
//        System.out.println((f2.getName()).equals(f3.getName())); // false (c)
//        System.out.println(((Grape) f2).getIsForSale().equals(((Pear) f3).getIsForSale())); // Error (f - primitive)
//
//        int x = 2;
//        int y = 2;
//        Integer a = new Integer(2);
//        Integer b = new Integer(2);
//
//        System.out.println(x == y); // True because primitive values
//        System.out.println(a == b); // False because it looks at different address
//        System.out.println(a == x); // True because of the unboxing of a
//        System.out.println(a.equals(x)); // True; compares value that a refers to and autoboxes x
//        System.out.println(a.equals(b)); // True; compares the values they both refer to
//        System.out.println(x.equals(y)); // Error: x is primitive int
    }
}
