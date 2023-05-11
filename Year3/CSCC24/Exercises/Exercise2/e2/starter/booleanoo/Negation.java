package booleanoo;

import booleanoo.operators.Not;
import java.util.Map;

/**
 * A unary negation.
 */
public class Negation extends UnaryExpression {
  public Negation(BooleanExpression op) {
    super(new Not(), op);
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    BooleanExpression expr = getOperand().simplifyOnce(context);

    try {
      return new BooleanValue(new Negation(expr).evaluate(context));
    } catch (UnassignedVariableException e) {
      if (expr.getClass().equals(Negation.class)) {
        return ((Negation) expr).getOperand();
      }
    }

    return this;
  }
}
