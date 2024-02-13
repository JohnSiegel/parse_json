part of '../parse_json.dart';

/// Recursively parses a json object into a Dart object via dynamic invocation.
///
/// [parseData] The information used to parse the JSON object.
///
/// [json] The JSON object to parse.
dynamic _parseInternal(
  _ParseData parseData,
  Map<String, dynamic> json,
) {
  switch (parseData) {
    case DefinedType(constructor: final constructor, keys: final keys):
      try {
        return Function.apply(constructor, [], {
          for (final key in keys.keys)
            Symbol(key): () {
              final definition = keys[key]!;

              void propertyMissing() => throw PropertyMissingError(
                    json: json,
                    constructor: parseData.constructor,
                    message:
                        'Property missing in json. Constructor: $constructor. '
                        'Missing property: $key. Missing property type: '
                        '${definition.type}',
                    missingPropertyName: key,
                    missingPropertyType: definition.type,
                  );

              final jsonValue = json[key];

              void invalidType() => throw InvalidTypeError(
                    actualType: jsonValue.runtimeType,
                    constructor: parseData.constructor,
                    expectedType: definition.type,
                    json: json,
                    message:
                        'Type mismatch in json. Constructor: $constructor. '
                        'Property: $key. Expected type: ${definition.type}. '
                        'Actual type: ${jsonValue.runtimeType}.',
                    propertyName: key,
                  );

              dynamic handleUserDefinedType(Function function) {
                try {
                  return Function.apply(function, [jsonValue]);
                } on TypeError catch (_) {
                  invalidType();
                }
              }

              switch (definition) {
                case _Primitive():
                  if (jsonValue != null) {
                    if (jsonValue.runtimeType != definition.type) {
                      invalidType();
                    }
                    return jsonValue;
                  } else {
                    propertyMissing();
                  }
                case OptionalType(function: final function):
                  return handleUserDefinedType(function);
                case _UserDefined(function: final function):
                  if (jsonValue != null) {
                    return handleUserDefinedType(function);
                  } else {
                    propertyMissing();
                  }
              }
            }()
        });
      } on NoSuchMethodError catch (e) {
        throw InvalidPropertiesError(
          constructor: parseData.constructor,
          message: 'Invalid properties used for constructor. Trying to call '
              'constructor $constructor with properties $keys. Error: $e',
          properties: keys,
        );
      }
    case _Polymorphic(
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
/// should have a corresponding namedParameter in [constructor].
T parse<T>(
  Function constructor,
  Map<String, dynamic> json,
  Map<String, JsonProperty<dynamic>> properties,
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
  Map<String, dynamic> json,
  Map<String, T Function(Map<String, dynamic> json)> derivedTypes, {
  DefinedType? baseDefinition,
}) =>
    _parseInternal(_Polymorphic(key, derivedTypes, baseDefinition), json) as T;
