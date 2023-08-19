part of 'json_list.dart';

/// A [JsonKey] that parses a list of strings.
final class JsonStringList extends _JsonPrimitiveList<String> {
  JsonStringList.parser(super.key) : super.parser();

  JsonStringList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of ints.
final class JsonIntList extends _JsonPrimitiveList<int> {
  JsonIntList.parser(super.key) : super.parser();

  JsonIntList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of doubles.
final class JsonDoubleList extends _JsonPrimitiveList<double> {
  JsonDoubleList.parser(super.key) : super.parser();

  JsonDoubleList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of booleans.
final class JsonBooleanList extends _JsonPrimitiveList<bool> {
  JsonBooleanList.parser(super.key) : super.parser();

  JsonBooleanList.populated(super.key, super.val) : super.populated();
}

/// A [JsonKey] that parses a list of [Json] objects.
final class JsonObjectList<T extends Json>
    extends _JsonList<T, Map<String, dynamic>> {
  JsonObjectList.parser(String key, T Function() parserConstructor)
      : super.parser(key, (json) => parserConstructor()..parse(json));

  JsonObjectList.populated(super.key, super.val) : super.populated();

  @override
  List<Map<String, dynamic>> serialize(List<T> value) =>
      value.map((e) => e.toJson()).toList();
}
