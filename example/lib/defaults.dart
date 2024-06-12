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
      myString: 'defaultStr',
      myInt: -1,
      myDouble: -100.5,
      myBool: false,
    ),
    required this.boolList,
  }) : super();

  static const List<String> keys = ['object', 'boolList'];

  @override
  List<Object?> get props => [object, boolList];
}

void defaults() {
  registerJson<SimpleDefaults>(SimpleDefaults.new, SimpleDefaults.keys);
  registerJson<ComplexDefaults>(ComplexDefaults.new, ComplexDefaults.keys);

  final testDefault = SimpleDefaults(
    myString: 'testStr2',
    myInt: 5,
    myDouble: 12.5,
    myBool: true,
  );

  final testDefaultJson = {'myString': 'testStr2', 'myInt': 5};

  check(fromJson<SimpleDefaults>(testDefaultJson) == testDefault);

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

  check(
      fromJson<ComplexDefaults>(testComplexDefaultJson) == testComplexDefault);
}
