import 'package:json/json.dart';

final class TestObject extends Json {
  final stringJson = Json.string('string');
  final doubleJson = Json.double('double');
  final intJson = Json.int('int');
  final boolJson = Json.boolean('bool');

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
