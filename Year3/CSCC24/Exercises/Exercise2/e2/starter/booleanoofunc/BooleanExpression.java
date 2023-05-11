package booleanoofunc;

import java.util.Map;

/**
 * A boolean expression: the top of our hierarchy.
 */
public abstract class BooleanExpression {
  /**
   * Evaluate the boolean expression.
   *
   * @param context Variable assignments
   * @return Boolean value of evaluation
   */
  public abstract Boolean evaluate(Map<String, Boolean> context);

  /**
   * Simplifies the current boolean expression and all its child expressions.
   *
   * @param context Variable assignments
   * @return Simplified boolean expression
   */
  public abstract BooleanExpression simplifyOnce(Map<String, Boolean> context);

  public abstract boolean equals(Object other);

  public abstract String toString();

  /**
   * Simplify the boolean expression.
   *
   * @param context Variable assignments
   * @return Simplified boolean expression
   */
  public BooleanExpression simplify(Map<String, Boolean> context) {
    return simplifyOnce(context);
  }
}
