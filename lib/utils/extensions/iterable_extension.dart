extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E element) keyFunction) => fold(<K, List<E>>{},
      (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  Iterable<E> whereNotNull() => where((element) => element != null);

  E? get tryLast => length > 0 ? last : null;
}

extension ListExt<E> on List<E> {
  void sortBy<R extends Comparable<R>>(R Function(E element) selector) {
    sort((item1, item2) => selector(item1).compareTo(selector(item2)));
  }
}
