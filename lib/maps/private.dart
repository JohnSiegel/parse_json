part of 'json_map.dart';

/// A [JsonKey] that parses a map.
sealed class _JsonMap<T, Serializable>
    extends JsonKey<Map<String, T>, Map<String, Serializable>> {
  _JsonMap.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (map) => map.map((k, v) => MapEntry(k, parser(v))));

  _JsonMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional map.
sealed class _JsonOptionalMap<T, Serializable>
    extends JsonKey<Map<String, T>?, Map<String, Serializable>?> {
  _JsonOptionalMap.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (map) => map?.map((k, v) => MapEntry(k, parser(v))));

  _JsonOptionalMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of primitives.
sealed class _JsonPrimitiveMap<T> extends _JsonMap<T, T> {
  _JsonPrimitiveMap.parser(String key) : super.parser(key, parsePrimitive);

  _JsonPrimitiveMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, T> serialize(Map<String, T> val) => val;
}

/// A [JsonKey] that parses an optional map of primitives.
sealed class _JsonOptionalPrimitiveMap<T> extends _JsonOptionalMap<T, T> {
  _JsonOptionalPrimitiveMap.parser(String key)
      : super.parser(key, parsePrimitive);

  _JsonOptionalPrimitiveMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, T>? serialize(Map<String, T>? val) => val;
}
