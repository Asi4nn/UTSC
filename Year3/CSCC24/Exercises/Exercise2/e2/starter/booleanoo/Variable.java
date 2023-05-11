package booleanoo;

import java.util.Map;

/**
 * A boolean-values variable.
 */
public class Variable extends BooleanExpression {
  private String id;

  public Variable(String id) {
    this.id = id;
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) throws UnassignedVariableException {
    if (context.containsKey(id)) {
      return context.get(id);
    }
    throw new UnassignedVariableException();
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    try {
      return new BooleanValue(evaluate(context));
    } catch (UnassignedVariableException e) {
      return this;
    }
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(Variable.class)
        && id.equals(((Variable) other).id);
  }

  @Override
  public String toString() {
    return id;
  }
}
