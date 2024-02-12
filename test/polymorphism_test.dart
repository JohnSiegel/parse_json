import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

base class TestPolymorphic extends Equatable {
  static const polymorphicKey = 'type';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final String myString;
  final double myDouble;

  const TestPolymorphic({
    required this.myString,
    required this.myDouble,
  }) : super();

  @override
  List<Object?> get props => [myString, myDouble];
}

final class TestPolymorphicA extends TestPolymorphic {
  static const polymorphicId = 'A';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final int myInt;
  final bool myBool;

  const TestPolymorphicA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  @override
  List<Object?> get props => [...super.props, myInt, myBool];
}

final class TestPolymorphicB extends TestPolymorphic {
  static const polymorphicId = 'B';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final List<int> myIntList;
  final List<bool> myBoolList;

  const TestPolymorphicB({
    required super.myString,
    required super.myDouble,
    required this.myIntList,
    required this.myBoolList,
  }) : super();

  @override
  List<Object?> get props => [...super.props, myIntList, myBoolList];
}

void main() {
  registerType<TestPolymorphicA>(
      TestPolymorphicA.new, TestPolymorphicA.nonPrimitiveMembers);
  registerType<TestPolymorphicB>(
      TestPolymorphicB.new, TestPolymorphicB.nonPrimitiveMembers);
  registerPolymorphicType<TestPolymorphic>(TestPolymorphic.polymorphicKey, {
    TestPolymorphicA.polymorphicId: TestPolymorphicA,
    TestPolymorphicB.polymorphicId: TestPolymorphicB
  }, (
    TestPolymorphic.new,
    TestPolymorphic.nonPrimitiveMembers
  ));

  test('Deserialize polymorphic types', () {
    final testPolymorphicA = TestPolymorphicA(
      myString: 'testStr',
      myDouble: 12.5,
      myInt: 10,
      myBool: false,
    );

    final testPolymorphicB = TestPolymorphicB(
      myString: 'testStr',
      myDouble: 12.5,
      myIntList: [1, 2, 3],
      myBoolList: [true, false, true],
    );

    final testPolymorphicJsonA = {
      'type': 'A',
      'myString': 'testStr',
      'myDouble': 12.5,
      'myInt': 10,
      'myBool': false,
    };

    final testPolymorphicJsonB = {
      'type': 'B',
      'myString': 'testStr',
      'myDouble': 12.5,
      'myIntList': [1, 2, 3],
      'myBoolList': [true, false, true],
    };

    final testPolymorphic = TestPolymorphic(myDouble: 5.3, myString: 'hey');
    final testPolymorphicJson = {
      'myString': 'hey',
      'myDouble': 5.3,
    };

    expect(parse<TestPolymorphicA>(testPolymorphicJsonA), testPolymorphicA);
    expect(parse<TestPolymorphicB>(testPolymorphicJsonB), testPolymorphicB);
    expect(parse<TestPolymorphic>(testPolymorphicJson), testPolymorphic);
    expect(parse<TestPolymorphic>(testPolymorphicJsonA), testPolymorphicA);
    expect(parse<TestPolymorphic>(testPolymorphicJsonB), testPolymorphicB);
  });
}
