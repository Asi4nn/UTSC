package booleanoofunc;

import java.util.List;
import java.util.Map;
import java.util.function.BinaryOperator;

/**
 * Working on lists of BooleanExpression's.
 */
public abstract class BooleanExpressions {

  /**
   * Evaluate each BooleanExpression under context and return a List of the results.
   * <p>
   * TODO: -- Do NOT use any loops. Use Java Streams and the method map. --
   *
   * @param expressions a List of BooleanExpressions to evaluate
   * @param context     truth assignment for all variables in expressions
   * @return a list of the results of evaluating all expressions
   */
  public static List<Boolean> evaluateAll(List<BooleanExpression> expressions,
                                          Map<String, Boolean> context) {
    return expressions.stream().map((e) -> (e.evaluate(context))).toList();
  }

  /**
   * Evaluate each BooleanExpression under context and return the conjunction of
   * the results.
   * <p>
   * TODO: -- Do NOT use any loops. Use Java Streams and the method reduce ONLY. --
   *
   * @param expressions a List of BooleanExpressions to evaluate
   * @param context     truth assignment for all variables in expressions
   * @return conjunction of the results of evaluating all expressions
   */
  public static Boolean evaluateAndReduce(List<BooleanExpression> expressions,
                                          Map<String, Boolean> context) {
    return expressions.stream().reduce(new BooleanValue(true), (acc, element) -> (new Conjunction(
        new BooleanValue(acc.evaluate(context)),
        new BooleanValue(element.evaluate(context))))).evaluate(context);
  }

  /**
   * Evaluate each BooleanExpression under context and return the conjunction of
   * the results.
   * <p>
   * TODO: -- Do NOT use any loops. Use Java Streams and the methods map and reduce. --
   *
   * @param expressions a List of BooleanExpressions to evaluate
   * @param context     truth assignment for all variables in expressions
   * @return conjunction of the results of evaluating all expressions
   */
  public static Boolean evaluateAndMapReduce(List<BooleanExpression> expressions,
                                             Map<String, Boolean> context) {
    return expressions.stream().map((expr) -> (expr.evaluate(context))).reduce(true,
        (acc, v) -> (acc && v));
  }

  /**
   * Evaluate each BooleanExpression under context and return the disjunction of
   * the results.
   * <p>
   * TODO: -- Do NOT use any loops. Use Java Streams and the methods map and reduce. --
   *
   * @param expressions a List of BooleanExpressions to evaluate
   * @param context     truth assignment for all variables in expressions
   * @return disjunction of the results of evaluating all expressions
   */
  public static Boolean evaluateOrMapReduce(List<BooleanExpression> expressions,
                                            Map<String, Boolean> context) {
    return expressions.stream().map((expr) -> (expr.evaluate(context))).reduce(false,
        (acc, v) -> (acc || v));
  }

  /**
   * Evaluate each BooleanExpression under context and return the reduction of
   * the results using the reduction function func and the identity element identity.
   * <p>
   * TODO: -- Do NOT use any loops. Use Java Streams and the methods map and reduce. --
   *
   * @param expressions a List of BooleanExpressions to evaluate
   * @param context     truth assignment for all variables in expressions
   * @return reduction using func and identity of the results of evaluating all expressions
   */
  public static Boolean evaluateMapReduce(BinaryOperator<Boolean> func,
                                          Boolean identity, List<BooleanExpression> expressions,
                                          Map<String, Boolean> context) {

    return expressions.stream().map((expr) -> (expr.evaluate(context))).reduce(identity, func);
  }
}
