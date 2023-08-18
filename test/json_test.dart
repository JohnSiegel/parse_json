import 'package:json/json.dart';
import 'package:test/test.dart';

final class TestObject extends Json {
  final stringJson = Json.string('string');
  final doubleJson = Json.double('double');
  final intJson = Json.int('int');
  final boolJson = Json.boolean('bool');

  String get myString => stringJson.value;
  double get myDouble => doubleJson.value;
  int get myInt => intJson.value;
  bool get myBool => boolJson.value;

  TestObject.parser() : super();

  TestObject.parse(super.json) : super.parse();

  TestObject.populated({
    required String str,
    required double d,
    required int i,
    required bool b,
  }) : super() {
    stringJson.populate(str);
    doubleJson.populate(d);
    intJson.populate(i);
    boolJson.populate(b);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringJson, doubleJson, intJson, boolJson];
}

final class TestLists extends Json {
  final stringList = Json.stringList('stringList');
  final doubleList = Json.doubleList('doubleList');
  final intList = Json.intList('intList');
  final boolList = Json.booleanList('boolList');
  final objectList = Json.objectList('objectList', TestObject.parser);

  List<String> get myStringList => stringList.value;
  List<double> get myDoubleList => doubleList.value;
  List<int> get myIntList => intList.value;
  List<bool> get myBoolList => boolList.value;
  List<TestObject> get myObjectList => objectList.value;

  TestLists.parser() : super();

  TestLists.parse(super.json) : super.parse();

  TestLists.populated({
    required List<String> stringList,
    required List<double> doubleList,
    required List<int> intList,
    required List<bool> boolList,
    required List<TestObject> objectList,
  }) : super() {
    this.stringList.populate(stringList);
    this.doubleList.populate(doubleList);
    this.intList.populate(intList);
    this.boolList.populate(boolList);
    this.objectList.populate(objectList);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringList, doubleList, intList, boolList, objectList];
}

final class TestMaps extends Json {
  final stringMap = Json.stringMap('stringMap');
  final doubleMap = Json.doubleMap('doubleMap');
  final intMap = Json.intMap('intMap');
  final booleanMap = Json.booleanMap('booleanMap');
  final objectMap = Json.objectMap('objectMap', TestObject.parser);

  Map<String, String> get myStringMap => stringMap.value;
  Map<String, double> get myDoubleMap => doubleMap.value;
  Map<String, int> get myIntMap => intMap.value;
  Map<String, bool> get myBooleanMap => booleanMap.value;
  Map<String, TestObject> get myObjectMap => objectMap.value;

  TestMaps.parser() : super();

  TestMaps.parse(super.json) : super.parse();

  TestMaps.populated({
    required Map<String, String> stringMap,
    required Map<String, double> doubleMap,
    required Map<String, int> intMap,
    required Map<String, bool> booleanMap,
    required Map<String, TestObject> objectMap,
  }) : super() {
    this.stringMap.populate(stringMap);
    this.doubleMap.populate(doubleMap);
    this.intMap.populate(intMap);
    this.booleanMap.populate(booleanMap);
    this.objectMap.populate(objectMap);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringMap, doubleMap, intMap, booleanMap, objectMap];
}

final class TestAggregateObject extends Json {
  final objectJson = Json.object('object', TestObject.parser);
  final mapsJson = Json.object('maps', TestMaps.parser);
  final listsJson = Json.object('lists', TestLists.parser);

  TestObject get myObject => objectJson.value;
  TestMaps get myMaps => mapsJson.value;
  TestLists get myLists => listsJson.value;

  TestAggregateObject.parser() : super();

  TestAggregateObject.parse(super.json) : super.parse();

  TestAggregateObject.populated({
    required TestObject object,
    required TestMaps maps,
    required TestLists lists,
  }) : super() {
    objectJson.populate(object);
    mapsJson.populate(maps);
    listsJson.populate(lists);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys => [objectJson, mapsJson, listsJson];
}

void main() {
  final object1 =
      TestObject.populated(str: 'testStr', d: 12.5, i: 10, b: false);

  final objectJson1 = {
    'string': 'testStr',
    'double': 12.5,
    'int': 10,
    'bool': false,
  };

  final object2 =
      TestObject.populated(str: 'testStr2', d: 102.5, i: -5, b: true);

  final objectJson2 = {
    'string': 'testStr2',
    'double': 102.5,
    'int': -5,
    'bool': true,
  };

  final maps = TestMaps.populated(
    stringMap: {'string1': 'value1', 'string2': 'value2'},
    doubleMap: {'double1': 2.5, 'double2': 3.5},
    intMap: {'int1': 3, 'int2': 4},
    booleanMap: {'bool1': false, 'bool2': true},
    objectMap: {'object1': object1, 'object2': object2},
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
    stringList: ['string1', 'string2'],
    doubleList: [2.5, 3.5],
    intList: [3, 4],
    boolList: [false, true],
    objectList: [object1, object2],
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

  final aggregateObject =
      TestAggregateObject.populated(object: object1, maps: maps, lists: lists);

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

  test('JSON serialization throws for parser', () {
    expect(() => TestObject.parser().toJson(), throwsA(isA<StateError>()));
    expect(() => TestMaps.parser().toJson(), throwsA(isA<StateError>()));
    expect(() => TestLists.parser().toJson(), throwsA(isA<StateError>()));
    expect(() => TestAggregateObject.parser().toJson(),
        throwsA(isA<StateError>()));
  });

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

  test('JSON value getters', () {
    expect(object1.myString, 'testStr');
    expect(object1.myDouble, 12.5);
    expect(object1.myInt, 10);
    expect(object1.myBool, false);

    expect(maps.myStringMap, {'string1': 'value1', 'string2': 'value2'});
    expect(maps.myDoubleMap, {'double1': 2.5, 'double2': 3.5});
    expect(maps.myIntMap, {'int1': 3, 'int2': 4});
    expect(maps.myBooleanMap, {'bool1': false, 'bool2': true});
    expect(maps.myObjectMap, {'object1': object1, 'object2': object2});

    expect(lists.myStringList, ['string1', 'string2']);
    expect(lists.myDoubleList, [2.5, 3.5]);
    expect(lists.myIntList, [3, 4]);
    expect(lists.myBoolList, [false, true]);
    expect(lists.myObjectList, [object1, object2]);

    expect(aggregateObject.myObject, object1);
    expect(aggregateObject.myMaps, maps);
    expect(aggregateObject.myLists, lists);
  });

  test('JSON value getter throws for parser', () {
    expect(() => TestObject.parser().myString, throwsA(isA<StateError>()));
    expect(() => TestMaps.parser().myStringMap, throwsA(isA<StateError>()));
    expect(() => TestLists.parser().myStringList, throwsA(isA<StateError>()));
    expect(() => TestAggregateObject.parser().myObject,
        throwsA(isA<StateError>()));
  });

  test('Populated JSON should be immutable', () {
    expect(
        () => object1.stringJson.populate('test'), throwsA(isA<StateError>()));
    expect(() => maps.stringMap.populate({'test': 'test'}),
        throwsA(isA<StateError>()));
    expect(
        () => lists.stringList.populate(['test']), throwsA(isA<StateError>()));
    expect(() => aggregateObject.objectJson.populate(object2),
        throwsA(isA<StateError>()));
  });
}
