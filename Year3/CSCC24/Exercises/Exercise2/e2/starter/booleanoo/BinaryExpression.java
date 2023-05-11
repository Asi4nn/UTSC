package booleanoo;

import booleanoo.operators.BinaryOperator;
import java.util.Map;

/**
 * A binary boolean expression.
 */
public abstract class BinaryExpression extends BooleanExpression {
  private BinaryOperator operator;
  private BooleanExpression left;
  private BooleanExpression right;

  /**
   * A binary boolean expression.
   *
   * @param operator Binary operator to apply to left and right
   * @param left     Left operand
   * @param right    Right operand
   */
  public BinaryExpression(BinaryOperator operator, BooleanExpression left,
                          BooleanExpression right) {
    this.operator = operator;
    this.left = left;
    this.right = right;
  }

  protected final BooleanExpression getLeft() {
    return left;
  }

  protected final BooleanExpression getRight() {
    return right;
  }

  protected final BinaryOperator getOperator() {
    return operator;
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) {
    return operator.apply(left.evaluate(context), right.evaluate(context));
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(this.getClass())
        && ((BinaryExpression) other).operator.equals(operator)
        && ((BinaryExpression) other).left.equals(left)
        && ((BinaryExpression) other).right.equals(right);
  }

  @Override
  public String toString() {
    return String.format("(%s %s %s)", left, operator, right);
  }
}
