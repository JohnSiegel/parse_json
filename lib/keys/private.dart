part of 'keys.dart';

/// Internal state of a [JsonKey].
sealed class _JsonKeyState<T, Serialized> extends Equatable {
  const _JsonKeyState() : super();
}

/// Internal state of a [JsonKey] that has been populated with a value and
/// serialized. Once reaching this state, the [JsonKey] becomes immutable.
final class _FullyPopulatedState<T, Serialized>
    extends _JsonKeyState<T, Serialized> {
  final T value;
  final Serialized serialized;

  const _FullyPopulatedState(this.value, this.serialized) : super();

  @override
  List<Object?> get props => [value];
}

/// Internal state of a [JsonKey] that has been populated with a value.
/// Once reaching this state, [value] is immutable.
final class _PopulatedState<T, Serialized>
    extends _JsonKeyState<T, Serialized> {
  final T value;

  const _PopulatedState(this.value) : super();

  @override
  List<Object?> get props => [value];
}

/// Internal state of a [JsonKey] that has not been populated with a value.
final class _ParserState<T, Serialized> extends _JsonKeyState<T, Serialized> {
  final T Function(Serialized) parser;

  const _ParserState(this.parser) : super();

  @override
  List<Object?> get props => [];
}
