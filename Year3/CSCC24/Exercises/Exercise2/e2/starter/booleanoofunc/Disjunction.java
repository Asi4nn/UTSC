package booleanoofunc;

import java.util.List;
import java.util.Map;

/**
 * A binary disjunction of BooleanExpression's.
 */
public class Disjunction extends BinaryExpression {
  public Disjunction(BooleanExpression left, BooleanExpression right) {
    super((l, r) -> (l || r), left, right, Disjunction::simplifyOr);
  }

  private static BooleanExpression simplifyOr(List<BooleanExpression> expr,
                                              Map<String, Boolean> context) {
    BinaryExpression simplified = new Disjunction(expr.get(0).simplifyOnce(context),
        expr.get(1).simplifyOnce(context));

    try {
      return new BooleanValue(simplified.evaluate(context));
    } catch (UnassignedVariableException e) {
      if (simplified.getLeft().equals(new BooleanValue(true))) {
        return new BooleanValue(true);
      } else if (simplified.getRight().equals(new BooleanValue(true))) {
        return new BooleanValue(true);
      } else if (simplified.getRight().equals(new BooleanValue(false))) {
        return simplified.getLeft();
      } else if (simplified.getLeft().equals(new BooleanValue(false))) {
        return simplified.getRight();
      } else if (simplified.getLeft().equals(simplified.getRight())) {
        return simplified.getLeft();
      }
    }

    return simplified;
  }

  @Override
  public String toStringOp() {
    return Constants.OR;
  }
}
