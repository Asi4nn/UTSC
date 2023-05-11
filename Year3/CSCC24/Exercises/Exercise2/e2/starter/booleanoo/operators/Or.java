package booleanoo.operators;

import booleanoo.Constants;

/**
 * Binary operator Or used for disjunction.
 */
public class Or implements BinaryOperator {

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Or.class);
  }

  @Override
  public String toString() {
    return Constants.OR;
  }

  @Override
  public Boolean apply(Boolean left, Boolean right) {
    return left || right;
  }
}
