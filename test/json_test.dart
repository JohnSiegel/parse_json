import 'package:test/test.dart';

import 'example.dart';

void main() {
  final object1 = TestObject.populated(
    str: 'testStr',
    d: 12.5,
    i: 10,
    b: false,
  );

  final objectJson1 = {
    'string': 'testStr',
    'double': 12.5,
    'int': 10,
    'bool': false,
  };

  final object2 = TestObject.populated(
    str: 'testStr2',
    d: 102.5,
    i: -5,
    b: true,
  );

  final objectJson2 = {
    'string': 'testStr2',
    'double': 102.5,
    'int': -5,
    'bool': true,
  };

  final maps = TestMaps.populated(
    stringMap: {
      'string1': 'value1',
      'string2': 'value2',
    },
    doubleMap: {
      'double1': 2.5,
      'double2': 3.5,
    },
    intMap: {
      'int1': 3,
      'int2': 4,
    },
    booleanMap: {
      'bool1': false,
      'bool2': true,
    },
    objectMap: {
      'object1': object1,
      'object2': object2,
    },
  );

  final mapsJson = {
    'stringMap': {
      'string1': 'value1',
      'string2': 'value2',
    },
    'doubleMap': {
      'double1': 2.5,
      'double2': 3.5,
    },
    'intMap': {
      'int1': 3,
      'int2': 4,
    },
    'booleanMap': {
      'bool1': false,
      'bool2': true,
    },
    'objectMap': {
      'object1': objectJson1,
      'object2': objectJson2,
    },
  };

  final lists = TestLists.populated(
    stringList: [
      'string1',
      'string2',
    ],
    doubleList: [
      2.5,
      3.5,
    ],
    intList: [
      3,
      4,
    ],
    boolList: [
      false,
      true,
    ],
    objectList: [
      object1,
      object2,
    ],
  );

  final listsJson = {
    'stringList': [
      'string1',
      'string2',
    ],
    'doubleList': [
      2.5,
      3.5,
    ],
    'intList': [
      3,
      4,
    ],
    'boolList': [
      false,
      true,
    ],
    'objectList': [
      objectJson1,
      objectJson2,
    ],
  };

  final aggregateObject = TestAggregateObject.populated(
    object: object1,
    maps: maps,
    lists: lists,
  );

  final aggregateObjectJson = {
    'object': objectJson1,
    'maps': mapsJson,
    'lists': listsJson,
  };

  test(
    'JSON serialization',
    () {
      expect(object1.toJson(), objectJson1);
      expect(object2.toJson(), objectJson2);
      expect(maps.toJson(), mapsJson);
      expect(lists.toJson(), listsJson);
      expect(aggregateObject.toJson(), aggregateObjectJson);
    },
  );

  test(
    'JSON deserialization',
    () {
      expect(TestObject.parse(objectJson1), object1);
      expect(TestObject.parse(objectJson2), object2);
      expect(TestMaps.parse(mapsJson), maps);
      expect(TestLists.parse(listsJson), lists);
      expect(TestAggregateObject.parse(aggregateObjectJson), aggregateObject);
    },
  );
}
