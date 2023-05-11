package poly;

/**
 * A Pair of X and Y.
 */
public class Pair<T, U> {
  private T head;
  private U tail;

  public Pair(T head, U tail) {
    this.head = head;
    this.tail = tail;
  }

  @Override
  public String toString() {
    return "(" + head.toString() + ", " + tail.toString() + ")";
  }
}
