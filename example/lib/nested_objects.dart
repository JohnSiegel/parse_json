import 'package:equatable/equatable.dart';
import 'package:parse_json/optional.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

final class ExampleObject extends Equatable {
  final String myString;
  final double myDouble;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const ExampleObject({
    required this.myString,
    required this.myDouble,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [myString, myDouble];
}

final object1 = ExampleObject(myString: 'exampleStr', myDouble: 12.5);
final objectJson1 = {'myString': 'exampleStr', 'myDouble': 12.5};

final object2 = ExampleObject(myString: 'exampleStr2', myDouble: 102.5);
final objectJson2 = {'myString': 'exampleStr2', 'myDouble': 102.5};

final class ComplexObject extends Equatable {
  final List<ExampleObject> exampleList;
  final Map<String, ExampleObject> exampleMap;
  final ExampleObject? exampleObject;

  static const Map<String, Type> nonPrimitiveMembers = {
    'exampleList': List<ExampleObject>,
    'exampleMap': Map<String, ExampleObject>,
    'exampleObject': Optional<ExampleObject>,
  };

  const ComplexObject({
    required this.exampleList,
    required this.exampleMap,
    required this.exampleObject,
  });

  factory ComplexObject.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [exampleList, exampleMap, exampleObject];
}

final complexObject = ComplexObject(
  exampleList: [object1, object2],
  exampleMap: {'object1': object1, 'object2': object2},
  exampleObject: object1,
);

final complexObjectJson = {
  'exampleList': [objectJson1, objectJson2],
  'exampleMap': {'object1': objectJson1, 'object2': objectJson2},
  'exampleObject': objectJson1,
};

void nestedObjects() {
  registerType<ExampleObject>(
      ExampleObject.new, ExampleObject.nonPrimitiveMembers);
  registerType<ComplexObject>(
      ComplexObject.new, ComplexObject.nonPrimitiveMembers);

  check(ExampleObject.fromJson(objectJson1) == object1);
  check(ExampleObject.fromJson(objectJson2) == object2);

  check(ComplexObject.fromJson(complexObjectJson) == complexObject);
}
