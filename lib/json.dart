import 'package:equatable/equatable.dart';

import 'json_polymorphic.dart';
import 'keys/keys.dart';
import 'lists/json_list.dart';
import 'maps/json_map.dart';
import 'primitives/json_primitive.dart';

export 'json_polymorphic.dart';
export 'keys/keys.dart';
export 'primitives/json_primitive.dart';

/// A class that can be serialized to and from json.
abstract class Json extends Equatable {
  /// Serialize this object to json.
  Map<String, dynamic> toJson() => Map.fromEntries(Iterable.castFrom(
          keys.fold(<MapEntry<String, dynamic>>[], (json, key) {
        if (key.serialized != null) {
          json.add(MapEntry(key.key, key.serialized));
        }
        return json;
      })));

  /// Parse a json map into this object.
  void parse(Map<String, dynamic> json) {
    for (final key in keys) {
      key.parse(json[key.key]);
    }
  }

  /// Used for constructing a [JsonObjectKey] parser.
  const Json() : super();

  /// Deserialize a json map
  Json.parse(Map<String, dynamic> json) : super() {
    parse(json);
  }

  /// Define all [JsonKey]s that this class uses.
  List<JsonKey<dynamic, dynamic>> get keys;

  /// Used for [Equatable] comparison and string representation.
  @override
  List<Object?> get props => keys;

  /// A [JsonKey] that parses a string.
  static JsonString string(String key) => JsonString.parser(key);

  /// A [JsonKey] that parses an optional string.
  static JsonOptionalString optionalString(String key) =>
      JsonOptionalString.parser(key);

  /// A [JsonKey] that parses an int.
  static JsonInt int(String key) => JsonInt.parser(key);

  /// A [JsonKey] that parses an optional int.
  static JsonOptionalInt optionalInt(String key) => JsonOptionalInt.parser(key);

  /// A [JsonKey] that parses a double.
  static JsonDouble double(String key) => JsonDouble.parser(key);

  /// A [JsonKey] that parses an optional double.
  static JsonOptionalDouble optionalDouble(String key) =>
      JsonOptionalDouble.parser(key);

  /// A [JsonKey] that parses a boolean.
  static JsonBoolean boolean(String key) => JsonBoolean.parser(key);

  /// A [JsonKey] that parses an optional boolean.
  static JsonOptionalBoolean optionalBoolean(String key) =>
      JsonOptionalBoolean.parser(key);

  /// A [JsonKey] that parses a [Json] object.
  static JsonObjectKey<T> object<T extends Json>(
          String key, T Function() parser) =>
      JsonObjectKey.parser(key, parser);

  /// A [JsonKey] that parses an optional [Json] object.
  static JsonOptionalObjectKey<T> optionalObject<T extends Json>(
          String key, T Function() parser) =>
      JsonOptionalObjectKey.parser(key, parser);

  /// A [JsonKey] that parses a [JsonPolymorphic] object.
  static JsonPolymorphicKey<T> polymorphic<T extends JsonPolymorphic<T>>(
          String key, List<T Function()> parsers) =>
      JsonPolymorphicKey.parser(key, parsers);

  /// A [JsonKey] that parses an optional [JsonPolymorphic] object.
  static JsonOptionalPolymorphicKey<T>
      optionalPolymorphic<T extends JsonPolymorphic<T>>(
              String key, List<T Function()> parsers) =>
          JsonOptionalPolymorphicKey.parser(key, parsers);

  /// A [JsonKey] that parses a list of strings.
  static JsonStringList stringList(String key) => JsonStringList.parser(key);

  /// A [JsonKey] that parses an optional list of strings.
  static JsonOptionalStringList optionalStringList(String key) =>
      JsonOptionalStringList.parser(key);

  /// A [JsonKey] that parses a list of ints.
  static JsonIntList intList(String key) => JsonIntList.parser(key);

  /// A [JsonKey] that parses an optional list of ints.
  static JsonOptionalIntList optionalIntList(String key) =>
      JsonOptionalIntList.parser(key);

  /// A [JsonKey] that parses a list of doubles.
  static JsonDoubleList doubleList(String key) => JsonDoubleList.parser(key);

  /// A [JsonKey] that parses an optional list of doubles.
  static JsonOptionalDoubleList optionalDoubleList(String key) =>
      JsonOptionalDoubleList.parser(key);

  /// A [JsonKey] that parses a list of booleans.
  static JsonBooleanList booleanList(String key) => JsonBooleanList.parser(key);

  /// A [JsonKey] that parses an optional list of booleans.
  static JsonOptionalBooleanList optionalBooleanList(String key) =>
      JsonOptionalBooleanList.parser(key);

  /// A [JsonKey] that parses a list of [Json] objects.
  static JsonObjectKeyList<T> objectList<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectKeyList.parser(key, parserConstructor);

  /// A [JsonKey] that parses an optional list of [Json] objects.
  static JsonOptionalObjectKeyList<T> optionalObjectList<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonOptionalObjectKeyList.parser(key, parserConstructor);

  /// A [JsonKey] that parses a list of [JsonPolymorphic] objects.
  static JsonPolymorphicKeyList<T>
      polymorphicList<T extends JsonPolymorphic<T>>(
              String key, T Function(Map<String, dynamic>) parse) =>
          JsonPolymorphicKeyList.parser(key, parse);

  /// A [JsonKey] that parses an optional list of [JsonPolymorphic] objects.
  static JsonOptionalPolymorphicKeyList<T>
      optionalPolymorphicList<T extends JsonPolymorphic<T>>(
              String key, T Function(Map<String, dynamic>) parse) =>
          JsonOptionalPolymorphicKeyList.parser(key, parse);

  /// A [JsonKey] that parses a map of strings.
  static JsonStringMap stringMap(String key) => JsonStringMap.parser(key);

  /// A [JsonKey] that parses an optional map of strings.
  static JsonOptionalStringMap optionalStringMap(String key) =>
      JsonOptionalStringMap.parser(key);

  /// A [JsonKey] that parses a map of ints.
  static JsonIntMap intMap(String key) => JsonIntMap.parser(key);

  /// A [JsonKey] that parses an optional map of ints.
  static JsonOptionalIntMap optionalIntMap(String key) =>
      JsonOptionalIntMap.parser(key);

  /// A [JsonKey] that parses a map of doubles.
  static JsonDoubleMap doubleMap(String key) => JsonDoubleMap.parser(key);

  /// A [JsonKey] that parses an optional map of doubles.
  static JsonOptionalDoubleMap optionalDoubleMap(String key) =>
      JsonOptionalDoubleMap.parser(key);

  /// A [JsonKey] that parses a map of booleans.
  static JsonBooleanMap booleanMap(String key) => JsonBooleanMap.parser(key);

  /// A [JsonKey] that parses an optional map of booleans.
  static JsonOptionalBooleanMap optionalBooleanMap(String key) =>
      JsonOptionalBooleanMap.parser(key);

  /// A [JsonKey] that parses a map of [Json] objects.
  static JsonObjectKeyMap<T> objectMap<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonObjectKeyMap.parser(key, parserConstructor);

  /// A [JsonKey] that parses an optional map of [Json] objects.
  static JsonOptionalObjectKeyMap<T> optionalObjectMap<T extends Json>(
          String key, T Function() parserConstructor) =>
      JsonOptionalObjectKeyMap.parser(key, parserConstructor);

  /// A [JsonKey] that parses a map of [JsonPolymorphic] objects.
  static JsonPolymorphicKeyMap<T> polymorphicMap<T extends JsonPolymorphic<T>>(
          String key, T Function(Map<String, dynamic>) parse) =>
      JsonPolymorphicKeyMap.parser(key, parse);

  /// A [JsonKey] that parses an optional map of [JsonPolymorphic] objects.
  static JsonOptionalPolymorphicKeyMap<T>
      optionalPolymorphicMap<T extends JsonPolymorphic<T>>(
              String key, T Function(Map<String, dynamic>) parse) =>
          JsonOptionalPolymorphicKeyMap.parser(key, parse);
}

/// A [JsonKey] that parses a [Json] object.
final class JsonObjectKey<T extends Json>
    extends JsonKey<T, Map<String, dynamic>> {
  /// Create a [JsonKey] that parses a [Json] object.
  JsonObjectKey.parser(String key, T Function() parser)
      : super.parser(key, (json) => parser()..parse(json));

  /// Create a [JsonKey] that has already been populated with a value.
  JsonObjectKey.populated(super.key, super.val) : super.populated();

  /// Serialize the populated [Json] object.
  @override
  Map<String, dynamic> serialize(T value) => value.toJson();
}

/// A [JsonKey] that parses an optional [Json] object.
final class JsonOptionalObjectKey<T extends Json>
    extends JsonKey<T?, Map<String, dynamic>?> {
  /// Create a [JsonKey] that parses an optional [Json] object.
  JsonOptionalObjectKey.parser(String key, T Function() parser)
      : super.parser(
            key, (json) => (json != null ? parser() : null)?..parse(json!));

  /// Create a [JsonKey] that has already been populated with a value.
  JsonOptionalObjectKey.populated(super.key, super.val) : super.populated();

  /// Serialize the populated [Json] object.
  @override
  Map<String, dynamic>? serialize(T? value) => value?.toJson();
}
