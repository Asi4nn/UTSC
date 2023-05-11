package booleanoofunc;


import booleanoo.operators.UnaryOperator;
import java.util.Map;
import java.util.function.BiFunction;

/**
 * A unary boolean expression.
 */
public abstract class UnaryExpression extends BooleanExpression {
  private UnaryOperator operator;
  private BooleanExpression operand;
  private BiFunction<BooleanExpression, Map<String, Boolean>, BooleanExpression> simplifier;

  /**
   * A unary boolean expression.
   *
   * @param operator   Unary operator to apply to operand
   * @param operand    Operand
   * @param simplifier Function to simplify unary expression
   */
  public UnaryExpression(UnaryOperator operator, BooleanExpression operand,
                         BiFunction<BooleanExpression, Map<String, Boolean>,
                             BooleanExpression> simplifier) {
    this.operator = operator;
    this.operand = operand;
    this.simplifier = simplifier;
  }

  public BooleanExpression getOperand() {
    return operand;
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) {
    return operator.apply(operand.evaluate(context));
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    return simplifier.apply(operand, context);
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(this.getClass())
        && ((UnaryExpression) other).operand.equals(operand);
  }

  public abstract String toStringOp();

  @Override
  public String toString() {
    return String.format("(%s %s)", toStringOp(), operand.toString());
  }
}
