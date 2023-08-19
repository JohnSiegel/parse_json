part of 'json_primitive.dart';

/// Parse a primitive value. (identity function)
T parsePrimitive<T>(T serialized) => serialized;

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
