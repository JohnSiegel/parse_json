import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class SimpleOptionals extends Equatable {
  final String myString;
  final double? myDouble;
  final int myInt;
  final bool? myBool;

  const SimpleOptionals({
    required this.myString,
    required this.myInt,
    this.myDouble,
    this.myBool,
  }) : super();

  factory SimpleOptionals.fromJson(Map<String, dynamic> json) =>
      parse(SimpleOptionals.new, json, {
        'myString': string,
        'myDouble': float.optional,
        'myInt': integer,
        'myBool': boolean.optional,
      });

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class ComplexOptionals extends Equatable {
  final SimpleOptionals? optionalObject;
  final List<bool>? optionalBoolList;

  const ComplexOptionals({
    this.optionalObject,
    this.optionalBoolList,
  }) : super();

  factory ComplexOptionals.fromJson(Map<String, dynamic> json) =>
      parse(ComplexOptionals.new, json, {
        'optionalObject': SimpleOptionals.fromJson.optional,
        'optionalBoolList': boolean.list.optional
      });

  @override
  List<Object?> get props => [optionalObject, optionalBoolList];
}

void main() {
  test('Deserializing primitive optionals', () {
    final testOptional1 = SimpleOptionals(
        myString: 'testStr', myDouble: 12.5, myInt: 10, myBool: false);

    final testOptionalJson1 = {
      'myString': 'testStr',
      'myDouble': 12.5,
      'myInt': 10,
      'myBool': false,
    };

    final testOptional2 = SimpleOptionals(myString: 'testStr2', myInt: 5);

    final testOptionalJson2 = {'myString': 'testStr2', 'myInt': 5};

    expect(SimpleOptionals.fromJson(testOptionalJson1), testOptional1);
    expect(SimpleOptionals.fromJson(testOptionalJson2), testOptional2);
  });

  test('Deserializing more complex optionals', () {
    final testOptional1 = ComplexOptionals(optionalBoolList: [true, false]);
    final testOptionalJson1 = {
      'optionalBoolList': [true, false]
    };

    final testOptional2 = ComplexOptionals(
        optionalObject: SimpleOptionals(myString: 'testStr', myInt: 10));
    final testOptionalJson2 = {
      'optionalObject': {'myString': 'testStr', 'myInt': 10}
    };

    final completelyEmptyOptional = ComplexOptionals();
    final completelyEmptyJson = <String, dynamic>{};

    expect(ComplexOptionals.fromJson(testOptionalJson1), testOptional1);
    expect(ComplexOptionals.fromJson(testOptionalJson2), testOptional2);
    expect(ComplexOptionals.fromJson(completelyEmptyJson),
        completelyEmptyOptional);
  });
}
