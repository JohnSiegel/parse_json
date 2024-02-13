import '../parse_json.dart';

/// Recursively parses a json object into a Dart object via dynamic invocation.
///
/// [parseData] The information used to parse the JSON object.
///
/// [json] The JSON object to parse.
dynamic _parseInternal(
  ParseData parseData,
  dynamic json,
) {
  if (json is! Map<String, dynamic>) {
    throw Exception(
        'Value is not a Map<String, dynamic>, got ${json.runtimeType} instead. '
        'Value: $json');
  }
  switch (parseData) {
    case DefinedType(constructor: final constructor, keys: final keys):
      return Function.apply(constructor, [], {
        for (final key in keys.keys)
          Symbol(key): switch (keys[key]!) {
            Primitive() => json[key],
            UserDefined(function: final function) =>
              Function.apply(function, [json[key]]),
          }
      });
    case Polymorphic(
        key: final key,
        derivedTypes: final derivedTypes,
        baseDefinition: final baseDefinition
      ):
      final typeId = json[key];
      if (typeId == null) {
        if (baseDefinition == null) {
          throw Exception(
              'No type id found in json and no base definition provided');
        } else {
          return _parseInternal(baseDefinition, json);
        }
      }

      final constructor = derivedTypes[typeId];
      if (constructor == null) {
        throw Exception('No constructor found for type id $typeId');
      }

      return Function.apply(constructor, [
        Map.fromEntries(json.entries.where((element) => element.key != key))
      ]);
  }
}

/// Parses a json object into a Dart object via dynamic invocation.
///
/// [constructor] A constructor that takes a json data and returns a Dart
/// object.
///
/// [json] The JSON object to parse.
///
/// [properties] A map of keys to their corresponding [JsonProperty]. Each key
T parse<T>(
  Function constructor,
  dynamic json,
  Map<String, JsonProperty> properties,
) =>
    _parseInternal(DefinedType(constructor, properties), json) as T;

/// Parses a json object into a Dart object via dynamic invocation. This will
/// also call the correct constructor based on the json value at [key].
///
/// [key] The key in the JSON object that determines the type.
///
/// [json] The JSON object to parse.
///
/// [derivedTypes] A map of type ids to constructors.
///
/// [baseDefinition] An optional base definition for the polymorphic type.
T polymorphicParse<T>(
  String key,
  dynamic json,
  Map<String, T Function(Map<String, dynamic> json)> derivedTypes, {
  DefinedType? baseDefinition,
}) =>
    _parseInternal(Polymorphic<T>(key, derivedTypes, baseDefinition), json)
        as T;
