import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

base class ExamplePolymorphic extends Equatable {
  static const polymorphicKey = 'type';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final String myString;
  final double myDouble;

  const ExamplePolymorphic({
    required this.myString,
    required this.myDouble,
  }) : super();

  factory ExamplePolymorphic.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [myString, myDouble];
}

final class ExamplePolymorphicA extends ExamplePolymorphic {
  static const polymorphicId = 'A';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final int myInt;
  final bool myBool;

  const ExamplePolymorphicA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
    required this.myBool,
  }) : super();

  factory ExamplePolymorphicA.fromJson(Map<String, dynamic> json) =>
      parse(json);

  @override
  List<Object?> get props => [...super.props, myInt, myBool];
}

final class ExamplePolymorphicB extends ExamplePolymorphic {
  static const polymorphicId = 'B';

  static const Map<String, Type> nonPrimitiveMembers = {};

  final List<String> stringList;
  final List<double> doubleList;

  const ExamplePolymorphicB({
    required super.myString,
    required super.myDouble,
    required this.stringList,
    required this.doubleList,
  }) : super();

  factory ExamplePolymorphicB.fromJson(Map<String, dynamic> json) =>
      parse(json);

  @override
  List<Object?> get props => [...super.props, stringList, doubleList];
}

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

void polymorphism() {
  registerType<ExamplePolymorphicA>(
      ExamplePolymorphicA.new, ExamplePolymorphicA.nonPrimitiveMembers);
  registerType<ExamplePolymorphicB>(
      ExamplePolymorphicB.new, ExamplePolymorphicB.nonPrimitiveMembers);
  registerPolymorphicType<ExamplePolymorphic>(
      ExamplePolymorphic.polymorphicKey, {
    ExamplePolymorphicA.polymorphicId: ExamplePolymorphicA,
    ExamplePolymorphicB.polymorphicId: ExamplePolymorphicB
  }, (
    ExamplePolymorphic.new,
    ExamplePolymorphic.nonPrimitiveMembers
  ));

  check(ExamplePolymorphicA.fromJson(polymorphicJsonA) == polymorphicA);
  check(ExamplePolymorphicB.fromJson(polymorphicJsonB) == polymorphicB);
  check(ExamplePolymorphic.fromJson(baseJson) == base);
  check(ExamplePolymorphic.fromJson(polymorphicJsonA) == polymorphicA);
  check(ExamplePolymorphic.fromJson(polymorphicJsonB) == polymorphicB);
}
