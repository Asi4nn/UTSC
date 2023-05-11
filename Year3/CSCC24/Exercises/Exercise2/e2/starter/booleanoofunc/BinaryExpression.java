package booleanoofunc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.function.BinaryOperator;

/**
 * A binary boolean expression.
 */
public abstract class BinaryExpression extends BooleanExpression {
  private BinaryOperator<Boolean> operator;
  private BooleanExpression left;
  private BooleanExpression right;
  private BiFunction<List<BooleanExpression>, Map<String, Boolean>, BooleanExpression> simplifier;

  /**
   * A binary boolean expression.
   *
   * @param operator   Binary operator to apply to left and right
   * @param left       Left operand
   * @param right      Right operand
   * @param simplifier Function to simplify the binary expression
   */
  public BinaryExpression(BinaryOperator<Boolean> operator, BooleanExpression left,
                          BooleanExpression right, BiFunction<List<BooleanExpression>,
      Map<String, Boolean>, BooleanExpression> simplifier) {
    this.operator = operator;
    this.left = left;
    this.right = right;
    this.simplifier = simplifier;
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) {
    return operator.apply(left.evaluate(context), right.evaluate(context));
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    List<BooleanExpression> params = new ArrayList<>();
    params.add(left);
    params.add(right);
    return simplifier.apply(params, context);
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(this.getClass())
        && ((BinaryExpression) other).operator.equals(operator)
        && ((BinaryExpression) other).left.equals(left)
        && ((BinaryExpression) other).right.equals(right);
  }

  public abstract String toStringOp();

  @Override
  public String toString() {
    return String.format("(%s %s %s)", left, toStringOp(), right);
  }

  protected final BooleanExpression getLeft() {
    return left;
  }

  protected final BooleanExpression getRight() {
    return right;
  }
}
