import org.junit.*;

import static org.junit.Assert.*;

public class Tests {
    MyStack<Integer> test;

    @Before
    public void setUp() {
        test = new MyStack<>(4);
    }

    @After
    public void tearDown() {
        test = null;
    }

    // pushShouldOverFlow
    @Test(expected = StackOverflowException.class)
    public void pushShouldOverFlow() throws Exception {
        test.push(1);
        assertEquals(1, test.stack.size());
        test.push(2);
        test.push(3);
        test.push(4);
        assertEquals(4, test.stack.size());
        test.push(5);
    }

    // pushShouldNotOverFlow
    @Test
    public void pushShouldNotOverFlow() throws Exception {
        test.push(1);
        assertEquals(1, test.stack.size());
        test.push(2);
        test.push(3);
        test.push(4);
        assertEquals(4, test.stack.size());
    }

    // testing pop
    @Test
    public void pop() throws Exception {
        test.push(1);
        test.push(2);
        assertEquals(new Integer(2), test.pop());
        assertEquals(new Integer(1), test.pop());
        assertEquals(new Integer(1), test.pop());
    }
}
