/// A property that can be parsed from JSON.
sealed class JsonProperty {
  /// Constructs a constant [JsonProperty].
  const JsonProperty() : super();
}

/// A property that is represented the same way in JSON as it is in Dart.
final class Primitive extends JsonProperty {
  /// Constructs a constant [Primitive].
  const Primitive() : super();
}

/// A static constant for simplifying the process of defining a [Primitive].
const primitive = Primitive();

/// A property that's type is defined by the user, or that is a collection of
/// user defined types.
sealed class UserDefined<T> extends JsonProperty {
  /// A constructor that takes a json data and returns a Dart object.
  Function get function;

  /// Wraps the [function] in an [OptionalType]. This is used to indicate a
  /// property with a user defined type can be null.
  OptionalType<T> get optional => OptionalType(function);

  /// Wraps the [function] in a [ListType]. This is used to indicate a property
  /// with a user defined type is a list.
  ListType<T> get list => ListType(function);

  /// Wraps the [function] in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [K].
  MapType<K, T> map<K>() => MapType(function);

  /// Wraps the [function] in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [String].
  MapType<String, T> get stringMap => map();

  /// Wraps the [function] in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [int].
  MapType<int, T> get intMap => map();

  /// Constructs a constant [UserDefined].
  const UserDefined() : super();
}

/// Convenience extension for creating [UserDefined] properties from
/// constructors.
extension UserDefinedTypes<T> on T Function(Map<String, dynamic> json) {
  /// Wraps a constructor in a [RequiredType]. This is really just a
  /// convenience method for creating a [RequiredType] from a constructor.
  RequiredType<T> get required => RequiredType(this);

  /// Wraps a constructor in an [OptionalType]. This is used to indicate a
  /// property with a user defined type can be null.
  OptionalType<T> get optional => OptionalType(this);

  /// Wraps a constructor in a [ListType]. This is used to indicate a property
  /// with a user defined type is a list.
  ListType<T> get list => ListType(this);

  /// Wraps a constructor in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [K].
  MapType<K, T> map<K>() => MapType(this);

  /// Wraps a constructor in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [String].
  MapType<String, T> get stringMap => map();

  /// Wraps a constructor in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [int].
  MapType<int, T> get intMap => map();
}

/// A user-defined property that is required to be present in the JSON.
final class RequiredType<T> extends UserDefined<T> {
  /// A function that takes a json data and returns a Dart object.
  @override
  final Function function;

  /// Constructs a constant [RequiredType].
  const RequiredType(this.function) : super();
}

/// A user-defined property that is optional in the JSON.
final class OptionalType<T> extends UserDefined<T?> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Handles the nullability of the input data.
  @override
  Function get function => (dynamic input) =>
      input != null ? Function.apply(_function, [input]) : null;

  /// Constructs a constant [OptionalType].
  const OptionalType(this._function) : super();
}

/// A user-defined property that is a list of user-defined types.
final class ListType<T> extends UserDefined<List<T>> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Maps the input list to a list of Dart objects.
  @override
  List<T> Function(List<dynamic> input) get function =>
      // ignore: avoid_types_on_closure_parameters
      (final List<dynamic> input) => input
          .map((element) => Function.apply(_function, [element]))
          .toList()
          .cast();

  /// Constructs a constant [ListType].
  const ListType(this._function) : super();
}

/// A user-defined property that is a map of user-defined types.
final class MapType<K, T> extends UserDefined<Map<K, T>> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Maps the input map to a map of Dart objects.
  @override
  Map<K, T> Function(Map<K, dynamic> input) get function =>
      // ignore: avoid_types_on_closure_parameters
      (final Map<K, dynamic> input) => input
          .map(
              (key, value) => MapEntry(key, Function.apply(_function, [value])))
          .cast();

  /// Constructs a constant [MapType].
  const MapType(this._function) : super();
}
