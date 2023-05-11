package booleanoo.operators;

/**
 * A unary boolean operator.
 */
public interface UnaryOperator extends BooleanOperator {
  Boolean apply(Boolean operand);
}
