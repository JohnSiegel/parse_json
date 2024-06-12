import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

final class ExampleObject extends Equatable {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;
  final String? myOptionalString;
  final int? myOptionalInt;

  const ExampleObject({
    required this.myString,
    required this.myDouble,
    required this.myInt,
    required this.myBool,
    this.myOptionalString,
    this.myOptionalInt,
  });

  static const List<String> keys = [
    'myString',
    'myDouble',
    'myInt',
    'myBool',
    'myOptionalString',
    'myOptionalInt'
  ];

  @override
  List<Object?> get props =>
      [myString, myDouble, myInt, myBool, myOptionalString, myOptionalInt];
}

void simpleObjects() {
  registerJson<ExampleObject>(ExampleObject.new, ExampleObject.keys);

  final object1 = ExampleObject(
    myString: 'exampleStr',
    myDouble: 12.5,
    myInt: 10,
    myBool: false,
  );

  final objectJson1 = {
    'myString': 'exampleStr',
    'myDouble': 12.5,
    'myInt': 10,
    'myBool': false,
  };

  check(fromJson<ExampleObject>(objectJson1) == object1);

  final object2 = ExampleObject(
    myString: 'exampleStr2',
    myDouble: 102.5,
    myInt: -5,
    myBool: true,
    myOptionalString: 'hello',
    myOptionalInt: 42,
  );

  final objectJson2 = {
    'myString': 'exampleStr2',
    'myDouble': 102.5,
    'myInt': -5,
    'myBool': true,
    'myOptionalString': 'hello',
    'myOptionalInt': 42,
  };

  check(fromJson<ExampleObject>(objectJson2) == object2);
}
