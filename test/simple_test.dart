import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class TestObject extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;

  const TestObject({
    required this.myString,
    required this.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  static const List<String> keys = ['myString', 'myDouble', 'myInt', 'myBool'];

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class TestObject2 extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;

  const TestObject2({
    required String notMyString,
    required double notMyDouble,
    required int notMyInt,
    required bool notMyBool,
  })  : myString = notMyString,
        myDouble = notMyDouble,
        myInt = notMyInt,
        myBool = notMyBool,
        super();

  static const List<String> keys = [
    'notMyString',
    'notMyDouble',
    'notMyInt',
    'notMyBool'
  ];

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class NestedObject extends Equatable {
  final TestObject testObject;
  final TestObject2 testObject2;

  const NestedObject({
    required this.testObject,
    required this.testObject2,
  }) : super();

  static const List<String> keys = ['testObject', 'testObject2'];

  @override
  List<Object?> get props => [testObject, testObject2];
}

void main() {
  registerJson<TestObject>(TestObject.new, TestObject.keys);
  registerJson<TestObject2>(TestObject2.new, TestObject2.keys);
  registerJson<NestedObject>(NestedObject.new, NestedObject.keys);

  test(
    'Simple deserialization',
    () {
      final object1 = TestObject(
          myString: 'testStr', myDouble: 12.5, myInt: 10, myBool: false);

      final objectJson1 = {
        'myString': 'testStr',
        'myDouble': 12.5,
        'myInt': 10,
        'myBool': false,
      };

      final object2 = TestObject(
          myString: 'testStr2', myDouble: 102.5, myInt: -5, myBool: true);

      final objectJson2 = {
        'myString': 'testStr2',
        'myDouble': 102.5,
        'myInt': -5,
        'myBool': true,
      };

      expect(fromJson<TestObject>(objectJson1), object1);
      expect(fromJson<TestObject>(objectJson2), object2);
    },
  );

  test(
    'Simple deserialization test with different constructor name',
    () {
      final object1 = TestObject2(
        notMyString: 'testStr',
        notMyDouble: 12.5,
        notMyInt: 10,
        notMyBool: false,
      );

      final objectJson1 = {
        'notMyString': 'testStr',
        'notMyDouble': 12.5,
        'notMyInt': 10,
        'notMyBool': false,
      };

      final object2 = TestObject2(
        notMyString: 'testStr2',
        notMyDouble: 102.5,
        notMyInt: -5,
        notMyBool: true,
      );

      final objectJson2 = {
        'notMyString': 'testStr2',
        'notMyDouble': 102.5,
        'notMyInt': -5,
        'notMyBool': true,
      };

      expect(fromJson<TestObject2>(objectJson1), object1);
      expect(fromJson<TestObject2>(objectJson2), object2);
    },
  );

  test(
    'Nested object deserialization',
    () {
      final object1 = TestObject(
          myString: 'testStr', myDouble: 12.5, myInt: 10, myBool: false);
      final object2 = TestObject2(
          notMyString: 'testStr2',
          notMyDouble: 102.5,
          notMyInt: -5,
          notMyBool: true);
      final nestedObject =
          NestedObject(testObject: object1, testObject2: object2);
      final nestedObjectJson = {
        'testObject': {
          'myString': 'testStr',
          'myDouble': 12.5,
          'myInt': 10,
          'myBool': false,
        },
        'testObject2': {
          'notMyString': 'testStr2',
          'notMyDouble': 102.5,
          'notMyInt': -5,
          'notMyBool': true,
        },
      };

      expect(fromJson<NestedObject>(nestedObjectJson), nestedObject);
    },
  );
}
