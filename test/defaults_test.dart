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
    required this.myDouble,
    required this.myBool,
  }) : super();

  factory SimpleDefaults.fromJson(dynamic json) =>
      parse(SimpleDefaults.new, json, {
        'myString': string,
        'myDouble': float.withDefault(12.5),
        'myInt': integer,
        'myBool': boolean.withDefault(true),
      });

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class ComplexDefaults extends Equatable {
  final SimpleDefaults object;
  final List<bool> boolList;

  const ComplexDefaults({
    required this.object,
    required this.boolList,
  }) : super();

  factory ComplexDefaults.fromJson(dynamic json) =>
      parse(ComplexDefaults.new, json, {
        'object': SimpleDefaults.fromJson.withDefault(
          SimpleDefaults(
            myString: 'defaultStr',
            myInt: -1,
            myDouble: -100.5,
            myBool: false,
          ),
        ),
        'boolList': boolean.list.withDefault([false, true, false])
      });

  @override
  List<Object?> get props => [object, boolList];
}

void main() {
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

    expect(SimpleDefaults.fromJson(testDefaultJson1), testDefault1);
    expect(SimpleDefaults.fromJson(testDefaultJson2), testDefault2);
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

    expect(ComplexDefaults.fromJson(testDefaultJson1), testDefault1);
    expect(ComplexDefaults.fromJson(testDefaultJson2), testDefault2);
    expect(
        ComplexDefaults.fromJson(completelyEmptyJson), completelyEmptyDefault);
  });
}
