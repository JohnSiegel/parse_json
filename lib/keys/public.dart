part of 'keys.dart';

/// A key that can be used to parse a value from json.
abstract base class JsonKey<T, Serialized> with EquatableMixin {
  /// The key used to parse the value from json.
  final String key;

  /// The current state of the [JsonKey].
  _JsonKeyState<T, Serialized> _state;

  /// Create a [JsonKey] that parses a value from json.
  JsonKey.parser(this.key, T Function(Serialized) parser)
      : _state = _ParserState(parser),
        super();

  /// Create a [JsonKey] that has already been populated with a value.
  JsonKey.populated(this.key, T val)
      : _state = _PopulatedState(val),
        super();

  @override
  List<Object?> get props => _state.props;

  /// Parse a value from json, and populate this [JsonKey] with the parsed
  /// value.
  ///
  /// @pre The [JsonKey] must be in the [_ParserState] state.
  T parse(Serialized serialized) => switch (_state) {
        _FullyPopulatedState(value: final value) ||
        _PopulatedState(value: final value) =>
          throw StateError(
              'Tried to parse $key with $serialized, but $key is already '
              'populated with value: $value.'),
        _ParserState(parser: final parser) => () {
            final val = parser(serialized);
            _state = _FullyPopulatedState(val, serialized);
            return val;
          }()
      };

  /// Populate this [JsonKey] with a value.
  ///
  /// Note that this method can only be called once.
  void populate(T value) => switch (_state) {
        _FullyPopulatedState(value: final val) ||
        _PopulatedState(value: final val) =>
          throw StateError(
              'Tried to populate $key with $value, but $key is already '
              'populated with value: $val.'),
        _ParserState() => _state = _PopulatedState(value),
      };

  /// The value of this [JsonKey].
  ///
  /// @pre The [JsonKey] must be populated with a value.
  T get value => switch (_state) {
        _FullyPopulatedState(value: final value) ||
        _PopulatedState(value: final value) =>
          value,
        _ParserState() => throw StateError('Cannot get value of a parser'),
      };

  /// The serialized value of this [JsonKey].
  ///
  /// @pre The [JsonKey] must be populated with a value.
  Serialized get serialized => switch (_state) {
        _FullyPopulatedState(serialized: final serialized) => serialized,
        _PopulatedState(value: final value) => () {
            final serialized = serialize(value);
            _state = _FullyPopulatedState(value, serialized);
            return serialized;
          }(),
        _ParserState() =>
          throw StateError('Cannot get serialized value of a parser'),
      };

  /// Serialize a value to json.
  Serialized serialize(T value);
}
