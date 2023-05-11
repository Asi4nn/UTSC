package set;


import java.util.Collection;
import java.util.Set;

/**
 * A partially ordered Set.
 */
public class PartiallyOrderedSet<E extends Show & Eq<E>>
    implements PartiallyOrdered<PartiallyOrderedSet<E>>, Show {
  Set<E> elements;

  public PartiallyOrderedSet(Collection<E> elts) {
    elements = Set.copyOf(elts);
  }

  @Override
  public PartialOrdering pcompare(PartiallyOrderedSet<E> other) {
    if (equals(other)) {
      return PartialOrdering.EQ;
    }
    if (subset(other)) {
      return PartialOrdering.LT;
    }
    if (other.subset(this)) {
      return PartialOrdering.GT;
    }
    return PartialOrdering.INC;
  }

  /**
   * If this Set is a subset of the other.
   *
   * @param other Set being compared to
   * @return boolean
   */
  private boolean subset(PartiallyOrderedSet<E> other) {
//    System.out.println(String.format("%s < %s %s", show(), other.show(), other.elements.containsAll(elements)));
    return elements.stream().allMatch(
        item -> other.elements.stream().map(x -> x.eq(item))
            .reduce(false, (x, y) -> x || y)
    );
  }

  /**
   * @return
   */
  private boolean equals(PartiallyOrderedSet<E> other) {
    return subset(other) && other.subset(this);
  }

  @Override
  public String show() {
    return "{" + String.join(",", elements.stream().map(Show::show).toList()) + "}";
  }
}
