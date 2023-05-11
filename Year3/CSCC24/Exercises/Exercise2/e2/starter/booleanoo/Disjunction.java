package booleanoo;

import booleanoo.operators.Or;
import java.util.Map;

/**
 * A binary disjunction of BooleanExpression's.
 */
public class Disjunction extends BinaryExpression {
  public Disjunction(BooleanExpression left, BooleanExpression right) {
    super(new Or(), left, right);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    BooleanExpression left = getLeft().simplifyOnce(context);
    BooleanExpression right = getRight().simplifyOnce(context);

    try {
      return new BooleanValue(new Disjunction(left, right).evaluate(context));
    } catch (UnassignedVariableException e) {
      if (left.equals(new BooleanValue(false))) {
        return right;
      } else if (right.equals(new BooleanValue(false))) {
        return left;
      } else if (left.equals(new BooleanValue(true)) || right.equals(new BooleanValue(true))) {
        return new BooleanValue(true);
      } else if (left.equals(right)) {
        return left;
      }
    }

    return this;
  }
}
