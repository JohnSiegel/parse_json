import 'internal.dart';

sealed class ConstructorData {
  const ConstructorData() : super();
}

final class NormalConstructorData extends ConstructorData {
  final Type type;
  final Map<String, Type> nonPrimitiveMembers;
  final Function constructor;

  const NormalConstructorData({
    required this.type,
    required this.nonPrimitiveMembers,
    required this.constructor,
  }) : super();
}

final class OptionalConstructorData<T> extends ConstructorData {
  const OptionalConstructorData() : super();

  T? parse(dynamic json) {
    if (json == null) {
      return null;
    }
    return parseInternal(constructors[T]!, json) as T?;
  }
}

final class ListConstructorData<T> extends ConstructorData {
  ListConstructorData() : super();

  List<T> parse(List<dynamic> json) =>
      json.map((e) => parseInternal(constructors[T]!, e)).cast<T>().toList();
}

final class MapConstructorData<K, T> extends ConstructorData {
  MapConstructorData() : super();

  Map<K, T> parse(Map<K, dynamic> json) => json
      .map((key, e) => MapEntry(key, parseInternal(constructors[T]!, e)))
      .cast<K, T>();
}

final class PolymorphicConstructorData extends ConstructorData {
  final Map<String, Type> derivedTypes;
  final NormalConstructorData? constructor;
  final String polymorphicKey;

  const PolymorphicConstructorData({
    required this.polymorphicKey,
    required this.constructor,
    required this.derivedTypes,
  }) : super();
}
