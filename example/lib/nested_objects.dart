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

  static const List<String> keys = ['myString', 'myDouble'];

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

  static const List<String> keys = [
    'exampleList',
    'exampleMap',
    'exampleObject'
  ];

  @override
  List<Object?> get props => [exampleList, exampleMap, exampleObject];
}

void nestedObjects() {
  registerJson<SimpleObject>(SimpleObject.new, SimpleObject.keys);
  registerJson<ComplexObject>(ComplexObject.new, ComplexObject.keys);

  final object1 = SimpleObject(myString: 'exampleStr', myDouble: 12.5);
  final objectJson1 = {'myString': 'exampleStr', 'myDouble': 12.5};

  check(fromJson<SimpleObject>(objectJson1) == object1);

  final object2 = SimpleObject(myString: 'exampleStr2', myDouble: 102.5);
  final objectJson2 = {'myString': 'exampleStr2', 'myDouble': 102.5};

  check(fromJson<SimpleObject>(objectJson2) == object2);

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

  check(fromJson<ComplexObject>(complexObjectJson) == complexObject);
}
