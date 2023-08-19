import 'package:equatable/equatable.dart';

/// A class that can be serialized to and from json.
abstract class Json extends Equatable {
  /// Serialize this object to json.
  Map<String, dynamic> toJson() =>
      Map.fromEntries(keys.map((key) => MapEntry(key.key, key.serialized)));

  /// Parse a json map into this object. If [strict] is true, then an exception
  /// will be thrown if the json map does not contain a key that this object
  /// expects.
  void _parse(Map<String, dynamic> json, {bool strict = true}) {
    for (final key in keys) {
      if (json.containsKey(key.key)) {
        key._parse(json[key.key]);
      } else if (strict) {
        throw FormatException('Json does not contain key ${key.key}', json);
      }
    }
  }

  /// Used for constructing a [JsonObject] parser.
  const Json() : super();

  /// Deserialize a json map
  Json.parse(Map<String, dynamic> json, {bool strict = true}) : super() {
    _parse(json, strict: strict);
  }

  /// Define all [JsonKey]s that this class uses.
  List<JsonKey<dynamic, dynamic>> get keys;

  /// Used for [Equatable] comparison and string representation.
  @override
  List<Object?> get props => keys.map((k) => k._state).toList();

  /// A [JsonKey] that parses a string.
  static JsonString string(String key) => JsonString.parser(key);

  /// A [JsonKey] that parses an int.
  static JsonInt int(String key) => JsonInt.parser(key);

  /// A [JsonKey] that parses a double.
  static JsonDouble double(String key) => JsonDouble.parser(key);

  /// A [JsonKey] that parses a boolean.
  static JsonBoolean boolean(String key) => JsonBoolean.parser(key);

  /// A [JsonKey] that parses a [Json] object.
  static JsonObject<T> object<T extends Json>(
          String key, T Function() parser) =>
      JsonObject.parser(key, parser);

  /// A [JsonKey] that parses a list of strings.
  static JsonStringList stringList(String key) => JsonStringList.parser(key);

  /// A [JsonKey] that parses a list of ints.
  static JsonIntList intList(String key) => JsonIntList.parser(key);

  /// A [JsonKey] that parses a list of doubles.
  static JsonDoubleList doubleList(String key) => JsonDoubleList.parser(key);

  /// A [JsonKey] that parses a list of booleans.
  static JsonBooleanList booleanList(String key) => JsonBooleanList.parser(key);

  /// A [JsonKey] that parses a list of [Json] objects.
  static JsonObjectList<T> objectList<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectList.parser(key, parserConstructor);

  /// A [JsonKey] that parses a map of strings.
  static JsonStringMap stringMap(String key) => JsonStringMap.parser(key);

  /// A [JsonKey] that parses a map of ints.
  static JsonIntMap intMap(String key) => JsonIntMap.parser(key);

  /// A [JsonKey] that parses a map of doubles.
  static JsonDoubleMap doubleMap(String key) => JsonDoubleMap.parser(key);

  /// A [JsonKey] that parses a map of booleans.
  static JsonBooleanMap booleanMap(String key) => JsonBooleanMap.parser(key);

  /// A [JsonKey] that parses a map of [Json] objects.
  static JsonObjectMap<T> objectMap<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectMap.parser(key, parserConstructor);
}

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

/// A key that can be used to parse a value from json.
sealed class JsonKey<T, Serialized> {
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

  /// Parse a value from json, and populate this [JsonKey] with the parsed
  /// value.
  ///
  /// @pre The [JsonKey] must be in the [_ParserState] state.
  T _parse(Serialized serialized) => switch (_state) {
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
            final serialized = _serializeInternal(value);
            _state = _FullyPopulatedState(value, serialized);
            return serialized;
          }(),
        _ParserState() =>
          throw StateError('Cannot get serialized value of a parser'),
      };

  /// Serialize a value to json.
  Serialized _serializeInternal(T value);
}

/// A [JsonKey] that parses a primitive value.
base class _JsonPrimitive<T> extends JsonKey<T, T> {
  _JsonPrimitive.populated(super.key, super.val) : super.populated();

  _JsonPrimitive.parser(String key) : super.parser(key, parseInternal);

  /// Serialize a primitive value. (identity function)
  @override
  T _serializeInternal(T val) => val;

  /// Parse a primitive value. (identity function)
  static T parseInternal<T>(T serialized) => serialized;
}

/// A [JsonKey] that parses a string value.
final class JsonString extends _JsonPrimitive<String> {
  JsonString.populated(super.key, super.val) : super.populated();

  JsonString.parser(super.key) : super.parser();
}

/// A [JsonKey] that parses an int value.
final class JsonInt extends _JsonPrimitive<int> {
  JsonInt.parser(super.key) : super.parser();

  JsonInt.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a double value.
final class JsonDouble extends _JsonPrimitive<double> {
  JsonDouble.parser(super.key) : super.parser();

  JsonDouble.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a boolean value.
final class JsonBoolean extends _JsonPrimitive<bool> {
  JsonBoolean.parser(super.key) : super.parser();

  JsonBoolean.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a [Json] object.
final class JsonObject<T extends Json>
    extends JsonKey<T, Map<String, dynamic>> {
  /// Create a [JsonKey] that parses a [Json] object.
  JsonObject.parser(
    String key,
    T Function() parser,
  ) : super.parser(key, (json) => parser().._parse(json));

  /// Create a [JsonKey] that has already been populated with a value.
  JsonObject.populated(super.key, super.val) : super.populated();

  /// Serialize the populated [Json] object.
  @override
  Map<String, dynamic> _serializeInternal(T value) =>
      Map.fromEntries(value.keys.map(
        (key) => MapEntry(key.key, key.serialized),
      ));
}

/// A [JsonKey] that parses a list of [Json] objects.
sealed class _JsonList<T, Serializable>
    extends JsonKey<List<T>, List<Serializable>> {
  _JsonList.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (list) => list.map((e) => parser(e)).toList());

  _JsonList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map.
sealed class _JsonMap<T, Serializable>
    extends JsonKey<Map<String, T>, Map<String, Serializable>> {
  _JsonMap.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (map) => map.map((k, v) => MapEntry(k, parser(v))));

  _JsonMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of primitives.
abstract class _JsonPrimitiveList<T> extends _JsonList<T, T> {
  _JsonPrimitiveList.parser(String key)
      : super.parser(key, _JsonPrimitive.parseInternal);

  _JsonPrimitiveList.populated(super.key, super.val) : super.populated();

  @override
  List<T> _serializeInternal(List<T> val) => val;
}

/// A [JsonKey] that parses a list of strings.
final class JsonStringList extends _JsonPrimitiveList<String> {
  JsonStringList.parser(super.key) : super.parser();

  JsonStringList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of ints.
final class JsonIntList extends _JsonPrimitiveList<int> {
  JsonIntList.parser(super.key) : super.parser();

  JsonIntList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of doubles.
final class JsonDoubleList extends _JsonPrimitiveList<double> {
  JsonDoubleList.parser(super.key) : super.parser();

  JsonDoubleList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of booleans.
final class JsonBooleanList extends _JsonPrimitiveList<bool> {
  JsonBooleanList.parser(super.key) : super.parser();

  JsonBooleanList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of [Json] objects.
final class JsonObjectList<T extends Json>
    extends _JsonList<T, Map<String, dynamic>> {
  JsonObjectList.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor().._parse(json));

  JsonObjectList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>> _serializeInternal(List<T> value) =>
      value.map((e) => e.toJson()).toList();
}

/// A [JsonKey] that parses a map of primitives.
sealed class _JsonPrimitiveMap<T> extends _JsonMap<T, T> {
  _JsonPrimitiveMap.parser(String key)
      : super.parser(key, _JsonPrimitive.parseInternal);

  _JsonPrimitiveMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, T> _serializeInternal(Map<String, T> val) => val;
}

/// A [JsonKey] that parses a map of strings.
final class JsonStringMap extends _JsonPrimitiveMap<String> {
  JsonStringMap.parser(super.key) : super.parser();

  JsonStringMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of ints.
final class JsonIntMap extends _JsonPrimitiveMap<int> {
  JsonIntMap.parser(super.key) : super.parser();

  JsonIntMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of doubles.
final class JsonDoubleMap extends _JsonPrimitiveMap<double> {
  JsonDoubleMap.parser(super.key) : super.parser();

  JsonDoubleMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of booleans.
final class JsonBooleanMap extends _JsonPrimitiveMap<bool> {
  JsonBooleanMap.parser(super.key) : super.parser();

  JsonBooleanMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of [Json] objects.
final class JsonObjectMap<T extends Json>
    extends _JsonMap<T, Map<String, dynamic>> {
  JsonObjectMap.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor().._parse(json));

  JsonObjectMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>> _serializeInternal(Map<String, T> value) =>
      value.map((k, v) => MapEntry(k, v.toJson()));
}
