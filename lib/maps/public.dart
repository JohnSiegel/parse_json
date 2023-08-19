part of 'json_map.dart';

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
      : super.parser(key, (json) => parserConstructor()..parse(json));

  JsonObjectMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, Map<String, dynamic>> serialize(Map<String, T> value) =>
      value.map((k, v) => MapEntry(k, v.toJson()));
}
