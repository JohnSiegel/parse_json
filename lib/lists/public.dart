part of 'json_list.dart';

/// A [JsonKey] that parses a list of strings.
final class JsonStringList extends _JsonPrimitiveList<String> {
  JsonStringList.parser(super.key) : super.parser();

  JsonStringList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional list of strings.
final class JsonOptionalStringList extends _JsonOptionalPrimitiveList<String> {
  JsonOptionalStringList.parser(super.key) : super.parser();

  JsonOptionalStringList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of ints.
final class JsonIntList extends _JsonPrimitiveList<int> {
  JsonIntList.parser(super.key) : super.parser();

  JsonIntList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional list of ints.
final class JsonOptionalIntList extends _JsonOptionalPrimitiveList<int> {
  JsonOptionalIntList.parser(super.key) : super.parser();

  JsonOptionalIntList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of doubles.
final class JsonDoubleList extends _JsonPrimitiveList<double> {
  JsonDoubleList.parser(super.key) : super.parser();

  JsonDoubleList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional list of doubles.
final class JsonOptionalDoubleList extends _JsonOptionalPrimitiveList<double> {
  JsonOptionalDoubleList.parser(super.key) : super.parser();

  JsonOptionalDoubleList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of booleans.
final class JsonBooleanList extends _JsonPrimitiveList<bool> {
  JsonBooleanList.parser(super.key) : super.parser();

  JsonBooleanList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses an optional list of booleans.
final class JsonOptionalBooleanList extends _JsonOptionalPrimitiveList<bool> {
  JsonOptionalBooleanList.parser(super.key) : super.parser();

  JsonOptionalBooleanList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of [Json] objects.
final class JsonObjectKeyList<T extends Json> extends _JsonList<T, dynamic> {
  JsonObjectKeyList.parser(String key, T Function() parserConstructor)
      : super.parser(key,
            (json) => parserConstructor()..parse(json as Map<String, dynamic>));

  JsonObjectKeyList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>> serialize(List<T> value) =>
      value.map((e) => e.toJson()).toList();
}

/// A [JsonKey] that parses an optional list of [Json] objects.
final class JsonOptionalObjectKeyList<T extends Json>
    extends _JsonOptionalList<T, dynamic> {
  JsonOptionalObjectKeyList.parser(String key, T Function() parserConstructor)
      : super.parser(key,
            (json) => parserConstructor()..parse(json as Map<String, dynamic>));

  JsonOptionalObjectKeyList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>>? serialize(List<T>? value) =>
      value?.map((e) => e.toJson()).toList();
}

/// A [JsonKey] that parses a list of [JsonPolymorphic] objects.
final class JsonPolymorphicKeyList<T extends JsonPolymorphic<T>>
    extends _JsonList<T, dynamic> {
  JsonPolymorphicKeyList.parser(
      String key, T Function(Map<String, dynamic>) parse)
      : super.parser(key, (json) => parse(json as Map<String, dynamic>));

  JsonPolymorphicKeyList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>> serialize(List<T> value) =>
      value.map((e) => e.toJson()).toList();
}

/// A [JsonKey] that parses an optional list of [JsonPolymorphic] objects.
final class JsonOptionalPolymorphicKeyList<T extends JsonPolymorphic<T>>
    extends _JsonOptionalList<T, dynamic> {
  JsonOptionalPolymorphicKeyList.parser(
      String key, T Function(Map<String, dynamic>) parse)
      : super.parser(key, (json) => parse(json as Map<String, dynamic>));

  JsonOptionalPolymorphicKeyList.populated(super.key, super.val)
      : super.populated();

  @override
  List<Map<String, dynamic>>? serialize(List<T>? value) =>
      value?.map((e) => e.toJson()).toList();
}
