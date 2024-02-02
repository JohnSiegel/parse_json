part of 'json_primitive.dart';

/// Parse a primitive value. (identity function)
T parsePrimitive<T>(T serialized) => serialized;

/// A [JsonKey] that parses a string value.
final class JsonString extends _JsonPrimitive<String> {
  JsonString.populated(super.key, super.val) : super.populated();

  JsonString.parser(super.key) : super.parser();
}

/// A [JsonKey] that parses an optional string value.
final class JsonOptionalString extends _JsonPrimitive<String?> {
  JsonOptionalString.populated(super.key, super.val) : super.populated();

  JsonOptionalString.parser(super.key) : super.parser();
}

/// A [JsonKey] that parses an int value.
final class JsonInt extends _JsonPrimitive<int> {
  JsonInt.parser(super.key) : super.parser();

  JsonInt.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional int value.
final class JsonOptionalInt extends _JsonPrimitive<int?> {
  JsonOptionalInt.populated(super.key, super.val) : super.populated();

  JsonOptionalInt.parser(super.key) : super.parser();
}

/// A [JsonKey] that parses a double value.
final class JsonDouble extends _JsonPrimitive<double> {
  JsonDouble.parser(super.key) : super.parser();

  JsonDouble.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional double value.
final class JsonOptionalDouble extends _JsonPrimitive<double?> {
  JsonOptionalDouble.populated(super.key, super.val) : super.populated();

  JsonOptionalDouble.parser(super.key) : super.parser();
}

/// A [JsonKey] that parses a boolean value.
final class JsonBoolean extends _JsonPrimitive<bool> {
  JsonBoolean.parser(super.key) : super.parser();

  JsonBoolean.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional boolean value.
final class JsonOptionalBoolean extends _JsonPrimitive<bool?> {
  JsonOptionalBoolean.populated(super.key, super.val) : super.populated();

  JsonOptionalBoolean.parser(super.key) : super.parser();
}
