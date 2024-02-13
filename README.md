parse_json
-----

[![License](https://img.shields.io/github/license/JohnSiegel/parse_json?style=flat-square&logo=github)](https://github.com/JohnSiegel/parse_json/blob/main/LICENSE) [![Pub.dev](https://img.shields.io/pub/v/parse_json.svg?style=flat-square&logo=data:image/png;base64,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)](https://pub.dartlang.org/packages/parse_json) [![Github Stars](https://img.shields.io/github/stars/JohnSiegel/parse_json?style=flat-square&logo=github)](https://github.com/JohnSiegel/parse_json) 

# Type-safe JSON deserialization

### *NO CODE GENERATION OR REFLECTION*

parse_json uses named parameters from your constructor to match JSON keys. It supports many features such as optionals, nested types, polymorphism/inheritance, enums, and collections. It is also type-safe, meaning that if you try to deserialize a JSON object into a type that doesn't match, it will throw an error.

## Getting Started

Add the package to your `pubspec.yaml`:

For Flutter projects:
```bash
flutter pub add parse_json
```

For Dart projects:
```bash
dart pub add parse_json
```

Then import the package in your Dart code:
```dart
import 'package:parse_json/parse_json.dart';
```

Then match up a constructor's named parameters with your JSON data, and make a factory function that uses `parse` to create an object from JSON. In the `parse` function, you will need to provide the constructor to use, the JSON data, and a map that matches the named parameters of the constructor to the JSON keys. Here is an example of a simple class with primitive members:

Data:
```json
{
  "myString": "exampleStr",
  "myDouble": 12.5
}
```

Dart Code:
```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
  final String myString;
  final double myDouble;

  /// This is the constructor that will be called by `parse`
  const ExampleObject({
    required this.myString,
    required this.myDouble,
  });

  /// This is the factory function that will be used to parse the JSON
  factory ExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ExampleObject.new, // the constructor to use
      json,
      // note: the keys in this map MUST match the named parameters of the constructor
      {
        'myString': string,
        'myDouble': float,
      },
    );
}
```

For strings, you will use `string`, for doubles you will use `float`, for ints you will use `integer`, and for bools you will use `boolean`.

You do not need to name your member variables the same as the JSON keys. You can specify a special constructor with named parameters that match the JSON keys, and use whatever names you like for your member variables. You also do not need to parse every member variable from JSON, in cases where you have derived data. Your members can also be non-final, but most of the examples in this documentation use final members for consistency.

Data:
```json
{
  "myString": "exampleStr",
  "myDouble": 12.5
}
```

Dart Code:
```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
  /// Members with names different from those in the constructor
  final String name;
  final double originalHeight;

  /// Non-final member
  double currentHeight;

  /// Constructor that will be called by `parse`
  const ExampleObject.json({
    required String myString,
    required double myDouble,
  }) : name = myString,
       originalHeight = myDouble,
       currentHeight = myDouble;

  /// Constructor we use for other stuff
  const ExampleObject(this.name, this.originalHeight, this.currentHeight);

  /// Factory function for parsing and constructing from JSON
  factory ExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ExampleObject.json, // the constructor to use
      json,
      {
        'myString': string,
        'myDouble': float,
      },
    );
}
```

You will need to create the map parameter in `parse` a little differently when you have a JSON property that is user-defined (Ones that are not `String`, `int`, `double`, `bool`, or some `List` or `Map` of those). Here is an example of a class with user-defined members:

Data:
```json
{
  "myBoolList": [false, true, false],
  "myIntList": [12.5, 10.0, 5.0],
  "myFriend": {
    "myString": "friendStr",
    "myDouble": 10.5
  },
  "myOptionalFriend": ... another friend or this field could be omitted
  "friendList": [
    ... more friends
  ]
}
```

Dart Code:
```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
  final String myString;
  final double myDouble;

  const ExampleObject({
    required this.myString,
    required this.myDouble,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ExampleObject.new,
      json,
      {
        'myString': string,
        'myDouble': float,
      },
    );
}

final class ComplexExampleObject {
  final List<bool> myBoolList;
  final List<int> myIntList;
  final ExampleObject myFriend;
  final ExampleObject? myOptionalFriend;
  final List<ExampleObject> friendList;

  const ComplexExampleObject({
    required this.myBoolList,
    required this.myIntList,
    required this.myFriend,
    required this.friendList,
    this.myOptionalFriend,
  });

  factory ComplexExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ComplexExampleObject.new,
      json,
      {
        'myBoolList': boolean.list,
        'myIntList': integer.list,
        'myFriend': ExampleObject.fromJson.required,
        'myOptionalFriend': ExampleObject.fromJson.optional,
        'friendList': ExampleObject.fromJson.list,
      },
    );
}
```

## Example:

* [Primitive types](#primitive-types)
* [User-defined types](#user-defined-types)
* [Enums](#enums)
* [Collections](#collections)
* [Inheritance/Polymorphic types](#inheritancepolymorphic-types)
* [Full example](example/lib/main.dart)

## Primitive types:

If you're defining a primitive property (such as `String`, `int`, `double`, `bool`, or some `List` or `Map` of one of those), you can use the a constant for your property. Here is an example of a simple class that only has primitive members:

```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
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

  factory ExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ExampleObject.new,
      json,
      {
        'myString': string,
        'myDouble': float,
        'myInt': integer,
        'myBool': boolean,
        'myOptionalString': string.optional,
        'myOptionalInt': integer.optional,
      }
    );
}
```

## User-defined types:

For non-primitive types (user-defined types), you must use the `.required`, `.optional`, `.list`, `.map`, `.stringMap`, or `.intMap` methods on the user-defined type's `fromJson` factory function.

```dart
import 'package:parse_json/parse_json.dart';

final class SimpleObject {
  final String myString;
  final double myDouble;

  const SimpleObject({
    required this.myString,
    required this.myDouble,
  });

  factory SimpleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      SimpleObject.new,
      json,
      {
        'myString': string,
        'myDouble': float,
      }
    );
}

final class ComplexObject {
  final List<SimpleObject> exampleList;
  final Map<String, SimpleObject> exampleMap;
  final SimpleObject? optionalExampleObject;
  final SimpleObject exampleObject;

  const ComplexObject({
    required this.exampleList,
    required this.exampleMap,
    required this.exampleObject,
    this.optionalExampleObject,
  });

  factory ComplexObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ComplexObject.new,
      json,
      {
        'exampleList': SimpleObject.fromJson.list,
        'exampleMap': SimpleObject.fromJson.stringMap,
        'exampleObject': SimpleObject.fromJson.required,
        'optionalExampleObject': SimpleObject.fromJson.optional,
      }
    );
}
```

## Enums

Enums are pretty much the same as user-defined types. You need to provide a `fromJson` factory function for the enum. You can use the `switch` function to match the JSON value to the enum value. Here is an example of a class with an enum member:

```dart
enum ExampleEnum {
  a,
  b,
  c;

  factory ExampleEnum.fromJson(dynamic json) => switch (json) {
        'abbracaddabra' => ExampleEnum.a,
        'bye-bye' => ExampleEnum.b,
        'ciao' => ExampleEnum.c,
        _ => throw Exception('Unknown enum value')
      };
}

final class ObjectWithEnums {
  final ExampleEnum a;
  final ExampleEnum? b;
  final Map<String, List<ExampleEnum>>? c;

  const ObjectWithEnums({
    required this.a,
    this.b,
    this.c,
  }) : super();

  factory ObjectWithEnums.fromJson(Map<String, dynamic> json) =>
      parse(
        ObjectWithEnums.new, 
        json, 
        {
          'a': ExampleEnum.fromJson.required,
          'b': ExampleEnum.fromJson.optional,
          'c': ExampleEnum.fromJson.list.stringMap.optional,
        }
      );
}
```

## Collections

For collections, you can use the `.list`, `.map`, `.stringMap`, or `.intMap` methods on any JsonProperty. Here is an example of a class with a list and a map:

```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
  final List<String> myStringList;
  final Map<String, double> myStringDoubleMap;

  const ExampleObject({
    required this.myStringList,
    required this.myStringDoubleMap,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => 
    parse(
      ExampleObject.new,
      json,
      {
        'myStringList': string.list,
        'myStringDoubleMap': float.stringMap,
      }
    );
}
```

## Inheritance/Polymorphic types:

With polymorphic base types, you need to use `polymorphicParse`. You will need to provide a `polymorphicKey` for the base class and a unique id for each subclass. The `polymorphicKey` is the key in the JSON that will be used to determine the type of the object. The unique ids are the values of `polymorphicKey` that will be used to determine the type of an object polymorphically at runtime. You must provide the `fromJson` factory functions to the `derivedTypes` parameter of `polymorphicParse`, and use a unique id for each subclass as the key in the map. You can also provide a `baseDefinition` to the `polymorphicParse` function that will be used to parse the base class if it is not abstract and `polymorphicKey` is missing from the JSON.

```dart
import 'package:parse_json/parse_json.dart';

final class BaseClass {
  static const polymorphicKey = 'type';
  
  final String myString;
  final double myDouble;

  const BaseClass({
    required this.myString,
    required this.myDouble,
  });

  factory BaseClass.fromJson(Map<String, dynamic> json) => 
    polymorphicParse(
      polymorphicKey,
      json,
      {
        SubClassA.polymorphicId: SubClassA.fromJson,
        SubClassB.polymorphicId: SubClassB.fromJson,
      },
      baseDefinition: DefinedType(BaseClass.new, {
        'myString': string,
        'myDouble': float,
    }));
}

final class SubClassA extends BaseClass {
  static const polymorphicId = 'A';

  final int myInt;

  const SubClassA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
  }) : super();

  factory SubClassA.fromJson(Map<String, dynamic> json) => 
    parse(
      SubClassA.new,
      json,
      {
        'myString': string,
        'myDouble': float,
        'myInt': integer,
      },
    );
}

final class SubClassB extends BaseClass {
  static const polymorphicId = 'B';

  final ExampleObject myExampleObject;

  const SubClassB({
    required super.myString,
    required super.myDouble,
    required this.myExampleObject,
  }) : super();

  factory SubClassB.fromJson(Map<String, dynamic> json) => 
    parse(
      SubClassB.fromJson,
      json,
      {
        'myString': string,
        'myDouble': float,
        'myExampleObject': ExampleObject.fromJson.required,
      },
    );
}
```

### License/Disclaimer

See [LICENSE](https://github.com/JohnSiegel/parse_json/blob/main/LICENSE)
