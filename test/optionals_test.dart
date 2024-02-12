import 'package:equatable/equatable.dart';
import 'package:parse_json/optional.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class SimpleOptionals extends Equatable {
  final String myString;
  final double? myDouble;
  final int myInt;
  final bool? myBool;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const SimpleOptionals({
    required this.myString,
    required this.myInt,
    this.myDouble,
    this.myBool,
  }) : super();

  @override
  List<Object?> get props => [myString, myDouble, myInt, myBool];
}

final class ComplexOptionals extends Equatable {
  final SimpleOptionals? optionalObject;
  final List<bool>? optionalBoolList;

  static const Map<String, Type> nonPrimitiveMembers = {
    'optionalObject': Optional<SimpleOptionals>,
  };

  const ComplexOptionals({
    this.optionalObject,
    this.optionalBoolList,
  }) : super();

  @override
  List<Object?> get props => [optionalObject, optionalBoolList];
}

void main() {
  registerType<SimpleOptionals>(
      SimpleOptionals.new, SimpleOptionals.nonPrimitiveMembers);
  registerType<ComplexOptionals>(
      ComplexOptionals.new, ComplexOptionals.nonPrimitiveMembers);

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

    expect(parse<SimpleOptionals>(testOptionalJson1), testOptional1);
    expect(parse<SimpleOptionals>(testOptionalJson2), testOptional2);
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

    expect(parse<ComplexOptionals>(testOptionalJson1), testOptional1);
    expect(parse<ComplexOptionals>(testOptionalJson2), testOptional2);
    expect(
        parse<ComplexOptionals>(completelyEmptyJson), completelyEmptyOptional);
  });
}
