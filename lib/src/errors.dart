part of '../parse_json.dart';

/// Indicates that a required property is missing in the JSON object.
final class PropertyMissingError extends Error {
  /// The error message.
  String get message =>
      'Property missing while parsing $json using $constructor. '
      'Missing property path: $missingPropertyName. Missing property type: '
      '$missingPropertyType';

  /// The JSON object that is being parsed.
  final dynamic json;

  /// The constructor that is being used to parse the JSON object.
  final Function constructor;

  /// The type of the missing property.
  final Type missingPropertyType;

  /// The name of the missing property.
  final String missingPropertyName;

  /// Constructs a [PropertyMissingError] to be thrown.
  PropertyMissingError({
    required this.json,
    required this.constructor,
    required this.missingPropertyType,
    required this.missingPropertyName,
  }) : super();

  @override
  String toString() => message;
}

/// Indicates that a property has an invalid type in the JSON object.
final class InvalidTypeError extends Error {
  /// The error message.
  String get message => 'Type mismatch while parsing $json using $constructor. '
      'Property: $propertyName. Expected type: $expectedType. '
      'Actual type: $actualType.';

  /// The JSON object that is being parsed.
  final dynamic json;

  /// The constructor that is being used to parse the JSON object.
  final Function? constructor;

  /// The expected type of the property.
  final Type expectedType;

  /// The actual type of the property.
  final Type actualType;

  /// The name of the property.
  final String propertyName;

  /// Constructs an [InvalidTypeError] to be thrown.
  InvalidTypeError({
    required this.json,
    required this.constructor,
    required this.expectedType,
    required this.actualType,
    required this.propertyName,
  }) : super();

  @override
  String toString() => message;
}

/// Thrown when calling `parse`. Indicates that the provided properties map does
/// not match the provided constructor.
final class InvalidPropertiesError extends Error {
  /// The error message.
  String get message => 'Invalid properties while parsing $constructor. '
      'Properties: $properties.';

  /// The constructor that is being used to parse the JSON object.
  final Function constructor;

  /// A map of properties that are invalid.
  final Map<String, JsonProperty<dynamic>> properties;

  /// Constructs an [InvalidPropertiesError] to be thrown.
  InvalidPropertiesError({
    required this.constructor,
    required this.properties,
  }) : super();

  @override
  String toString() => message;
}
