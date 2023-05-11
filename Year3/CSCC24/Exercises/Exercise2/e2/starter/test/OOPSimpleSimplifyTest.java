package test;

import static org.junit.Assert.assertEquals;

import booleanoofunc.BooleanExpression;
import booleanoofunc.BooleanValue;
import booleanoofunc.Conjunction;
import booleanoofunc.Disjunction;
import booleanoofunc.IffExpression;
import booleanoofunc.Implication;
import booleanoofunc.Negation;
import booleanoofunc.Variable;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.junit.Test;

public class OOPSimpleSimplifyTest {
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
    BooleanExpression expr = new Conjunction(new BooleanValue(true), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleAnd2() {
    BooleanExpression expr = new Conjunction(new Variable("x"), new BooleanValue(true));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleAnd3() {
    BooleanExpression expr = new Conjunction(new BooleanValue(false), new Variable("x"));
    BooleanExpression expect = new BooleanValue(false);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleAnd4() {
    BooleanExpression expr = new Conjunction(new Variable("x"), new BooleanValue(false));
    BooleanExpression expect = new BooleanValue(false);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleAnd5() {
    BooleanExpression expr = new Conjunction(new Variable("x"), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleAnd6() {
    BooleanExpression expr = new Conjunction(new Variable("x"), new Variable("y"));
    BooleanExpression expect = new Conjunction(new Variable("x"), new Variable("y"));
    assertEquals(expect, expr.simplify(context));
  }

  //====================================================================================

  @Test
  public void simpleOr1() {
    BooleanExpression expr = new Disjunction(new BooleanValue(true), new Variable("x"));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleOr2() {
    BooleanExpression expr = new Disjunction(new Variable("x"), new BooleanValue(true));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleOr3() {
    BooleanExpression expr = new Disjunction(new BooleanValue(false), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleOr4() {
    BooleanExpression expr = new Disjunction(new Variable("x"), new BooleanValue(false));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleOr5() {
    BooleanExpression expr = new Disjunction(new Variable("x"), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleOr6() {
    BooleanExpression expr = new Disjunction(new Variable("x"), new Variable("y"));
    BooleanExpression expect = new Disjunction(new Variable("x"), new Variable("y"));
    assertEquals(expect, expr.simplify(context));
  }

  //===================================================================================

  @Test
  public void simpleImply1() {
    BooleanExpression expr = new Implication(new BooleanValue(true), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleImply2() {
    BooleanExpression expr = new Implication(new Variable("x"), new BooleanValue(true));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleImply3() {
    BooleanExpression expr = new Implication(new BooleanValue(false), new Variable("x"));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleImply4() {
    BooleanExpression expr = new Implication(new Variable("x"), new BooleanValue(false));
    BooleanExpression expect = new Negation(new Variable("x"));
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleImply5() {
    BooleanExpression expr = new Implication(new Variable("x"), new Variable("x"));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleImply6() {
    BooleanExpression expr = new Implication(new Variable("x"), new Variable("y"));
    BooleanExpression expect = new Implication(new Variable("x"), new Variable("y"));
    assertEquals(expect, expr.simplify(context));
  }

  //===================================================================================

  @Test
  public void simpleIff1() {
    BooleanExpression expr = new IffExpression(new BooleanValue(true), new Variable("x"));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleIff2() {
    BooleanExpression expr = new IffExpression(new Variable("x"), new BooleanValue(true));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleIff3() {
    BooleanExpression expr = new IffExpression(new BooleanValue(false), new Variable("x"));
    BooleanExpression expect = new Negation(new Variable("x"));
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleIff4() {
    BooleanExpression expr = new IffExpression(new Variable("x"), new BooleanValue(false));
    BooleanExpression expect = new Negation(new Variable("x"));
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleIff5() {
    BooleanExpression expr = new IffExpression(new Variable("x"), new Variable("x"));
    BooleanExpression expect = new BooleanValue(true);
    assertEquals(expect, expr.simplify(context));
  }

  @Test
  public void simpleIff6() {
    BooleanExpression expr = new IffExpression(new Variable("x"), new Variable("y"));
    BooleanExpression expect = new IffExpression(new Variable("x"), new Variable("y"));
    assertEquals(expect, expr.simplify(context));
  }

  //===================================================================================

  @Test
  public void simpleNot1() {
    BooleanExpression expr = new Negation(new Negation(new Variable("x")));
    BooleanExpression expect = new Variable("x");
    assertEquals(expect, expr.simplify(context));
  }
}
