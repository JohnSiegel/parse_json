part of 'json_map.dart';

/// A [JsonKey] that parses a map of strings.
final class JsonStringMap extends _JsonPrimitiveMap<String> {
  JsonStringMap.parser(super.key) : super.parser();

  JsonStringMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional map of strings.
final class JsonOptionalStringMap extends _JsonOptionalPrimitiveMap<String> {
  JsonOptionalStringMap.parser(super.key) : super.parser();

  JsonOptionalStringMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of ints.
final class JsonIntMap extends _JsonPrimitiveMap<int> {
  JsonIntMap.parser(super.key) : super.parser();

  JsonIntMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional map of doubles.
final class JsonOptionalIntMap extends _JsonOptionalPrimitiveMap<int> {
  JsonOptionalIntMap.parser(super.key) : super.parser();

  JsonOptionalIntMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of doubles.
final class JsonDoubleMap extends _JsonPrimitiveMap<double> {
  JsonDoubleMap.parser(super.key) : super.parser();

  JsonDoubleMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional map of doubles.
final class JsonOptionalDoubleMap extends _JsonOptionalPrimitiveMap<double> {
  JsonOptionalDoubleMap.parser(super.key) : super.parser();

  JsonOptionalDoubleMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of booleans.
final class JsonBooleanMap extends _JsonPrimitiveMap<bool> {
  JsonBooleanMap.parser(super.key) : super.parser();

  JsonBooleanMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional map of booleans.
final class JsonOptionalBooleanMap extends _JsonOptionalPrimitiveMap<bool> {
  JsonOptionalBooleanMap.parser(super.key) : super.parser();

  JsonOptionalBooleanMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of [Json] objects.
final class JsonObjectKeyMap<T extends Json>
    extends _JsonMap<T, Map<String, dynamic>> {
  JsonObjectKeyMap.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor()..parse(json));

  JsonObjectKeyMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>> serialize(Map<String, T> value) =>
      value.map((k, v) => MapEntry(k, v.toJson()));
}

/// A [JsonKey] that parses an optional map of [Json] objects.
final class JsonOptionalObjectKeyMap<T extends Json>
    extends _JsonOptionalMap<T, Map<String, dynamic>> {
  JsonOptionalObjectKeyMap.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor()..parse(json));

  JsonOptionalObjectKeyMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>>? serialize(Map<String, T>? value) =>
      value?.map((k, v) => MapEntry(k, v.toJson()));
}

/// A [JsonKey] that parses a map of [JsonPolymorphic] objects.
final class JsonPolymorphicKeyMap<T extends JsonPolymorphic<T>>
    extends _JsonMap<T, Map<String, dynamic>> {
  JsonPolymorphicKeyMap.parser(
      String key, T Function(Map<String, dynamic>) parse)
      : super.parser(key, parse);

  JsonPolymorphicKeyMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>> serialize(Map<String, T> value) =>
      value.map((k, v) => MapEntry(k, v.toJson()));
}

/// A [JsonKey] that parses an optional map of [JsonPolymorphic] objects.
final class JsonOptionalPolymorphicKeyMap<T extends JsonPolymorphic<T>>
    extends _JsonOptionalMap<T, Map<String, dynamic>> {
  JsonOptionalPolymorphicKeyMap.parser(
      String key, T Function(Map<String, dynamic>) parse)
      : super.parser(key, parse);

  JsonOptionalPolymorphicKeyMap.populated(super.key, super.val)
      : super.populated();

  @override
  Map<String, Map<String, dynamic>>? serialize(Map<String, T>? value) =>
      value?.map((k, v) => MapEntry(k, v.toJson()));
}
