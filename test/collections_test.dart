import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class SimpleLists extends Equatable {
  final List<String> myStringList;
  final List<double>? myOptionalDoubleList;
  final List<int> myIntList;
  final List<bool> myBoolList;

  const SimpleLists({
    required this.myStringList,
    required this.myIntList,
    required this.myBoolList,
    this.myOptionalDoubleList,
  }) : super();

  factory SimpleLists.fromJson(dynamic json) => parse(SimpleLists.new, json, {
        'myStringList': string.list,
        'myOptionalDoubleList': float.list.optional,
        'myIntList': integer.list,
        'myBoolList': boolean.list,
      });

  @override
  List<Object?> get props =>
      [myStringList, myOptionalDoubleList, myIntList, myBoolList];
}

final class ComplexLists extends Equatable {
  final List<Map<String, SimpleLists>> listOfMapsOfLists;
  final List<SimpleLists>? optionalListofSimpleLists;

  const ComplexLists({
    required this.listOfMapsOfLists,
    this.optionalListofSimpleLists,
  }) : super();

  factory ComplexLists.fromJson(dynamic json) => parse(ComplexLists.new, json, {
        'listOfMapsOfLists': SimpleLists.fromJson.stringMap.list,
        'optionalListofSimpleLists': SimpleLists.fromJson.list.optional,
      });

  @override
  List<Object?> get props => [listOfMapsOfLists, optionalListofSimpleLists];
}

final class SimpleMaps extends Equatable {
  final Map<String, String> myStringMap;
  final Map<String, double>? myOptionalDoubleMap;
  final Map<String, int> myIntMap;
  final Map<String, bool> myBoolMap;

  const SimpleMaps({
    required this.myStringMap,
    required this.myIntMap,
    required this.myBoolMap,
    this.myOptionalDoubleMap,
  }) : super();

  factory SimpleMaps.fromJson(dynamic json) => parse(SimpleMaps.new, json, {
        'myStringMap': string.stringMap,
        'myOptionalDoubleMap': float.stringMap.optional,
        'myIntMap': integer.stringMap,
        'myBoolMap': boolean.stringMap,
      });

  @override
  List<Object?> get props =>
      [myStringMap, myOptionalDoubleMap, myIntMap, myBoolMap];
}

final class ComplexMaps extends Equatable {
  final Map<String, List<SimpleMaps>> mapOfListsOfMaps;
  final Map<String, SimpleMaps>? optionalMapOfSimpleMaps;

  const ComplexMaps({
    required this.mapOfListsOfMaps,
    this.optionalMapOfSimpleMaps,
  }) : super();

  factory ComplexMaps.fromJson(dynamic json) => parse(ComplexMaps.new, json, {
        'mapOfListsOfMaps': SimpleMaps.fromJson.list.stringMap,
        'optionalMapOfSimpleMaps': SimpleMaps.fromJson.stringMap.optional,
      });

  @override
  List<Object?> get props => [mapOfListsOfMaps, optionalMapOfSimpleMaps];
}

final class DeeplyNestedPrimitiveCollection extends Equatable {
  final List<List<List<List<List<List<List<List<List<List<int>>>>>>>>>>
      deepList;

  const DeeplyNestedPrimitiveCollection({
    required this.deepList,
  }) : super();

  factory DeeplyNestedPrimitiveCollection.fromJson(Map<String, dynamic> json) =>
      parse(DeeplyNestedPrimitiveCollection.new, json, {
        'deepList': integer.list.list.list.list.list.list.list.list.list.list,
      });

  @override
  List<Object?> get props => [deepList];
}

final class DeeplyNestedCollection extends Equatable {
  final List<List<List<List<List<List<List<List<List<List<SimpleLists>>>>>>>>>>
      deepList;

  const DeeplyNestedCollection({
    required this.deepList,
  }) : super();

  factory DeeplyNestedCollection.fromJson(Map<String, dynamic> json) =>
      parse(DeeplyNestedCollection.new, json, {
        'deepList': SimpleLists
            .fromJson.list.list.list.list.list.list.list.list.list.list
      });

  @override
  List<Object?> get props => [deepList];
}

void main() {
  test('Deserializing lists', () {
    final testLists1 = SimpleLists(
      myStringList: ['testStr', 'testStr2'],
      myIntList: [10, 5],
      myBoolList: [true, false],
    );

    final testLists2 = SimpleLists(
      myStringList: ['testStr3', 'testStr4'],
      myIntList: [15, 20],
      myBoolList: [false, true],
      myOptionalDoubleList: [12.5, 10.0],
    );

    final testListsJson1 = {
      'myStringList': ['testStr', 'testStr2'],
      'myIntList': [10, 5],
      'myBoolList': [true, false],
    };

    final testListsJson2 = {
      'myStringList': ['testStr3', 'testStr4'],
      'myIntList': [15, 20],
      'myBoolList': [false, true],
      'myOptionalDoubleList': [12.5, 10.0],
    };

    final testComplexLists = ComplexLists(
      listOfMapsOfLists: [
        {'test1': testLists1},
        {'test2': testLists2}
      ],
      optionalListofSimpleLists: [testLists1, testLists2],
    );

    final testComplexListsJson = {
      'listOfMapsOfLists': [
        {
          'test1': testListsJson1,
        },
        {
          'test2': testListsJson2,
        }
      ],
      'optionalListofSimpleLists': [testListsJson1, testListsJson2],
    };

    expect(SimpleLists.fromJson(testListsJson1), testLists1);
    expect(SimpleLists.fromJson(testListsJson2), testLists2);
    expect(ComplexLists.fromJson(testComplexListsJson), testComplexLists);
  });

  test('Deserializing maps', () {
    final testMaps1 = SimpleMaps(
      myStringMap: {'test1': 'testStr', 'test2': 'testStr2'},
      myIntMap: {'test1': 10, 'test2': 5},
      myBoolMap: {'test1': true, 'test2': false},
    );

    final testMaps2 = SimpleMaps(
      myStringMap: {'test3': 'testStr3', 'test4': 'testStr4'},
      myIntMap: {'test3': 15, 'test4': 20},
      myBoolMap: {'test3': false, 'test4': true},
      myOptionalDoubleMap: {'test3': 12.5, 'test4': 10.0},
    );

    final testMapsJson1 = {
      'myStringMap': {'test1': 'testStr', 'test2': 'testStr2'},
      'myIntMap': {'test1': 10, 'test2': 5},
      'myBoolMap': {'test1': true, 'test2': false},
    };

    final testMapsJson2 = {
      'myStringMap': {'test3': 'testStr3', 'test4': 'testStr4'},
      'myIntMap': {'test3': 15, 'test4': 20},
      'myBoolMap': {'test3': false, 'test4': true},
      'myOptionalDoubleMap': {'test3': 12.5, 'test4': 10.0},
    };

    final testComplexMaps = ComplexMaps(
      mapOfListsOfMaps: {
        'test1': [testMaps1],
        'test2': [testMaps2]
      },
      optionalMapOfSimpleMaps: {'test1': testMaps1, 'test2': testMaps2},
    );

    final testComplexMapsJson = {
      'mapOfListsOfMaps': {
        'test1': [testMapsJson1],
        'test2': [testMapsJson2]
      },
      'optionalMapOfSimpleMaps': {
        'test1': testMapsJson1,
        'test2': testMapsJson2
      },
    };

    expect(SimpleMaps.fromJson(testMapsJson1), testMaps1);
    expect(SimpleMaps.fromJson(testMapsJson2), testMaps2);
    expect(ComplexMaps.fromJson(testComplexMapsJson), testComplexMaps);
  });

  test('Deserializing deeply nested collections', () {
    final testDeeplyNested = DeeplyNestedPrimitiveCollection(
      deepList: [
        [
          [
            [
              [
                [
                  [
                    [
                      [
                        [1, 2]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
    );

    final testDeeplyNestedJson = {
      'deepList': [
        [
          [
            [
              [
                [
                  [
                    [
                      [
                        [1, 2]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    };
    expect(DeeplyNestedPrimitiveCollection.fromJson(testDeeplyNestedJson),
        testDeeplyNested);

    final testDeeplyNestedComplex = DeeplyNestedCollection(
      deepList: [
        [
          [
            [
              [
                [
                  [
                    [
                      [
                        [
                          SimpleLists(
                              myStringList: ['testStr'],
                              myIntList: [1],
                              myBoolList: [true]),
                          SimpleLists(
                              myStringList: ['testStr2'],
                              myIntList: [2],
                              myBoolList: [false])
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
    );

    final testDeeplyNestedComplexJson = {
      'deepList': [
        [
          [
            [
              [
                [
                  [
                    [
                      [
                        [
                          {
                            'myStringList': ['testStr'],
                            'myIntList': [1],
                            'myBoolList': [true]
                          },
                          {
                            'myStringList': ['testStr2'],
                            'myIntList': [2],
                            'myBoolList': [false]
                          }
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    };

    expect(DeeplyNestedCollection.fromJson(testDeeplyNestedComplexJson),
        testDeeplyNestedComplex);
  });
}
