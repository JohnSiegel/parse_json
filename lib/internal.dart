import 'constructor_data.dart';

final Map<Type, ConstructorData> constructors = {};
final Map<Type, String> polymorphicKeyMapping = {};

dynamic parseInternal(ConstructorData constructorData, dynamic json) {
  switch (constructorData) {
    case OptionalConstructorData():
      return constructorData.parse(json);
    case ListConstructorData():
      if (json is! List) {
        throw Exception(
            'Value is not a List, got ${json.runtimeType} instead.');
      }
      return constructorData.parse(json);
    case MapConstructorData():
      if (json is! Map) {
        throw Exception('Value is not a Map, got ${json.runtimeType} instead.');
      }
      return constructorData.parse(json);
    case NormalConstructorData(
        constructor: final constructor,
        type: final type
      ):
      if (json is! Map<String, dynamic>) {
        throw Exception('Value is not a Map<String, dynamic>, got '
            '${json.runtimeType} instead.');
      }
      final parsed = <String, dynamic>{};
      for (final key in constructorData.nonPrimitiveMembers.keys) {
        final memberType = constructorData.nonPrimitiveMembers[key]!;
        final memberConstructor = constructors[memberType];
        if (memberConstructor == null) {
          throw Exception('No constructor found for type: $memberType');
        }
        final jsonValue = json[key];
        if (jsonValue == null &&
            memberConstructor is! OptionalConstructorData) {
          throw Exception(
              "No value found for key: $key, but it is required. It's "
              'possible you meant to make $key of type Optional<$memberType>.');
        } else {
          parsed[key] = parseInternal(memberConstructor, json[key]);
        }
      }
      parsed.addEntries(json.entries.where((element) =>
          !constructorData.nonPrimitiveMembers.keys.contains(element.key) &&
          element.key != polymorphicKeyMapping[type]));
      return Function.apply(constructor, [],
          parsed.map((key, value) => MapEntry(Symbol(key), value)));
    case PolymorphicConstructorData(
        polymorphicKey: final polymorphicKey,
        constructor: final defaultConstructor,
        derivedTypes: final derivedTypes,
      ):
      if (json is! Map<String, dynamic>) {
        throw Exception('Value is not a Map<String, dynamic>, got '
            '${json.runtimeType} instead.');
      }
      final typeId = json[polymorphicKey];
      if (typeId == null) {
        if (defaultConstructor != null) {
          return parseInternal(defaultConstructor, json);
        } else {
          throw Exception('No value found for key: $polymorphicKey, but it is '
              'required. It\'s possible you meant to provide a '
              'defaultConstructor.');
        }
      } else {
        final derivedType = derivedTypes[typeId];
        if (derivedType == null) {
          throw Exception(
              'No derivedType found for type: $typeId. Available types: '
              '${derivedTypes.keys}');
        }
        final constructorData = constructors[derivedType];
        if (constructorData == null) {
          throw Exception('No constructor found for type: $derivedType');
        }
        return parseInternal(
            constructorData,
            Map.fromEntries(
                json.entries.where((entry) => entry.key != polymorphicKey)));
      }
  }
}
