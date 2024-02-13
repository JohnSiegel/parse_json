part of '../parse_json.dart';

/// Recursively parses a json object into a Dart object via dynamic invocation.
///
/// [parseData] The information used to parse the JSON object.
///
/// [json] The JSON object to parse.
dynamic _parseInternal(_ParseData parseData, Map<String, dynamic> json) {
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
                    missingPropertyName: key,
                    missingPropertyType: definition.type,
                  );

              final jsonValue = json[key];

              void invalidType() => throw InvalidTypeError(
                    actualType: jsonValue.runtimeType,
                    constructor: parseData.constructor,
                    expectedType: definition.type,
                    json: json,
                    propertyName: key,
                  );

              dynamic handleUserDefinedType(Function function) {
                try {
                  return Function.apply(function, [jsonValue]);
                } on TypeError catch (_) {
                  invalidType();
                } on InvalidTypeError catch (invalidTypeError) {
                  throw InvalidTypeError(
                    actualType: invalidTypeError.actualType,
                    constructor: parseData.constructor,
                    expectedType: invalidTypeError.expectedType,
                    json: json,
                    propertyName: '$key${invalidTypeError.propertyName != '' ?
                        // Append previous property name if it exists
                        '.${invalidTypeError.propertyName}' : ''}',
                  );
                } on PropertyMissingError catch (propertyMissingError) {
                  throw PropertyMissingError(
                    constructor: parseData.constructor,
                    json: json,
                    missingPropertyName:
                        '$key.${propertyMissingError.missingPropertyName}',
                    missingPropertyType:
                        propertyMissingError.missingPropertyType,
                  );
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
                case OptionalType(function: final function) ||
                      DefaultType(function: final function):
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
      } on NoSuchMethodError catch (_) {
        throw InvalidPropertiesError(
          constructor: parseData.constructor,
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

/// Throws an [InvalidTypeError] if [json] is not of type a
/// [Map<String, dynamic>].
Map<String, dynamic> _checkJsonType(
  dynamic json,
  Function? constructor,
  Type T,
) {
  if (json is! Map<String, dynamic>) {
    throw InvalidTypeError(
      actualType: json.runtimeType,
      constructor: constructor,
      expectedType: T,
      json: json,
      propertyName: '',
    );
  } else {
    return json;
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
///
/// Throws [PropertyMissingError] if a property is missing in the JSON object.
///
/// Throws [InvalidTypeError] if a property has an invalid type in the JSON
/// object.
///
/// Throws [InvalidPropertiesError] if the provided properties map does not
/// match the provided constructor.
T parse<T>(
  Function constructor,
  dynamic json,
  Map<String, JsonProperty<dynamic>> properties,
) =>
    _parseInternal(DefinedType(constructor, properties),
        _checkJsonType(json, constructor, T)) as T;

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
///
/// Throws [PropertyMissingError] if a property is missing in the JSON object.
///
/// Throws [InvalidTypeError] if a property has an invalid type in the JSON
/// object.
///
/// Throws [InvalidPropertiesError] if the provided properties map does not
/// match the provided constructor.
T polymorphicParse<T>(
  String key,
  dynamic json,
  Map<String, T Function(dynamic json)> derivedTypes, {
  DefinedType? baseDefinition,
}) =>
    _parseInternal(_Polymorphic(key, derivedTypes, baseDefinition),
        _checkJsonType(json, null, T)) as T;
