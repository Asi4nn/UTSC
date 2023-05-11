package booleanoofunc;

import java.util.List;
import java.util.Map;

/**
 * A binary conjunction of BooleanExpression's.
 */
public class Conjunction extends BinaryExpression {
  public Conjunction(BooleanExpression left, BooleanExpression right) {
    super((l, r) -> (l && r), left, right, Conjunction::simplifyAnd);
  }

  private static BooleanExpression simplifyAnd(List<BooleanExpression> expr,
                                               Map<String, Boolean> context) {
    BinaryExpression simplified = new Conjunction(expr.get(0).simplifyOnce(context),
        expr.get(1).simplifyOnce(context));

    try {
      return new BooleanValue(simplified.evaluate(context));
    } catch (UnassignedVariableException e) {
      if (simplified.getLeft().equals(new BooleanValue(true))) {
        return simplified.getRight();
      } else if (simplified.getRight().equals(new BooleanValue(true))) {
        return simplified.getLeft();
      } else if (simplified.getRight().equals(new BooleanValue(false))) {
        return new BooleanValue(false);
      } else if (simplified.getLeft().equals(new BooleanValue(false))) {
        return new BooleanValue(false);
      } else if (simplified.getLeft().equals(simplified.getRight())) {
        return simplified.getLeft();
      }
    }

    return simplified;
  }

  @Override
  public String toStringOp() {
    return Constants.AND;
  }
}
