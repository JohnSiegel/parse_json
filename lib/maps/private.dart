part of 'json_map.dart';

/// A [JsonKey] that parses a map.
sealed class _JsonMap<T, Serializable>
    extends JsonKey<Map<String, T>, Map<String, Serializable>> {
  _JsonMap.parser(String key, T Function(Serializable) parser)
      : super.parser(key, (map) => map.map((k, v) => MapEntry(k, parser(v))));

  _JsonMap.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a map of primitives.
sealed class _JsonPrimitiveMap<T> extends _JsonMap<T, T> {
  _JsonPrimitiveMap.parser(String key) : super.parser(key, parsePrimitive);

  _JsonPrimitiveMap.populated(super.key, super.val) : super.populated();

  @override
  Map<String, T> serialize(Map<String, T> val) => val;
}
