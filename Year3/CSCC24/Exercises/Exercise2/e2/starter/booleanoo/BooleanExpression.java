package booleanoo;

import java.util.Map;

/**
 * A boolean expression: the top of our hierarchy.
 */
public abstract class BooleanExpression {
  public abstract Boolean evaluate(Map<String, Boolean> context);

  public abstract BooleanExpression simplifyOnce(Map<String, Boolean> context);

  public abstract boolean equals(Object other);

  public abstract String toString();

  public BooleanExpression simplify(Map<String, Boolean> context) {
    return simplifyOnce(context);
  }
}
