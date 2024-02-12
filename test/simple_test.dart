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

void main() {
  registerType<TestObject>(TestObject.new, TestObject.nonPrimitiveMembers);

  final object1 =
      TestObject(myString: 'testStr', myDouble: 12.5, myInt: 10, myBool: false);

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

  test(
    'Simple deserialization test',
    () {
      expect(parse<TestObject>(objectJson1), object1);
      expect(parse<TestObject>(objectJson2), object2);
    },
  );
}
