json_types
-----

[![License](https://img.shields.io/github/license/JohnSiegel/json_types?style=flat-square&logo=github)](https://github.com/JohnSiegel/json_types/blob/main/LICENSE) [![Pub.dev](https://img.shields.io/pub/v/json_types.svg?style=flat-square&logo=data:image/png;base64,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)](https://pub.dartlang.org/packages/json_types) [![Github Stars](https://img.shields.io/github/stars/JohnSiegel/json_types?style=flat-square&logo=github)](https://github.com/JohnSiegel/json_types) 

# Type-safe JSON serialization/deserialization

### *NO CODE GENERATION OR REFLECTION*

## Example:

* [Simple types](#simple-types)
* [Maps](#maps)
* [Lists](#lists)
* [Complex data types](#complex-data-types)
* [Full example](example/lib/main.dart)

## Simple types:
```dart
/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// properties.
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

/// Create a [TestObject] from in-memory data.
final object1 = TestObject.populated(str: 'testStr', d: 12.5, i: 10, b: false);

/// A JSON representation of [object1].
final objectJson1 = {
  'myStringKey': 'testStr',
  'myDoubleKey': 12.5,
  'myIntKey': 10,
  'myBoolKey': false,
};

/// Parse the JSON representation of [object1] into a [TestObject].
TestObject.parse(objectJson1);

/// Convert [object1] to JSON.
object1.toJson();

/// Create a [TestObject] from in-memory data.
final object2 =
    TestObject.populated(str: 'testStr2', d: 102.5, i: -5, b: true);

/// A JSON representation of [object2].
final objectJson2 = {
  'string': 'testStr2',
  'double': 102.5,
  'int': -5,
  'bool': true,
};

TestObject.parse(objectJson2); /// Deserialize JSON into a [TestObject].
object2.toJson(); /// Serialize a [TestObject] into JSON.
```

## Maps:
```dart
/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// maps.
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

/// Create a [TestMaps] from in-memory data.
final maps = TestMaps.populated(
  stringMap: {'string1': 'value1', 'string2': 'value2'},
  doubleMap: {'double1': 2.5, 'double2': 3.5},
  intMap: {'int1': 3, 'int2': 4},
  booleanMap: {'bool1': false, 'bool2': true},
  objectMap: {'object1': object1, 'object2': object2},
);

/// A JSON representation of [maps].
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

TestMaps.parse(mapsJson); /// Deserialize JSON into a [TestMaps].
maps.toJson(); /// Serialize a [TestMaps] into JSON.
```

## Lists:
```dart
/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// lists.
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

/// Create a [TestLists] from in-memory data.
final lists = TestLists.populated(
  stringList: ['string1', 'string2'],
  doubleList: [2.5, 3.5],
  intList: [3, 4],
  boolList: [false, true],
  objectList: [object1, object2],
);

/// A JSON representation of [lists].
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

TestLists.parse(listsJson); /// Deserialize JSON into a [TestLists].
lists.toJson(); /// Serialize a [TestLists] into JSON.
```

## Complex data types:
```dart
/// Example of a class that extends [Json] and uses [JsonKey]s to define
/// complex data types.
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

/// Create a [TestAggregateObject] from in-memory data.
final aggregateObject =
    TestAggregateObject.populated(object: object, maps: maps, lists: lists);

/// A JSON representation of [aggregateObject].
final aggregateObjectJson = {
  'object': objectJson,
  'maps': mapsJson,
  'lists': listsJson,
};

TestAggregateObject.parse(aggregateObjectJson); /// Deserialize JSON into a [TestAggregateObject].
aggregateObject.toJson(); /// Serialize a [TestAggregateObject] into JSON.
```

### License/Disclaimer

See [LICENSE](https://github.com/JohnSiegel/json_types/blob/main/LICENSE)
