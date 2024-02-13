import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

base class ExamplePolymorphic extends Equatable {
  static const polymorphicKey = 'type';

  final String myString;
  final double myDouble;

  const ExamplePolymorphic({
    required this.myString,
    required this.myDouble,
  }) : super();

  factory ExamplePolymorphic.fromJson(Map<String, dynamic> json) =>
      polymorphicParse(
          polymorphicKey,
          json,
          {
            ExamplePolymorphicA.polymorphicId: ExamplePolymorphicA.fromJson,
            ExamplePolymorphicB.polymorphicId: ExamplePolymorphicB.fromJson,
          },
          baseDefinition: DefinedType(ExamplePolymorphic.new, {
            'myString': primitive,
            'myDouble': primitive,
          }));

  @override
  List<Object?> get props => [myString, myDouble];
}

final class ExamplePolymorphicA extends ExamplePolymorphic {
  static const polymorphicId = 'A';

  final int myInt;
  final bool myBool;

  const ExamplePolymorphicA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  factory ExamplePolymorphicA.fromJson(Map<String, dynamic> json) =>
      parse(ExamplePolymorphicA.new, json, {
        'myString': primitive,
        'myDouble': primitive,
        'myInt': primitive,
        'myBool': primitive,
      });

  @override
  List<Object?> get props => [...super.props, myInt, myBool];
}

final class ExamplePolymorphicB extends ExamplePolymorphic {
  static const polymorphicId = 'B';

  final List<String> stringList;
  final List<double> doubleList;

  const ExamplePolymorphicB({
    required super.myString,
    required super.myDouble,
    required this.stringList,
    required this.doubleList,
  }) : super();

  factory ExamplePolymorphicB.fromJson(Map<String, dynamic> json) =>
      parse(ExamplePolymorphicB.new, json, {
        'myString': primitive,
        'myDouble': primitive,
        'stringList': primitive,
        'doubleList': primitive,
      });

  @override
  List<Object?> get props => [...super.props, stringList, doubleList];
}

void polymorphism() {
  final polymorphicA = ExamplePolymorphicA(
    myString: 'exampleStr',
    myDouble: 12.5,
    myInt: 10,
    myBool: false,
  );

  final polymorphicJsonA = {
    ExamplePolymorphic.polymorphicKey: ExamplePolymorphicA.polymorphicId,
    'myString': 'exampleStr',
    'myDouble': 12.5,
    'myInt': 10,
    'myBool': false,
  };

  final polymorphicB = ExamplePolymorphicB(
    myString: 'exampleStr',
    myDouble: 12.5,
    stringList: ['string1', 'string2'],
    doubleList: [2.5, 3.5],
  );

  final polymorphicJsonB = {
    ExamplePolymorphic.polymorphicKey: ExamplePolymorphicB.polymorphicId,
    'myString': 'exampleStr',
    'myDouble': 12.5,
    'stringList': ['string1', 'string2'],
    'doubleList': [2.5, 3.5],
  };

  final base = ExamplePolymorphic(
    myString: 'exampleStr',
    myDouble: 12.5,
  );

  final baseJson = {
    'myString': 'exampleStr',
    'myDouble': 12.5,
  };

  check(ExamplePolymorphicA.fromJson(polymorphicJsonA) == polymorphicA);
  check(ExamplePolymorphicB.fromJson(polymorphicJsonB) == polymorphicB);
  check(ExamplePolymorphic.fromJson(baseJson) == base);

  check(ExamplePolymorphic.fromJson(polymorphicJsonA) == polymorphicA);
  check(ExamplePolymorphic.fromJson(polymorphicJsonB) == polymorphicB);
}
