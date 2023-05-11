package booleanoofunc;

import java.util.List;
import java.util.Map;

/**
 * A binary if and only if of BooleanExpression's.
 */
public class IffExpression extends BinaryExpression {
  public IffExpression(BooleanExpression left, BooleanExpression right) {
    super((l, r) -> (l.equals(r)), left, right, IffExpression::simplifyIff);
  }

  private static BooleanExpression simplifyIff(List<BooleanExpression> expr,
                                               Map<String, Boolean> context) {
    BinaryExpression simplified = new IffExpression(expr.get(0).simplifyOnce(context),
        expr.get(1).simplifyOnce(context));

    try {
      return new BooleanValue(simplified.evaluate(context));
    } catch (UnassignedVariableException e) {
      if (simplified.getLeft().equals(new BooleanValue(true))) {
        return simplified.getRight();
      } else if (simplified.getRight().equals(new BooleanValue(true))) {
        return simplified.getLeft();
      } else if (simplified.getRight().equals(new BooleanValue(false))) {
        return new Negation(simplified.getLeft());
      } else if (simplified.getLeft().equals(new BooleanValue(false))) {
        return new Negation(simplified.getRight());
      } else if (simplified.getLeft().equals(simplified.getRight())) {
        return new BooleanValue(true);
      }
    }

    return simplified;
  }

  @Override
  public String toStringOp() {
    return Constants.IFF;
  }
}
