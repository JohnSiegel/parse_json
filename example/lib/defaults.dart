import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

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

  factory SimpleDefaults.fromJson(Map<String, dynamic> json) =>
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

  factory ComplexDefaults.fromJson(Map<String, dynamic> json) =>
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

void defaults() {
  final testDefault = SimpleDefaults(
    myString: 'testStr2',
    myInt: 5,
    myDouble: 12.5,
    myBool: true,
  );

  final testDefaultJson = {'myString': 'testStr2', 'myInt': 5};

  check(SimpleDefaults.fromJson(testDefaultJson) == testDefault);

  final testComplexDefault = ComplexDefaults(
      boolList: [true, false],
      object: SimpleDefaults(
        myString: 'defaultStr',
        myInt: -1,
        myDouble: -100.5,
        myBool: false,
      ));
  final testComplexDefaultJson = {
    'boolList': [true, false]
  };

  check(ComplexDefaults.fromJson(testComplexDefaultJson) == testComplexDefault);
}
