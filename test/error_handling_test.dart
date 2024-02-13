import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

final class TestObject extends Equatable {
  final int myInt;
  final String myString;

  const TestObject({
    required this.myInt,
    required this.myString,
  }) : super();

  factory TestObject.fromJson(dynamic json) => parse(TestObject.new, json, {
        'myInt': integer,
        'myString': string,
      });

  @override
  List<Object?> get props => [myInt, myString];
}

final class ComplexObject extends Equatable {
  final TestObject testObject;
  final TestObject? optionalTestObject;
  final List<TestObject> testObjectList;

  const ComplexObject({
    required this.testObject,
    required this.testObjectList,
    this.optionalTestObject,
  }) : super();

  factory ComplexObject.fromJson(dynamic json) =>
      parse(ComplexObject.new, json, {
        'testObject': TestObject.fromJson.required,
        'testObjectList': TestObject.fromJson.list,
        'optionalTestObject': TestObject.fromJson.optional,
      });

  @override
  List<Object?> get props => [testObject, testObjectList, optionalTestObject];
}

final class InvalidClass extends Equatable {
  final int myInt;
  final String myString;

  const InvalidClass({
    required this.myInt,
    required this.myString,
  }) : super();

  static const invalidProperties = {
    'notMyInt': integer,
    'notMyString': string,
  };

  factory InvalidClass.fromJson(Map<String, dynamic> json) =>
      parse(InvalidClass.new, json, invalidProperties);

  @override
  List<Object?> get props => [myInt, myString];
}

void main() {
  test(
    'Missing properties',
    () {
      final objectJson1 = {
        'myInt': 10,
      };

      expect(
          () => TestObject.fromJson(objectJson1),
          throwsA(
            isA<PropertyMissingError>()
                .having(
                  (error) => error.constructor,
                  'constructor',
                  TestObject.new,
                )
                .having(
                  (error) => error.json,
                  'json',
                  objectJson1,
                )
                .having(
                  (error) => error.missingPropertyName,
                  'missing property name',
                  'myString',
                )
                .having(
                  (error) => error.missingPropertyType,
                  'missing property type',
                  String,
                )
                .having(
                  (error) => error.message,
                  'message',
                  'Property missing while parsing {myInt: 10} using Closure: '
                      '({required int myInt, required String myString}) => '
                      "TestObject from Function 'TestObject.': static.. Missing"
                      ' property path: myString. Missing property type: String',
                ),
          ));

      final objectJson2 = {
        'myString': 10,
      };

      expect(
        () => TestObject.fromJson(objectJson2),
        throwsA(
          isA<PropertyMissingError>()
              .having(
                (error) => error.constructor,
                'constructor',
                TestObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                objectJson2,
              )
              .having(
                (error) => error.missingPropertyName,
                'missing property name',
                'myInt',
              )
              .having(
                (error) => error.missingPropertyType,
                'missing property type',
                int,
              )
              .having(
                (error) => error.message,
                'message',
                'Property missing while parsing {myString: 10} using Closure: '
                    '({required int myInt, required String myString}) => '
                    "TestObject from Function 'TestObject.': static.. Missing"
                    ' property path: myInt. Missing property type: int',
              ),
        ),
      );

      expect(
        () => TestObject.fromJson(<String, dynamic>{}),
        throwsA(
          isA<PropertyMissingError>()
              .having(
                (error) => error.constructor,
                'constructor',
                TestObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                <String, dynamic>{},
              )
              .having(
                (error) => error.missingPropertyName,
                'missing property name',
                'myInt',
              )
              .having(
                (error) => error.missingPropertyType,
                'missing property type',
                int,
              )
              .having(
                (error) => error.message,
                'message',
                'Property missing while parsing {} using Closure: ({required '
                    'int myInt, required String myString}) => TestObject from'
                    " Function 'TestObject.': static.. Missing property path: "
                    'myInt. Missing property type: int',
              ),
        ),
      );

      final complexObjectJson1 = {
        'testObject': {'myInt': 10, 'myString': 'testStr'},
        'testObjectList': [
          {'myInt': 10},
          {'myInt': 10, 'myString': 'testStr'}
        ],
      };

      expect(
        () => ComplexObject.fromJson(complexObjectJson1),
        throwsA(
          isA<PropertyMissingError>()
              .having(
                (error) => error.constructor,
                'constructor',
                ComplexObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                complexObjectJson1,
              )
              .having(
                (error) => error.missingPropertyName,
                'missing property name',
                'testObjectList.[0].myString',
              )
              .having(
                (error) => error.missingPropertyType,
                'missing property type',
                String,
              )
              .having(
                (error) => error.message,
                'message',
                'Property missing while parsing {testObject: {myInt: 10, '
                    'myString: testStr}, testObjectList: [{myInt: 10}, {myInt:'
                    ' 10, myString: testStr}]} using Closure: ({required'
                    ' TestObject testObject, required List<TestObject> '
                    'testObjectList, TestObject? optionalTestObject}) => '
                    "ComplexObject from Function 'ComplexObject.': static.. "
                    'Missing property path: testObjectList.[0].myString. '
                    'Missing property type: String',
              ),
        ),
      );

      final complexObjectJson2 = {
        'testObject': {'myInt': 10, 'myString': 'testStr'},
      };

      expect(
        () => ComplexObject.fromJson(complexObjectJson2),
        throwsA(
          isA<PropertyMissingError>()
              .having(
                (error) => error.constructor,
                'constructor',
                ComplexObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                complexObjectJson2,
              )
              .having(
                (error) => error.missingPropertyName,
                'missing property name',
                'testObjectList',
              )
              .having(
                (error) => error.missingPropertyType,
                'missing property type',
                List<TestObject>,
              )
              .having(
                (error) => error.message,
                'message',
                'Property missing while parsing {testObject: {myInt: 10, '
                    'myString: testStr}} using Closure: ({required TestObject '
                    'testObject, required List<TestObject> testObjectList, '
                    'TestObject? optionalTestObject}) => ComplexObject from '
                    "Function 'ComplexObject.': static.. Missing property path:"
                    ' testObjectList. Missing property type: List<TestObject>',
              ),
        ),
      );
    },
  );

  test(
    'Incorrect types',
    () {
      final objectJson1 = {
        'myInt': '10',
        'myString': 'testStr',
      };

      expect(
        () => TestObject.fromJson(objectJson1),
        throwsA(
          isA<InvalidTypeError>()
              .having(
                (error) => error.constructor,
                'constructor',
                TestObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                objectJson1,
              )
              .having(
                (error) => error.propertyName,
                'property name',
                'myInt',
              )
              .having(
                (error) => error.expectedType,
                'expected type',
                int,
              )
              .having(
                (error) => error.actualType,
                'actual type',
                String,
              )
              .having(
                  (error) => error.message,
                  'message',
                  'Type mismatch while parsing {myInt: 10, myString: testStr} '
                      'using Closure: ({required int myInt, required String '
                      "myString}) => TestObject from Function 'TestObject.': "
                      'static.. Property: myInt. Expected type: int. Actual '
                      'type: String.'),
        ),
      );

      final objectJson2 = {
        'myInt': 10,
        'myString': 10,
      };

      expect(
        () => TestObject.fromJson(objectJson2),
        throwsA(
          isA<InvalidTypeError>()
              .having(
                (error) => error.constructor,
                'constructor',
                TestObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                objectJson2,
              )
              .having(
                (error) => error.propertyName,
                'property name',
                'myString',
              )
              .having(
                (error) => error.expectedType,
                'expected type',
                String,
              )
              .having(
                (error) => error.actualType,
                'actual type',
                int,
              )
              .having(
                (error) => error.message,
                'message',
                'Type mismatch while parsing {myInt: 10, myString: 10} using '
                    'Closure: ({required int myInt, required String myString}) '
                    '=> TestObject from Function \'TestObject.\': static.. '
                    'Property: myString. Expected type: String. Actual type: '
                    'int.',
              ),
        ),
      );

      final complexObjectJson1 = {
        'testObject': {'myInt': 10, 'myString': 'testStr'},
        'testObjectList': [
          {
            'myString': 'testStr',
            'myInt': '10',
          },
          {'myInt': '10', 'myString': 'testStr'}
        ],
      };

      expect(
        () => ComplexObject.fromJson(complexObjectJson1),
        throwsA(
          isA<InvalidTypeError>()
              .having(
                (error) => error.constructor,
                'constructor',
                ComplexObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                complexObjectJson1,
              )
              .having(
                (error) => error.propertyName,
                'property name',
                'testObjectList.[0].myInt',
              )
              .having(
                (error) => error.expectedType,
                'expected type',
                int,
              )
              .having(
                (error) => error.actualType,
                'actual type',
                String,
              )
              .having(
                (error) => error.message,
                'message',
                'Type mismatch while parsing {testObject: {myInt: 10, '
                    'myString: testStr}, testObjectList: [{myString: testStr, '
                    'myInt: 10}, {myInt: 10, myString: testStr}]} using '
                    'Closure: ({required TestObject testObject, required '
                    'List<TestObject> testObjectList, TestObject? '
                    'optionalTestObject}) => ComplexObject from Function '
                    "'ComplexObject.': static.. Property: "
                    'testObjectList.[0].myInt. Expected type: int. Actual '
                    'type: String.',
              ),
        ),
      );

      final complexObjectJson2 = {
        'testObject': 10,
        'testObjectList': [
          {'myInt': 10, 'myString': 'testStr'},
          {'myInt': 10, 'myString': 'testStr'}
        ],
      };

      expect(
        () => ComplexObject.fromJson(complexObjectJson2),
        throwsA(
          isA<InvalidTypeError>()
              .having(
                (error) => error.constructor,
                'constructor',
                ComplexObject.new,
              )
              .having(
                (error) => error.json,
                'json',
                complexObjectJson2,
              )
              .having(
                (error) => error.propertyName,
                'property name',
                'testObject',
              )
              .having(
                (error) => error.expectedType,
                'expected type',
                TestObject,
              )
              .having(
                (error) => error.actualType,
                'actual type',
                int,
              )
              .having(
                (error) => error.message,
                'message',
                'Type mismatch while parsing {testObject: 10, testObjectList: '
                    '[{myInt: 10, myString: testStr}, {myInt: 10, myString: '
                    'testStr}]} using Closure: ({required TestObject testObject'
                    ', required List<TestObject> testObjectList, TestObject? '
                    'optionalTestObject}) => ComplexObject from Function '
                    "'ComplexObject.': static.. Property: testObject. Expected"
                    ' type: TestObject. Actual type: int.',
              ),
        ),
      );
    },
  );

  test(
    'Invalid property configuration',
    () {
      final invalidJson = {
        'notMyInt': 10,
        'notMyString': 'testStr',
      };

      expect(
        () => InvalidClass.fromJson(invalidJson),
        throwsA(isA<InvalidPropertiesError>()
            .having(
              (error) => error.constructor,
              'constructor',
              InvalidClass.new,
            )
            .having(
              (error) => error.properties,
              'properties',
              InvalidClass.invalidProperties,
            )
            .having(
              (error) => error.message,
              'message',
              'Invalid properties while parsing Closure: ({required int myInt,'
                  ' required String myString}) => InvalidClass from Function '
                  "'InvalidClass.': static.. Properties: {notMyInt: Instance of"
                  " '_Primitive<int>', notMyString: Instance of "
                  "'_Primitive<String>'}.",
            )),
      );
    },
  );
}
