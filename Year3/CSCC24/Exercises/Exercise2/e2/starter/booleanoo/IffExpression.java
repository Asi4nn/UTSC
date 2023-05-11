package booleanoo;

import booleanoo.operators.Iff;
import java.util.Map;

/**
 * A binary if and only if of BooleanExpression's.
 */
public class IffExpression extends BinaryExpression {
  public IffExpression(BooleanExpression left, BooleanExpression right) {
    super(new Iff(), left, right);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    BooleanExpression left = getLeft().simplifyOnce(context);
    BooleanExpression right = getRight().simplifyOnce(context);

    try {
      return new BooleanValue(new IffExpression(left, right).evaluate(context));
    } catch (UnassignedVariableException e) {
      if (left.equals(new BooleanValue(true))) {
        return right;
      } else if (right.equals(new BooleanValue(true))) {
        return left;
      } else if (right.equals(new BooleanValue(false))) {
        return new Negation(left);
      } else if (left.equals(new BooleanValue(false))) {
        return new Negation(right);
      } else if (left.equals(right)) {
        return new BooleanValue(true);
      }
    }

    return this;
  }
}
