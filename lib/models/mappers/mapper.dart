typedef Mapper<F, T> = T Function(F value);
typedef ListMapper<F, T> = List<T> Function(List<F> value);

extension A<F, T> on Mapper<F, T> {
  ListMapper<F, T> forList() {
    return (List<F> from) => from.map(this.call);
  }
}
