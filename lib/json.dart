import 'package:equatable/equatable.dart';

import 'keys/keys.dart';
import 'lists/json_list.dart';
import 'maps/json_map.dart';
import 'primitives/json_primitive.dart';

export 'keys/keys.dart';

/// A class that can be serialized to and from json.
abstract class Json extends Equatable {
  /// Serialize this object to json.
  Map<String, dynamic> toJson() =>
      Map.fromEntries(keys.map((key) => MapEntry(key.key, key.serialized)));

  /// Parse a json map into this object. If [strict] is true, then an exception
  /// will be thrown if the json map does not contain a key that this object
  /// expects.
  void parse(Map<String, dynamic> json, {bool strict = true}) {
    for (final key in keys) {
      if (json.containsKey(key.key)) {
        key.parse(json[key.key]);
      } else if (strict) {
        throw FormatException('Json does not contain key ${key.key}', json);
      }
    }
  }

  /// Used for constructing a [JsonObject] parser.
  const Json() : super();

  /// Deserialize a json map
  Json.parse(Map<String, dynamic> json, {bool strict = true}) : super() {
    parse(json, strict: strict);
  }

  /// Define all [JsonKey]s that this class uses.
  List<JsonKey<dynamic, dynamic>> get keys;

  /// Used for [Equatable] comparison and string representation.
  @override
  List<Object?> get props => keys;

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

/// A [JsonKey] that parses a [Json] object.
final class JsonObject<T extends Json>
    extends JsonKey<T, Map<String, dynamic>> {
  /// Create a [JsonKey] that parses a [Json] object.
  JsonObject.parser(
    String key,
    T Function() parser,
  ) : super.parser(key, (json) => parser()..parse(json));

  /// Create a [JsonKey] that has already been populated with a value.
  JsonObject.populated(super.key, super.val) : super.populated();

  /// Serialize the populated [Json] object.
  @override
  Map<String, dynamic> serialize(T value) => Map.fromEntries(value.keys.map(
        (key) => MapEntry(key.key, key.serialized),
      ));
}
