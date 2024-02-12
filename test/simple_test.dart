import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class TestObject extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const TestObject({
    required this.myString,
    required this.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class TestObject2 extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;

  static const Map<String, Type> nonPrimitiveMembers = {};

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

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

void main() {
  registerType<TestObject>(TestObject.new, TestObject.nonPrimitiveMembers);
  registerType<TestObject2>(TestObject2.new, TestObject2.nonPrimitiveMembers);

  test(
    'Simple deserialization test',
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

      expect(parse<TestObject>(objectJson1), object1);
      expect(parse<TestObject>(objectJson2), object2);
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

      expect(parse<TestObject2>(objectJson1), object1);
      expect(parse<TestObject2>(objectJson2), object2);
    },
  );
}
