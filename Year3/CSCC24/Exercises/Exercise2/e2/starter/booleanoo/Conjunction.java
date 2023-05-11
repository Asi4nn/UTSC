package booleanoo;

import booleanoo.operators.And;
import java.util.Map;

/**
 * A binary conjunction of BooleanExpression's.
 */
public class Conjunction extends BinaryExpression {
  public Conjunction(BooleanExpression left, BooleanExpression right) {
    super(new And(), left, right);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    BooleanExpression left = getLeft().simplifyOnce(context);
    BooleanExpression right = getRight().simplifyOnce(context);

    try {
      return new BooleanValue(new Conjunction(left, right).evaluate(context));
    } catch (UnassignedVariableException e) {
      if (left.equals(new BooleanValue(true))) {
        return right;
      } else if (right.equals(new BooleanValue(true))) {
        return left;
      } else if (left.equals(new BooleanValue(false)) || right.equals(new BooleanValue(false))) {
        return new BooleanValue(false);
      } else if (left.equals(right)) {
        return left;
      }
    }

    return this;
  }
}
