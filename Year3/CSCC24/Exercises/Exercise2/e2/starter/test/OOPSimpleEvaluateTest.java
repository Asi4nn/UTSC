package test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;

import booleanoofunc.BooleanExpression;
import booleanoofunc.BooleanValue;
import booleanoofunc.Conjunction;
import booleanoofunc.Disjunction;
import booleanoofunc.IffExpression;
import booleanoofunc.Implication;
import booleanoofunc.Negation;
import booleanoofunc.UnassignedVariableException;
import booleanoofunc.Variable;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.junit.Test;

public class OOPSimpleEvaluateTest {

  static Map<String, Boolean> context = Collections.unmodifiableMap(new HashMap<String, Boolean>() {
    {
      put("a", true);
      put("b", false);
      put("c", false);
      put("d", true);
    }
  });

  static Map<String, Boolean> context2 = Collections
      .unmodifiableMap(new HashMap<String, Boolean>() {
        {
          put("c", false);
          put("d", true);
        }
      });

  @Test
  public void simpleAnd1() {
    BooleanExpression expr = new Conjunction(new BooleanValue(true), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleAnd2() {
    BooleanExpression expr = new Conjunction(new BooleanValue(true), new BooleanValue(false));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleAnd3() {
    BooleanExpression expr = new Conjunction(new BooleanValue(false), new BooleanValue(true));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleAnd4() {
    BooleanExpression expr = new Conjunction(new BooleanValue(false), new BooleanValue(false));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleOr1() {
    BooleanExpression expr = new Disjunction(new BooleanValue(true), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleOr2() {
    BooleanExpression expr = new Disjunction(new BooleanValue(true), new BooleanValue(false));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleOr3() {
    BooleanExpression expr = new Disjunction(new BooleanValue(false), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleOr4() {
    BooleanExpression expr = new Disjunction(new BooleanValue(false), new BooleanValue(false));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleImply1() {
    BooleanExpression expr = new Implication(new BooleanValue(true), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleImply2() {
    BooleanExpression expr = new Implication(new BooleanValue(true), new BooleanValue(false));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleImply3() {
    BooleanExpression expr = new Implication(new BooleanValue(false), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleImply4() {
    BooleanExpression expr = new Implication(new BooleanValue(false), new BooleanValue(false));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleIff1() {
    BooleanExpression expr = new IffExpression(new BooleanValue(true), new BooleanValue(true));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleIff2() {
    BooleanExpression expr = new IffExpression(new BooleanValue(true), new BooleanValue(false));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleIff3() {
    BooleanExpression expr = new IffExpression(new BooleanValue(false), new BooleanValue(true));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleIff4() {
    BooleanExpression expr = new IffExpression(new BooleanValue(false), new BooleanValue(false));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void simpleNot1() {
    BooleanExpression expr = new Negation(new BooleanValue(true));
    assertFalse(expr.evaluate(context));
  }

  @Test
  public void simpleNot2() {
    BooleanExpression expr = new Negation(new BooleanValue(false));
    assertTrue(expr.evaluate(context));
  }

  @Test
  public void unassigned() {
    BooleanExpression expr = new Variable("x");
    assertThrows(UnassignedVariableException.class, () -> {
      expr.evaluate(context);
    });
  }
}
