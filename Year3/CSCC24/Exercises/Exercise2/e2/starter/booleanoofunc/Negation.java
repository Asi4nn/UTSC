package booleanoofunc;

import java.util.Map;

/**
 * A unary negation.
 */
public class Negation extends UnaryExpression {

  /**
   * Creates a new "not operand".
   *
   * @param operand the operand of this Negation
   */
  public Negation(BooleanExpression operand) {
    super(x -> !x, operand, Negation::simplifyNot);
  }

  private static BooleanExpression simplifyNot(BooleanExpression expr,
                                               Map<String, Boolean> context) {
    Negation simplified = new Negation(expr.simplifyOnce(context));

    try {
      return new BooleanValue(simplified.evaluate(context));
    } catch (UnassignedVariableException e) {
      if (simplified.getOperand().getClass().equals(Negation.class)) {
        return ((Negation) simplified.getOperand()).getOperand();
      }
    }

    return simplified;
  }

  @Override
  public String toStringOp() {
    return Constants.NOT;
  }
}
