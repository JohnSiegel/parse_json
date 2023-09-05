import 'package:json_types/json.dart';
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

sealed class TestPolymorphic extends JsonPolymorphic<TestPolymorphic> {
  final stringJson = Json.string('string');
  final doubleJson = Json.double('double');

  String get myString => stringJson.value;
  double get myDouble => doubleJson.value;

  TestPolymorphic() : super();

  TestPolymorphic.parse(super.json) : super.parse();

  factory TestPolymorphic.polymorphicParse(Map<String, dynamic> json) =>
      JsonPolymorphic.polymorphicParse(json, [
        TestPolymorphicA.parser,
        TestPolymorphicB.parser,
      ]);

  TestPolymorphic.populated({
    required String str,
    required double d,
  }) : super() {
    stringJson.populate(str);
    doubleJson.populate(d);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys => [stringJson, doubleJson];
}

final class TestPolymorphicA extends TestPolymorphic {
  final intJson = Json.int('int');
  final boolJson = Json.boolean('bool');

  int get myInt => intJson.value;
  bool get myBool => boolJson.value;

  TestPolymorphicA.parser() : super();

  TestPolymorphicA.parse(super.json) : super.parse();

  TestPolymorphicA.populated({
    required super.str,
    required super.d,
    required int i,
    required bool b,
  }) : super.populated() {
    intJson.populate(i);
    boolJson.populate(b);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [...super.keys, intJson, boolJson];
}

final class TestPolymorphicB extends TestPolymorphic {
  final stringListJson = Json.stringList('stringList');
  final doubleListJson = Json.doubleList('doubleList');

  List<String> get myStringList => stringListJson.value;
  List<double> get myDoubleList => doubleListJson.value;

  TestPolymorphicB.parser() : super();

  TestPolymorphicB.parse(super.json) : super.parse();

  TestPolymorphicB.populated({
    required super.str,
    required super.d,
    required List<String> stringList,
    required List<double> doubleList,
  }) : super.populated() {
    stringListJson.populate(stringList);
    doubleListJson.populate(doubleList);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [...super.keys, stringListJson, doubleListJson];
}

final class TestLists extends Json {
  final stringList = Json.stringList('stringList');
  final doubleList = Json.doubleList('doubleList');
  final intList = Json.intList('intList');
  final boolList = Json.booleanList('boolList');
  final objectList = Json.objectList('objectList', TestObject.parser);
  final polymorphicList =
      Json.polymorphicList('polymorphicList', TestPolymorphic.polymorphicParse);

  List<String> get myStringList => stringList.value;
  List<double> get myDoubleList => doubleList.value;
  List<int> get myIntList => intList.value;
  List<bool> get myBoolList => boolList.value;
  List<TestObject> get myObjectList => objectList.value;
  List<TestPolymorphic> get myPolymorphicList => polymorphicList.value;

  TestLists.parser() : super();

  TestLists.parse(super.json) : super.parse();

  TestLists.populated({
    required List<String> stringList,
    required List<double> doubleList,
    required List<int> intList,
    required List<bool> boolList,
    required List<TestObject> objectList,
    required List<TestPolymorphic> polymorphicList,
  }) : super() {
    this.stringList.populate(stringList);
    this.doubleList.populate(doubleList);
    this.intList.populate(intList);
    this.boolList.populate(boolList);
    this.objectList.populate(objectList);
    this.polymorphicList.populate(polymorphicList);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringList, doubleList, intList, boolList, objectList, polymorphicList];
}

final class TestMaps extends Json {
  final stringMap = Json.stringMap('stringMap');
  final doubleMap = Json.doubleMap('doubleMap');
  final intMap = Json.intMap('intMap');
  final booleanMap = Json.booleanMap('booleanMap');
  final objectMap = Json.objectMap('objectMap', TestObject.parser);
  final polymorphicMap =
      Json.polymorphicMap('polymorphicMap', TestPolymorphic.polymorphicParse);

  Map<String, String> get myStringMap => stringMap.value;
  Map<String, double> get myDoubleMap => doubleMap.value;
  Map<String, int> get myIntMap => intMap.value;
  Map<String, bool> get myBooleanMap => booleanMap.value;
  Map<String, TestObject> get myObjectMap => objectMap.value;
  Map<String, TestPolymorphic> get myPolymorphicMap => polymorphicMap.value;

  TestMaps.parser() : super();

  TestMaps.parse(super.json) : super.parse();

  TestMaps.populated({
    required Map<String, String> stringMap,
    required Map<String, double> doubleMap,
    required Map<String, int> intMap,
    required Map<String, bool> booleanMap,
    required Map<String, TestObject> objectMap,
    required Map<String, TestPolymorphic> polymorphicMap,
  }) : super() {
    this.stringMap.populate(stringMap);
    this.doubleMap.populate(doubleMap);
    this.intMap.populate(intMap);
    this.booleanMap.populate(booleanMap);
    this.objectMap.populate(objectMap);
    this.polymorphicMap.populate(polymorphicMap);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys =>
      [stringMap, doubleMap, intMap, booleanMap, objectMap, polymorphicMap];
}

final class TestAggregateObject extends Json {
  final objectJson = Json.object('object', TestObject.parser);
  final mapsJson = Json.object('maps', TestMaps.parser);
  final listsJson = Json.object('lists', TestLists.parser);
  final polymorphicJson = Json.polymorphic(
      'polymorphic', [TestPolymorphicA.parser, TestPolymorphicB.parser]);

  TestObject get myObject => objectJson.value;
  TestMaps get myMaps => mapsJson.value;
  TestLists get myLists => listsJson.value;
  TestPolymorphic get myPolymorphic => polymorphicJson.value;

  TestAggregateObject.parser() : super();

  TestAggregateObject.parse(super.json) : super.parse();

  TestAggregateObject.populated({
    required TestObject object,
    required TestMaps maps,
    required TestLists lists,
    required TestPolymorphic polymorphic,
  }) : super() {
    objectJson.populate(object);
    mapsJson.populate(maps);
    listsJson.populate(lists);
    polymorphicJson.populate(polymorphic);
  }

  @override
  List<JsonKey<dynamic, dynamic>> get keys => [
        objectJson,
        mapsJson,
        listsJson,
        polymorphicJson,
      ];
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

  final polymorphicA =
      TestPolymorphicA.populated(str: 'testStr', d: 12.5, i: 10, b: false);

  final polymorphicJsonA = {
    kPolymorphicTypeJsonKey: 'TestPolymorphicA',
    'string': 'testStr',
    'double': 12.5,
    'int': 10,
    'bool': false,
  };

  final polymorphicB = TestPolymorphicB.populated(
      str: 'testStr2',
      d: 102.5,
      stringList: ['string1', 'string2'],
      doubleList: [2.5, 3.5]);

  final polymorphicJsonB = {
    kPolymorphicTypeJsonKey: 'TestPolymorphicB',
    'string': 'testStr2',
    'double': 102.5,
    'stringList': ['string1', 'string2'],
    'doubleList': [2.5, 3.5],
  };

  final maps = TestMaps.populated(
    stringMap: {'string1': 'value1', 'string2': 'value2'},
    doubleMap: {'double1': 2.5, 'double2': 3.5},
    intMap: {'int1': 3, 'int2': 4},
    booleanMap: {'bool1': false, 'bool2': true},
    objectMap: {'object1': object1, 'object2': object2},
    polymorphicMap: {'test': polymorphicA, 'test2': polymorphicB},
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
    'polymorphicMap': {
      'test': {
        kPolymorphicTypeJsonKey: 'TestPolymorphicA',
        'string': 'testStr',
        'double': 12.5,
        'int': 10,
        'bool': false,
      },
      'test2': {
        kPolymorphicTypeJsonKey: 'TestPolymorphicB',
        'string': 'testStr2',
        'double': 102.5,
        'stringList': ['string1', 'string2'],
        'doubleList': [2.5, 3.5],
      },
    },
  };

  final lists = TestLists.populated(
    stringList: ['string1', 'string2'],
    doubleList: [2.5, 3.5],
    intList: [3, 4],
    boolList: [false, true],
    objectList: [object1, object2],
    polymorphicList: [polymorphicA, polymorphicB],
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
    'polymorphicList': [
      {
        kPolymorphicTypeJsonKey: 'TestPolymorphicA',
        'string': 'testStr',
        'double': 12.5,
        'int': 10,
        'bool': false,
      },
      {
        kPolymorphicTypeJsonKey: 'TestPolymorphicB',
        'string': 'testStr2',
        'double': 102.5,
        'stringList': ['string1', 'string2'],
        'doubleList': [2.5, 3.5],
      },
    ],
  };

  final aggregateObject1 = TestAggregateObject.populated(
      object: object1, maps: maps, lists: lists, polymorphic: polymorphicA);

  final aggregateObjectJson1 = {
    'object': objectJson1,
    'maps': mapsJson,
    'lists': listsJson,
    'polymorphic': polymorphicJsonA,
  };

  final aggregateObject2 = TestAggregateObject.populated(
      object: object2, maps: maps, lists: lists, polymorphic: polymorphicB);

  final aggregateObjectJson2 = {
    'object': objectJson2,
    'maps': mapsJson,
    'lists': listsJson,
    'polymorphic': polymorphicJsonB,
  };

  test(
    'JSON serialization',
    () {
      expect(object1.toJson(), objectJson1);
      expect(object2.toJson(), objectJson2);
      expect(maps.toJson(), mapsJson);
      expect(lists.toJson(), listsJson);
      expect(polymorphicA.toJson(), polymorphicJsonA);
      expect(polymorphicB.toJson(), polymorphicJsonB);
      expect(aggregateObject1.toJson(), aggregateObjectJson1);
      expect(aggregateObject2.toJson(), aggregateObjectJson2);
    },
  );

  test('JSON serialization throws for parser', () {
    expect(() => TestObject.parser().toJson(), throwsA(isA<StateError>()));
    expect(() => TestMaps.parser().toJson(), throwsA(isA<StateError>()));
    expect(() => TestLists.parser().toJson(), throwsA(isA<StateError>()));
    expect(
        () => TestPolymorphicA.parser().toJson(), throwsA(isA<StateError>()));
    expect(
        () => TestPolymorphicB.parser().toJson(), throwsA(isA<StateError>()));
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
      expect(TestPolymorphicA.parse(polymorphicJsonA), polymorphicA);
      expect(TestPolymorphicB.parse(polymorphicJsonB), polymorphicB);
      expect(TestAggregateObject.parse(aggregateObjectJson1), aggregateObject1);
      expect(TestAggregateObject.parse(aggregateObjectJson2), aggregateObject2);
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

    expect(polymorphicA.myString, 'testStr');
    expect(polymorphicA.myDouble, 12.5);
    expect(polymorphicA.myInt, 10);
    expect(polymorphicA.myBool, false);

    expect(polymorphicB.myString, 'testStr2');
    expect(polymorphicB.myDouble, 102.5);
    expect(polymorphicB.myStringList, ['string1', 'string2']);
    expect(polymorphicB.myDoubleList, [2.5, 3.5]);

    expect(aggregateObject1.myObject, object1);
    expect(aggregateObject1.myMaps, maps);
    expect(aggregateObject1.myLists, lists);
    expect(aggregateObject1.myPolymorphic, polymorphicA);

    expect(aggregateObject2.myObject, object2);
    expect(aggregateObject2.myMaps, maps);
    expect(aggregateObject2.myLists, lists);
    expect(aggregateObject2.myPolymorphic, polymorphicB);
  });

  test('JSON value getter throws for parser', () {
    expect(() => TestObject.parser().myString, throwsA(isA<StateError>()));
    expect(() => TestMaps.parser().myStringMap, throwsA(isA<StateError>()));
    expect(() => TestLists.parser().myStringList, throwsA(isA<StateError>()));
    expect(
        () => TestPolymorphicA.parser().myString, throwsA(isA<StateError>()));
    expect(
        () => TestPolymorphicB.parser().myString, throwsA(isA<StateError>()));
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
    expect(() => polymorphicA.stringJson.populate('test'),
        throwsA(isA<StateError>()));
    expect(() => polymorphicB.stringJson.populate('test'),
        throwsA(isA<StateError>()));
    expect(() => aggregateObject1.objectJson.populate(object2),
        throwsA(isA<StateError>()));
  });

  test('Polymorphic parse', () {
    final polymorphic1 = TestPolymorphic.polymorphicParse(polymorphicJsonA);
    expect(polymorphic1, polymorphicA);
    final polymorphic2 = TestPolymorphic.polymorphicParse(polymorphicJsonB);
    expect(polymorphic2, polymorphicB);
  });
}
