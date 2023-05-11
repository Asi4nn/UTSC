package booleanoofunc;

import java.util.List;
import java.util.Map;

/**
 * A binary implication of BooleanExpression's.
 */
public class Implication extends BinaryExpression {

  public Implication(BooleanExpression left, BooleanExpression right) {
    super((l, r) -> (!l || r), left, right, Implication::simplifyImplication);
  }

  private static BooleanExpression simplifyImplication(List<BooleanExpression> expr,
                                                       Map<String, Boolean> context) {
    BinaryExpression simplified = new Implication(expr.get(0).simplifyOnce(context),
        expr.get(1).simplifyOnce(context));

    try {
      return new BooleanValue(simplified.evaluate(context));
    } catch (UnassignedVariableException e) {
      if (simplified.getLeft().equals(new BooleanValue(true))) {
        return simplified.getRight();
      } else if (simplified.getRight().equals(new BooleanValue(true))) {
        return new BooleanValue(true);
      } else if (simplified.getRight().equals(new BooleanValue(false))) {
        return new Negation(simplified.getLeft());
      } else if (simplified.getLeft().equals(new BooleanValue(false))) {
        return new BooleanValue(true);
      } else if (simplified.getLeft().equals(simplified.getRight())) {
        return new BooleanValue(true);
      }
    }

    return simplified;
  }

  @Override
  public String toStringOp() {
    return Constants.IMPLIES;
  }
}
