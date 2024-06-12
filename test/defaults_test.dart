import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class SimpleDefaults extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;

  const SimpleDefaults({
    required this.myString,
    required this.myInt,
    this.myDouble = 12.5,
    this.myBool = true,
  }) : super();

  static const List<String> keys = ['myString', 'myDouble', 'myInt', 'myBool'];

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class ComplexDefaults extends Equatable {
  final SimpleDefaults object;
  final List<bool> boolList;

  const ComplexDefaults({
    this.object = const SimpleDefaults(
      myInt: -1,
      myDouble: -100.5,
      myBool: false,
      myString: 'defaultStr',
    ),
    this.boolList = const [false, true, false],
  }) : super();

  static const List<String> keys = ['object', 'boolList'];

  @override
  List<Object?> get props => [object, boolList];
}

void main() {
  registerJson<SimpleDefaults>(SimpleDefaults.new, SimpleDefaults.keys);
  registerJson<ComplexDefaults>(ComplexDefaults.new, ComplexDefaults.keys);

  test('Deserializing primitive defaults', () {
    final testDefault1 = SimpleDefaults(
      myString: 'testStr',
      myDouble: 12.5,
      myInt: 10,
      myBool: false,
    );

    final testDefaultJson1 = {
      'myString': 'testStr',
      'myDouble': 12.5,
      'myInt': 10,
      'myBool': false,
    };

    final testDefault2 = SimpleDefaults(
      myString: 'testStr2',
      myInt: 5,
      myDouble: 12.5,
      myBool: true,
    );

    final testDefaultJson2 = {'myString': 'testStr2', 'myInt': 5};

    expect(fromJson<SimpleDefaults>(testDefaultJson1), testDefault1);
    expect(fromJson<SimpleDefaults>(testDefaultJson2), testDefault2);
  });

  test('Deserializing more complex defaults', () {
    final testDefault1 = ComplexDefaults(
        boolList: [true, false],
        object: SimpleDefaults(
          myString: 'defaultStr',
          myInt: -1,
          myDouble: -100.5,
          myBool: false,
        ));
    final testDefaultJson1 = {
      'boolList': [true, false]
    };

    final testDefault2 = ComplexDefaults(
      object: SimpleDefaults(
        myString: 'testStr',
        myInt: 10,
        myDouble: 12.5,
        myBool: true,
      ),
      boolList: [false, true, false],
    );

    final testDefaultJson2 = {
      'object': {'myString': 'testStr', 'myInt': 10}
    };

    final completelyEmptyDefault = ComplexDefaults(
      object: SimpleDefaults(
        myBool: false,
        myDouble: -100.5,
        myInt: -1,
        myString: 'defaultStr',
      ),
      boolList: [false, true, false],
    );
    final completelyEmptyJson = <String, dynamic>{};

    expect(fromJson<ComplexDefaults>(testDefaultJson1), testDefault1);
    expect(fromJson<ComplexDefaults>(testDefaultJson2), testDefault2);
    expect(
        fromJson<ComplexDefaults>(completelyEmptyJson), completelyEmptyDefault);
  });
}
