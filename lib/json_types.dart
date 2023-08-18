import 'package:equatable/equatable.dart';

/// A class that can be serialized to and from json.
abstract class Json extends Equatable {
  Map<String, dynamic> toJson() =>
      Map.fromEntries(keys.map((key) => MapEntry(key.key, key.serialized)));

  void _parse(Map<String, dynamic> json, {bool strict = true}) {
    for (final key in keys) {
      if (json.containsKey(key.key)) {
        key._parse(json[key.key]);
      } else if (strict) {
        throw FormatException('Json does not contain key ${key.key}', json);
      }
    }
  }

  const Json() : super();

  Json.parse(Map<String, dynamic> json, {bool strict = true}) : super() {
    _parse(json, strict: strict);
  }

  List<JsonKey<dynamic, dynamic>> get keys;

  @override
  List<Object?> get props => keys.map((k) => k._state).toList();

  static JsonString string(String key) => JsonString.parser(key);
  static JsonInt int(String key) => JsonInt.parser(key);
  static JsonDouble double(String key) => JsonDouble.parser(key);
  static JsonBoolean boolean(String key) => JsonBoolean.parser(key);
  static JsonObject<T> object<T extends Json>(
          String key, T Function() parser) =>
      JsonObject.parser(key, parser);

  static JsonStringList stringList(String key) => JsonStringList.parser(key);
  static JsonIntList intList(String key) => JsonIntList.parser(key);
  static JsonDoubleList doubleList(String key) => JsonDoubleList.parser(key);
  static JsonBooleanList booleanList(String key) => JsonBooleanList.parser(key);
  static JsonObjectList<T> objectList<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectList.parser(key, parserConstructor);

  static JsonStringMap stringMap(String key) => JsonStringMap.parser(key);
  static JsonIntMap intMap(String key) => JsonIntMap.parser(key);
  static JsonDoubleMap doubleMap(String key) => JsonDoubleMap.parser(key);
  static JsonBooleanMap booleanMap(String key) => JsonBooleanMap.parser(key);
  static JsonObjectMap<T> objectMap<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectMap.parser(key, parserConstructor);
}

sealed class _JsonKeyState<T, Serialized> extends Equatable {
  const _JsonKeyState() : super();
}

final class _FullyPopulatedState<T, Serialized>
    extends _JsonKeyState<T, Serialized> {
  final T value;
  final Serialized serialized;

  const _FullyPopulatedState(this.value, this.serialized) : super();

  @override
  List<Object?> get props => [value];
}

final class _PopulatedState<T, Serialized>
    extends _JsonKeyState<T, Serialized> {
  final T value;

  const _PopulatedState(this.value) : super();

  @override
  List<Object?> get props => [value];
}

final class _ParserState<T, Serialized> extends _JsonKeyState<T, Serialized> {
  final T Function(Serialized) parser;

  const _ParserState(this.parser) : super();

  @override
  List<Object?> get props => [];
}

sealed class JsonKey<T, Serialized> {
  final String key;

  _JsonKeyState<T, Serialized> _state;

  JsonKey.parser(this.key, T Function(Serialized) parser)
      : _state = _ParserState(parser),
        super();

  JsonKey.populated(this.key, T val)
      : _state = _PopulatedState(val),
        super();

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

  void populate(T value) => switch (_state) {
        _FullyPopulatedState(value: final val) ||
        _PopulatedState(value: final val) =>
          throw StateError(
              'Tried to populate $key with $value, but $key is already '
              'populated with value: $val.'),
        _ParserState() => _state = _PopulatedState(value),
      };

  T get value => switch (_state) {
        _FullyPopulatedState(value: final value) ||
        _PopulatedState(value: final value) =>
          value,
        _ParserState() => throw StateError('Cannot get value of a parser'),
      };

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

  Serialized _serializeInternal(T value);
}

base class _JsonPrimitive<T> extends JsonKey<T, T> {
  _JsonPrimitive.populated(super.key, super.val) : super.populated();

  _JsonPrimitive.parser(String key) : super.parser(key, parseInternal);

  @override
  T _serializeInternal(T val) => val;

  static T parseInternal<T>(T serialized) => serialized;
}

final class JsonString extends _JsonPrimitive<String> {
  JsonString.populated(super.key, super.val) : super.populated();

  JsonString.parser(super.key) : super.parser();
}

final class JsonInt extends _JsonPrimitive<int> {
  JsonInt.parser(super.key) : super.parser();

  JsonInt.populated(super.key, super.val) : super.populated();
}

final class JsonDouble extends _JsonPrimitive<double> {
  JsonDouble.parser(super.key) : super.parser();

  JsonDouble.populated(super.key, super.val) : super.populated();
}

final class JsonBoolean extends _JsonPrimitive<bool> {
  JsonBoolean.parser(super.key) : super.parser();

  JsonBoolean.populated(super.key, super.val) : super.populated();
}

final class JsonObject<T extends Json>
    extends JsonKey<T, Map<String, dynamic>> {
  JsonObject.parser(
    String key,
    T Function() parser,
  ) : super.parser(key, (json) => parser().._parse(json));

  JsonObject.populated(super.key, super.val) : super.populated();

  @override
  Map<String, dynamic> _serializeInternal(T value) =>
      Map.fromEntries(value.keys.map(
        (key) => MapEntry(key.key, key.serialized),
      ));
}

sealed class _JsonList<T, Serializable>
    extends JsonKey<List<T>, List<Serializable>> {
  _JsonList.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (list) => list.map((e) => parser(e)).toList());

  _JsonList.populated(super.key, super.val) : super.populated();
}

sealed class _JsonMap<T, Serializable>
    extends JsonKey<Map<String, T>, Map<String, Serializable>> {
  _JsonMap.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (map) => map.map((k, v) => MapEntry(k, parser(v))));

  _JsonMap.populated(super.key, super.val) : super.populated();
}

abstract class _JsonPrimitiveList<T> extends _JsonList<T, T> {
  _JsonPrimitiveList.parser(String key)
      : super.parser(key, _JsonPrimitive.parseInternal);

  _JsonPrimitiveList.populated(super.key, super.val) : super.populated();

  @override
  List<T> _serializeInternal(List<T> val) => val;
}

final class JsonStringList extends _JsonPrimitiveList<String> {
  JsonStringList.parser(super.key) : super.parser();

  JsonStringList.populated(super.key, super.val) : super.populated();
}

final class JsonIntList extends _JsonPrimitiveList<int> {
  JsonIntList.parser(super.key) : super.parser();

  JsonIntList.populated(super.key, super.val) : super.populated();
}

final class JsonDoubleList extends _JsonPrimitiveList<double> {
  JsonDoubleList.parser(super.key) : super.parser();

  JsonDoubleList.populated(super.key, super.val) : super.populated();
}

final class JsonBooleanList extends _JsonPrimitiveList<bool> {
  JsonBooleanList.parser(super.key) : super.parser();

  JsonBooleanList.populated(super.key, super.val) : super.populated();
}

final class JsonObjectList<T extends Json>
    extends _JsonList<T, Map<String, dynamic>> {
  JsonObjectList.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor().._parse(json));

  JsonObjectList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>> _serializeInternal(List<T> value) =>
      value.map((e) => e.toJson()).toList();
}

sealed class _JsonPrimitiveMap<T> extends _JsonMap<T, T> {
  _JsonPrimitiveMap.parser(String key)
      : super.parser(key, _JsonPrimitive.parseInternal);

  _JsonPrimitiveMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, T> _serializeInternal(Map<String, T> val) => val;
}

final class JsonStringMap extends _JsonPrimitiveMap<String> {
  JsonStringMap.parser(super.key) : super.parser();

  JsonStringMap.populated(super.key, super.val) : super.populated();
}

final class JsonIntMap extends _JsonPrimitiveMap<int> {
  JsonIntMap.parser(super.key) : super.parser();

  JsonIntMap.populated(super.key, super.val) : super.populated();
}

final class JsonDoubleMap extends _JsonPrimitiveMap<double> {
  JsonDoubleMap.parser(super.key) : super.parser();

  JsonDoubleMap.populated(super.key, super.val) : super.populated();
}

final class JsonBooleanMap extends _JsonPrimitiveMap<bool> {
  JsonBooleanMap.parser(super.key) : super.parser();

  JsonBooleanMap.populated(super.key, super.val) : super.populated();
}

final class JsonObjectMap<T extends Json>
    extends _JsonMap<T, Map<String, dynamic>> {
  JsonObjectMap.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor().._parse(json));

  JsonObjectMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>> _serializeInternal(Map<String, T> value) =>
      value.map((k, v) => MapEntry(k, v.toJson()));
}
