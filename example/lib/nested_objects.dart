import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

final class SimpleObject extends Equatable {
  final String myString;
  final double myDouble;

  const SimpleObject({
    required this.myString,
    required this.myDouble,
  });

  factory SimpleObject.fromJson(Map<String, dynamic> json) =>
      parse(SimpleObject.new, json, {
        'myString': primitive,
        'myDouble': primitive,
      });

  @override
  List<Object?> get props => [myString, myDouble];
}

final class ComplexObject extends Equatable {
  final List<SimpleObject> exampleList;
  final Map<String, SimpleObject> exampleMap;
  final SimpleObject? exampleObject;

  const ComplexObject({
    required this.exampleList,
    required this.exampleMap,
    required this.exampleObject,
  });

  factory ComplexObject.fromJson(Map<String, dynamic> json) =>
      parse(ComplexObject.new, json, {
        'exampleList': SimpleObject.fromJson.list,
        'exampleMap': SimpleObject.fromJson.stringMap,
        'exampleObject': SimpleObject.fromJson.optional,
      });

  @override
  List<Object?> get props => [exampleList, exampleMap, exampleObject];
}

void nestedObjects() {
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
