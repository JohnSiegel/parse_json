part of 'json_primitive.dart';

/// A [JsonKey] that parses a primitive value.
base class _JsonPrimitive<T> extends JsonKey<T, T> {
  _JsonPrimitive.populated(super.key, super.val) : super.populated();

  _JsonPrimitive.parser(String key) : super.parser(key, parsePrimitive);

  /// Serialize a primitive value. (identity function)
  @override
  T serialize(T val) => val;
}
