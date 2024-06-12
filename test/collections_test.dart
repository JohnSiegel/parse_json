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

  static const List<String> keys = [
    'myStringList',
    'myOptionalDoubleList',
    'myIntList',
    'myBoolList'
  ];

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

  static const List<String> keys = [
    'listOfMapsOfLists',
    'optionalListofSimpleLists'
  ];

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

  static const List<String> keys = [
    'myStringMap',
    'myOptionalDoubleMap',
    'myIntMap',
    'myBoolMap'
  ];

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

  static const List<String> keys = [
    'mapOfListsOfMaps',
    'optionalMapOfSimpleMaps'
  ];

  @override
  List<Object?> get props => [mapOfListsOfMaps, optionalMapOfSimpleMaps];
}

void main() {
  registerJson<SimpleLists>(SimpleLists.new, SimpleLists.keys);
  registerJson<SimpleMaps>(SimpleMaps.new, SimpleMaps.keys);
  registerJson<ComplexLists>(ComplexLists.new, ComplexLists.keys);
  registerJson<ComplexMaps>(ComplexMaps.new, ComplexMaps.keys);

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

    expect(fromJson<SimpleLists>(testListsJson1), testLists1);
    expect(fromJson<SimpleLists>(testListsJson2), testLists2);
    expect(fromJson<ComplexLists>(testComplexListsJson), testComplexLists);
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

    expect(fromJson<SimpleMaps>(testMapsJson1), testMaps1);
    expect(fromJson<SimpleMaps>(testMapsJson2), testMaps2);
    expect(fromJson<ComplexMaps>(testComplexMapsJson), testComplexMaps);
  });
}
