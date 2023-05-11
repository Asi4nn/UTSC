package poly;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

/**
 * Some methods that work with Lists and Pairs.
 */
public class Interleaver {

  /**
   * Returns a List of corresponding elements from xs and ys, interleaved. The
   * remaining elements of the longer List are ignored.
   * This method should not use loops. Use Streams and Stream methods instead!
   */
  // interleave
  public static <T> List<T> interleave(List<T> xs, List<T> ys) {
    return IntStream.range(0, Math.min(xs.size(), ys.size())).boxed()
        .flatMap(i -> Stream.of(xs.get(i), ys.get(i))).collect(Collectors.toList());
  }

  /**
   * Returns a List of Pairs of corresponding elements from xs and ys,
   * interleaved. The remaining elements of the longer List are ignored.
   * This method should not use loops. Use Streams and Stream methods instead!
   */
  // toPairs
  public static <T, U> List<Pair<T, U>> toPairs(List<T> xs, List<U> ys) {
    return IntStream.range(0, Math.min(xs.size(), ys.size()))
        .mapToObj(i -> new Pair<>(xs.get(i), ys.get(i))).toList();
  }
}
