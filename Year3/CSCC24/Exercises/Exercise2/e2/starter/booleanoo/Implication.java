package booleanoo;

import booleanoo.operators.Implies;
import java.util.Map;

/**
 * A binary implication of BooleanExpression's.
 */
public class Implication extends BinaryExpression {
  public Implication(BooleanExpression left, BooleanExpression right) {
    super(new Implies(), left, right);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    BooleanExpression left = getLeft().simplifyOnce(context);
    BooleanExpression right = getRight().simplifyOnce(context);


    try {
      return new BooleanValue(new Implication(left, right).evaluate(context));
    } catch (UnassignedVariableException e) {
      if (left.equals(new BooleanValue(true))) {
        return right;
      } else if (right.equals(new BooleanValue(true))) {
        return new BooleanValue(true);
      } else if (right.equals(new BooleanValue(false))) {
        return new Negation(left);
      } else if (left.equals(new BooleanValue(false))) {
        return new BooleanValue(true);
      } else if (left.equals(right)) {
        return new BooleanValue(true);
      }
    }

    return this;
  }
}
