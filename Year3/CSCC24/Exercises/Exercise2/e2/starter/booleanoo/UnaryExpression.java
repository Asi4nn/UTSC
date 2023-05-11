package booleanoo;

import booleanoo.operators.UnaryOperator;
import java.util.Map;

/**
 * A unary boolean expression.
 */
public abstract class UnaryExpression extends BooleanExpression {
  private UnaryOperator operator;
  private BooleanExpression operand;

  public UnaryExpression(UnaryOperator operator, BooleanExpression operand) {
    this.operand = operand;
    this.operator = operator;
  }

  protected final BooleanExpression getOperand() {
    return operand;
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) {
    return operator.apply(operand.evaluate(context));
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    if (operand instanceof Negation) {
      return ((Negation) operand).getOperand();
    }
    return this;
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(this.getClass())
        && ((UnaryExpression) other).operator.equals(operator)
        && ((UnaryExpression) other).operand.equals(operand);
  }

  @Override
  public String toString() {
    return String.format("(%s %s)", operator, operand.toString());
  }
}
