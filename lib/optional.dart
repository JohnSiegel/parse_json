final class Optional<T> {
  final T? value;

  T? call() => value;

  const Optional(this.value) : super();
}
