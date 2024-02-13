import 'property.dart';

/// Information used to parse a JSON object.
sealed class ParseData {
  /// Constructs a constant [ParseData].
  const ParseData() : super();
}

/// Information used to parse a JSON object with a defined type.
final class DefinedType extends ParseData {
  final Function constructor;
  final Map<String, JsonProperty> keys;

  /// Constructs a constant [DefinedType].
  ///
  /// [constructor] A constructor that takes a json data and returns a Dart
  /// object.
  ///
  /// [keys] A map of keys to their corresponding [JsonProperty]. Each key
  /// should have a corresponding namedParameter in [constructor].
  const DefinedType(this.constructor, this.keys) : super();
}

/// Information used to parse a JSON object with a polymorphic type, and an
/// optional definition for a base type.
final class Polymorphic<T> extends ParseData {
  /// The key in the JSON object that determines the type.
  final String key;

  /// A map of type ids to constructors.
  final Map<String, T Function(Map<String, dynamic> json)> derivedTypes;

  /// An optional base definition for the polymorphic type.
  final DefinedType? baseDefinition;

  /// Constructs a constant [Polymorphic].
  ///
  /// [key] The key in the JSON object that determines the type.
  ///
  /// [derivedTypes] A map of type ids to constructors.
  ///
  /// [baseDefinition] An optional base definition for the polymorphic type.
  const Polymorphic(this.key, this.derivedTypes, [this.baseDefinition])
      : super();
}
