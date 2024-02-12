import 'constructor_data.dart';
import 'internal.dart';
import 'optional.dart';

void registerListType<T>() {
  constructors[List<T>] = ListConstructorData<T>();
  constructors[List<List<T>>] = ListConstructorData<List<T>>();
  constructors[Map<String, List<T>>] = MapConstructorData<String, List<T>>();
  constructors[Map<int, List<T>>] = MapConstructorData<int, List<T>>();
  registerOptionalType<List<T>>();
}

void registerMapType<K, V>() {
  constructors[Map<K, V>] = MapConstructorData<K, V>();
  constructors[List<Map<K, V>>] = ListConstructorData<Map<K, V>>();
  constructors[Map<String, Map<K, V>>] =
      MapConstructorData<String, Map<K, V>>();
  constructors[Map<int, Map<K, V>>] = MapConstructorData<int, Map<K, V>>();
  registerOptionalType<Map<K, V>>();
}

void registerOptionalType<T>() {
  constructors[Optional<T>] = OptionalConstructorData<T>();
}

void registerContainerTypes<T>() {
  registerOptionalType<T>();
  registerListType<T>();
  registerMapType<String, T>();
  registerMapType<int, T>();
}

void registerType<T>(
  Function constructor,
  Map<String, Type> nonPrimitiveMembers,
) {
  registerContainerTypes<T>();
  constructors[T] = NormalConstructorData(
    type: T,
    constructor: constructor,
    nonPrimitiveMembers: nonPrimitiveMembers,
  );
}

void registerPolymorphicType<T>(
  String key,
  Map<String, Type> derivedTypes, [
  (
    Function constructor,
    Map<String, Type> nonPrimitiveMembers,
  )? defaultConstructor,
]) {
  for (final derivedType in derivedTypes.values) {
    polymorphicKeyMapping[derivedType] = key;
  }
  registerContainerTypes<T>();
  constructors[T] = PolymorphicConstructorData(
    polymorphicKey: key,
    derivedTypes: derivedTypes,
    constructor: defaultConstructor != null
        ? NormalConstructorData(
            type: T,
            constructor: defaultConstructor.$1,
            nonPrimitiveMembers: defaultConstructor.$2,
          )
        : null,
  );
}

T parse<T>(Map<String, dynamic> json) {
  final constructorData = constructors[T];
  if (constructorData == null) {
    throw Exception('No constructor found for type: $T');
  }
  return parseInternal(constructorData, json) as T;
}
