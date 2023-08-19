import 'json_types.dart';

final class TestObject extends Json {
  final stringJson = Json.string('myStringKey');
  final doubleJson = Json.double('myDoubleKey');
  final intJson = Json.int('myIntKey');
  final boolJson = Json.boolean('myBoolKey');

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

final object1 = TestObject.populated(str: 'testStr', d: 12.5, i: 10, b: false);

final objectJson1 = {
  'myStringKey': 'testStr',
  'myDoubleKey': 12.5,
  'myIntKey': 10,
  'myBoolKey': false,
};

final object2 = TestObject.populated(str: 'testStr2', d: 102.5, i: -5, b: true);

final objectJson2 = {
  'string': 'testStr2',
  'double': 102.5,
  'int': -5,
  'bool': true,
};

final class TestMaps extends Json {
  final stringMap = Json.stringMap('myStringMapKey');
  final doubleMap = Json.doubleMap('myDoubleMapKey');
  final intMap = Json.intMap('myIntMapKey');
  final booleanMap = Json.booleanMap('myBooleanMapKey');
  final objectMap = Json.objectMap('myObjectMapKey', TestObject.parser);

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

final class TestLists extends Json {
  final stringList = Json.stringList('myStringListKey');
  final doubleList = Json.doubleList('myDoubleListKey');
  final intList = Json.intList('myIntListKey');
  final boolList = Json.booleanList('myBoolListKey');
  final objectList = Json.objectList('myObjectListKey', TestObject.parser);

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

final class TestAggregateObject extends Json {
  final objectJson = Json.object('myObjectKey', TestObject.parser);
  final mapsJson = Json.object('myMapsKey', TestMaps.parser);
  final listsJson = Json.object('myListsKey', TestLists.parser);

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

final aggregateObject =
    TestAggregateObject.populated(object: object1, maps: maps, lists: lists);

final aggregateObjectJson = {
  'object': objectJson1,
  'maps': mapsJson,
  'lists': listsJson,
};
