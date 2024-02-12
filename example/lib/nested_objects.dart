import 'package:equatable/equatable.dart';
import 'package:parse_json/optional.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

final class SimpleObject extends Equatable {
  final String myString;
  final double myDouble;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const SimpleObject({
    required this.myString,
    required this.myDouble,
  });

  factory SimpleObject.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [myString, myDouble];
}

final class ComplexObject extends Equatable {
  final List<SimpleObject> exampleList;
  final Map<String, SimpleObject> exampleMap;
  final SimpleObject? exampleObject;

  static const Map<String, Type> nonPrimitiveMembers = {
    'exampleList': List<SimpleObject>,
    'exampleMap': Map<String, SimpleObject>,
    'exampleObject': Optional<SimpleObject>,
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

void nestedObjects() {
  registerType<SimpleObject>(
      SimpleObject.new, SimpleObject.nonPrimitiveMembers);
  registerType<ComplexObject>(
      ComplexObject.new, ComplexObject.nonPrimitiveMembers);

  final object1 = SimpleObject(myString: 'exampleStr', myDouble: 12.5);
  final objectJson1 = {'myString': 'exampleStr', 'myDouble': 12.5};

  check(SimpleObject.fromJson(objectJson1) == object1);

  final object2 = SimpleObject(myString: 'exampleStr2', myDouble: 102.5);
  final objectJson2 = {'myString': 'exampleStr2', 'myDouble': 102.5};

  check(SimpleObject.fromJson(objectJson2) == object2);

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

  check(ComplexObject.fromJson(complexObjectJson) == complexObject);
}
