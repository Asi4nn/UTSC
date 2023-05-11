package booleanoo.operators;

/**
 * A binary boolean operator.
 */
public interface BinaryOperator extends BooleanOperator {
  Boolean apply(Boolean left, Boolean right);
}
