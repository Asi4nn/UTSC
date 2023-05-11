package booleanoo;

import java.util.Map;

/**
 * A boolean value: true or false.
 */
public class BooleanValue extends BooleanExpression {
  private Boolean value;

  public BooleanValue(Boolean val) {
    value = val;
  }

  @Override
  public String toString() {
    return value.toString();
  }

  @Override
  public Boolean evaluate(Map<String, Boolean> context) {
    return value;
  }

  @Override
  public BooleanExpression simplifyOnce(Map<String, Boolean> context) {
    return this;
  }

  @Override
  public boolean equals(Object other) {
    return other != null && other.getClass().equals(BooleanValue.class)
        && ((BooleanValue) other).value.equals(value);
  }
}
