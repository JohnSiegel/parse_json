part of '../parse_json.dart';

/// A property that can be parsed from JSON.
sealed class JsonProperty<T> {
  /// The type of the property.
  Type get type => T;

  /// Makes a property optional.
  OptionalType<T> get optional;

  /// Makes a property a list.
  ListType<T> get list;

  /// Makes a property a map with key type [K].
  MapType<K, T> map<K>();

  /// Makes a property a map with key type [String].
  MapType<String, T> get stringMap => map();

  /// Makes a property a map with key type [int].
  MapType<int, T> get intMap => map();

  /// Constructs a constant [JsonProperty].
  const JsonProperty() : super();
}

/// A property that is represented the same way in JSON as it is in Dart.
final class _Primitive<T> extends JsonProperty<T> {
  T fromJson(dynamic json) => json as T;

  /// Wraps the [fromJson] function in a [ListType]. This is used to indicate a
  /// property with a primitives type is a list.
  @override
  ListType<T> get list => ListType(fromJson);

  /// Wraps the [fromJson] function in a [MapType]. This is used to indicate a
  /// property with a primitives type is a map with key type [K].
  @override
  MapType<K, T> map<K>() => MapType(fromJson);

  /// Wraps the [fromJson] function in an [OptionalType]. This is used to
  /// indicate a property with a primitives type can be null.
  @override
  OptionalType<T> get optional => OptionalType(fromJson);

  /// Constructs a constant [_Primitive].
  const _Primitive() : super();
}

/// For string properties.
const string = _Primitive<String>();

/// For int properties.
const integer = _Primitive<int>();

/// For double properties.
const float = _Primitive<double>();

/// For bool properties.
const boolean = _Primitive<bool>();

/// A property that's type is defined by the user, or that is a collection of
/// user defined types.
sealed class _UserDefined<T> extends JsonProperty<T> {
  /// A constructor that takes a json data and returns a Dart object.
  Function get function;

  /// Wraps the [function] in an [OptionalType]. This is used to indicate a
  /// property with a user defined type can be null.
  @override
  OptionalType<T> get optional => OptionalType(function);

  /// Wraps the [function] in a [ListType]. This is used to indicate a property
  /// with a user defined type is a list.
  @override
  ListType<T> get list => ListType(function);

  /// Wraps the [function] in a [MapType]. This is used to indicate a property
  /// with a user defined type is a map with key type [K].
  @override
  MapType<K, T> map<K>() => MapType(function);

  /// Constructs a constant [_UserDefined].
  const _UserDefined() : super();
}

/// Convenience extension for creating [_UserDefined] properties from
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
final class RequiredType<T> extends _UserDefined<T> {
  /// A function that takes a json data and returns a Dart object.
  @override
  final Function function;

  /// Constructs a constant [RequiredType].
  const RequiredType(this.function) : super();
}

/// A user-defined property that is optional in the JSON.
final class OptionalType<T> extends _UserDefined<T?> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Handles the nullability of the input data.
  @override
  Function get function =>
      (dynamic json) => json != null ? Function.apply(_function, [json]) : null;

  /// Constructs a constant [OptionalType].
  const OptionalType(this._function) : super();
}

/// A user-defined property that is a list of user-defined types.
final class ListType<T> extends _UserDefined<List<T>> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Maps the input list to a list of Dart objects.
  @override
  List<T> Function(List<dynamic> json) get function =>
      // ignore: avoid_types_on_closure_parameters
      (final List<dynamic> json) => [
            for (final element in json) Function.apply(_function, [element])
          ].cast();

  /// Constructs a constant [ListType].
  const ListType(this._function) : super();
}

/// A user-defined property that is a map of user-defined types.
final class MapType<K, T> extends _UserDefined<Map<K, T>> {
  /// A function that takes a json data and returns a Dart object.
  final Function _function;

  /// Maps the input map to a map of Dart objects.
  @override
  Map<K, T> Function(Map<K, dynamic> json) get function =>
      // ignore: avoid_types_on_closure_parameters
      (final Map<K, dynamic> json) => {
            for (final key in json.keys)
              key: Function.apply(_function, [json[key]])
          }.cast();

  /// Constructs a constant [MapType].
  const MapType(this._function) : super();
}
