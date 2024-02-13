import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

base class TestPolymorphic extends Equatable {
  static const polymorphicKey = 'type';

  final String myString;
  final double myDouble;

  const TestPolymorphic({
    required this.myString,
    required this.myDouble,
  }) : super();

  factory TestPolymorphic.fromJson(Map<String, dynamic> json) =>
      polymorphicParse(
          polymorphicKey,
          json,
          {
            TestPolymorphicA.polymorphicId: TestPolymorphicA.fromJson,
            TestPolymorphicB.polymorphicId: TestPolymorphicB.fromJson,
          },
          baseDefinition: DefinedType(TestPolymorphic.new, {
            'myString': primitive,
            'myDouble': primitive,
          }));

  @override
  List<Object?> get props => [myString, myDouble];
}

final class TestPolymorphicA extends TestPolymorphic {
  static const polymorphicId = 'A';

  final int myInt;
  final bool myBool;

  const TestPolymorphicA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  factory TestPolymorphicA.fromJson(Map<String, dynamic> json) =>
      parse(TestPolymorphicA.new, json, {
        'myString': primitive,
        'myDouble': primitive,
        'myInt': primitive,
        'myBool': primitive,
      });

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

  factory TestPolymorphicB.fromJson(Map<String, dynamic> json) =>
      parse(TestPolymorphicB.new, json, {
        'myString': primitive,
        'myDouble': primitive,
        'myIntList': primitive,
        'myBoolList': primitive,
      });

  @override
  List<Object?> get props => [...super.props, myIntList, myBoolList];
}

void main() {
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

    expect(TestPolymorphicA.fromJson(testPolymorphicJsonA), testPolymorphicA);
    expect(TestPolymorphicB.fromJson(testPolymorphicJsonB), testPolymorphicB);
    expect(TestPolymorphic.fromJson(testPolymorphicJson), testPolymorphic);
    expect(TestPolymorphic.fromJson(testPolymorphicJsonA), testPolymorphicA);
    expect(TestPolymorphic.fromJson(testPolymorphicJsonB), testPolymorphicB);
  });
}
