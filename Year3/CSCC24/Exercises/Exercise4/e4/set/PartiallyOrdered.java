package set;

/**
 * Things that have a parital order.
 */
public interface PartiallyOrdered<T> extends Eq<T> {
  default PartialOrdering pcompare(T other) {
    if (lt(other)) {
      return PartialOrdering.LT;
    }
    if (gt(other)) {
      return PartialOrdering.GT;
    }
    if (eq(other)) {
      return PartialOrdering.EQ;
    }
    if (inc(other)) {
      return PartialOrdering.INC;
    }

    return null;
  }

  default boolean eq(T other) {
    return pcompare(other) == PartialOrdering.EQ;
  }

  default boolean lt(T other) {
    return pcompare(other) == PartialOrdering.LT;
  }

  default boolean gt(T other) {
    return pcompare(other) == PartialOrdering.GT;
  }

  default boolean lte(T other) {
    return lt(other) || pcompare(other) == PartialOrdering.EQ;
  }

  default boolean gte(T other) {
    return gt(other) || pcompare(other) == PartialOrdering.EQ;
  }

  default boolean inc(T other) {
    return pcompare(other) == PartialOrdering.INC;
  }
}
