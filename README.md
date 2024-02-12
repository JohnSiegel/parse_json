parse_json
-----

[![License](https://img.shields.io/github/license/JohnSiegel/parse_json?style=flat-square&logo=github)](https://github.com/JohnSiegel/parse_json/blob/main/LICENSE) [![Pub.dev](https://img.shields.io/pub/v/parse_json.svg?style=flat-square&logo=data:image/png;base64,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)](https://pub.dartlang.org/packages/parse_json) [![Github Stars](https://img.shields.io/github/stars/JohnSiegel/parse_json?style=flat-square&logo=github)](https://github.com/JohnSiegel/parse_json) 

# Type-safe JSON deserialization

### *NO CODE GENERATION OR REFLECTION*

parse_json uses named parameters from your constructor to match JSON keys. It supports many features such as optionals, nested types, polymorphism/inheritance, and containers. It is also type-safe, meaning that if you try to deserialize a JSON object into a type that doesn't match, it will throw an error.

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

Then match up a constructor's named parameters with your JSON data:

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

  static const Map<String, Type> nonPrimitiveMembers = {};

  const ExampleObject({
    required this.myString,
    required this.myDouble,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => parse(json);
}

void main() {
  registerType<ExampleObject>(ExampleObject.new, ExampleObject.nonPrimitiveMembers);
}
```

Note that you do not need to name your variables the same as the JSON keys. You can specify a special constructor with named parameters that match the JSON keys, and use whatever names you like for your member variables. You also do not need to parse every member variable from JSON, in cases where you have derived data. Your members can also be non-final, but most of the examples in this documentation use final members for consistency.

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
  // members with names different from those in the constructor
  final String name;
  final double originalHeight;

  // non-final member
  double currentHeight;

  static const Map<String, Type> nonPrimitiveMembers = {};

  // constructor we use for JSON
  const ExampleObject.json({
    required String myString,
    required double myDouble,
  }) : name = myString,
       originalHeight = myDouble,
       currentHeight = myDouble;

  // constructor we use for other stuff
  const ExampleObject(this.name, this.originalHeight, this.currentHeight);

  // helpful factory function for parsing and constructing from JSON
  factory ExampleObject.fromJson(Map<String, dynamic> json) => parse(json);
}

void main() {
  registerType<ExampleObject>(ExampleObject.new, ExampleObject.nonPrimitiveMembers);
}
```

At this point you have not used the `nonPrimitiveMembers` map for anything. This map is used for non-primitive types (Ones that are not `String`, `int`, `double`, `bool`, etc.). Here is an example of a class with non-primitive members:

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

  static const Map<String, Type> nonPrimitiveMembers = {};

  const ExampleObject({
    required this.myString,
    required this.myDouble,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => parse(json);
}

final class ComplexExampleObject {
  final List<bool> myBoolList;
  final List<int> myIntList;
  final ExampleObject myFriend;
  final ExampleObject? myOptionalFriend;
  final List<ExampleObject> friendList;

  static const Map<String, Type> nonPrimitiveMembers = {
    'myFriend': ExampleObject,
    'myOptionalFriend': Optional<ExampleObject>,
    'friendList': List<ExampleObject>,
  };

  const ComplexExampleObject({
    required this.myString,
    required this.myDouble,
    required this.myFriend,
    required this.friendList,
    this.myOptionalFriend,
  });

  factory ComplexExampleObject.fromJson(Map<String, dynamic> json) => parse(json);
}

void main() {
  registerType<ExampleObject>(ExampleObject.new, ExampleObject.nonPrimitiveMembers);
  registerType<ComplexExampleObject>(ComplexExampleObject.new, ComplexExampleObject.nonPrimitiveMembers);
}
```

## Example:

* [Simple types](#simple-types)
* [Nested types](#nested-types)
* [Inheritance/Polymorphic types](#inheritancepolymorphic-types)
* [Full example](example/lib/main.dart)

## Simple types:

If your class does only consists of primitive members (such as `String`, `int`, `double`, `bool`, etc.), you don't have to do anything special. Just define your class. This is because those types translate directly from JSON. Notice that the named parameters of the constructor match the JSON keys.

```dart
import 'package:parse_json/parse_json.dart';

final class ExampleObject {
  final String myString;
  final double myDouble;
  final int myInt;
  final bool myBool;
  final String? myOptionalString;
  final int? myOptionalInt;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const ExampleObject({
    required this.myString,
    required this.myDouble,
    required this.myInt,
    required this.myBool,
    this.myOptionalString,
    this.myOptionalInt,
  });

  factory ExampleObject.fromJson(Map<String, dynamic> json) => parse(json);
}

void main() {
  registerType<ExampleObject>(
      ExampleObject.new, ExampleObject.nonPrimitiveMembers);

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

  assert(ExampleObject.fromJson(objectJson1) == object1);

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

  assert(ExampleObject.fromJson(objectJson2) == object2);
}
```

## Nested types:

If your class has any members that are not primitive types, you need to register the type, and provide a map of the non-primitive members along with their JSON key (must match the constructor named parameter).

```dart
import 'package:parse_json/parse_json.dart';

final class SimpleObject extends Equatable {
  final String myString;
  final double myDouble;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const SimpleObject({
    required this.myString,
    required this.myDouble,
  });

  factory SimpleObject.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [myString, myDouble];
}

final class ComplexObject extends Equatable {
  final List<SimpleObject> exampleList;
  final Map<String, SimpleObject> exampleMap;
  final SimpleObject? optionalExampleObject;
  final SimpleObject exampleObject;

  static const Map<String, Type> nonPrimitiveMembers = {
    'exampleList': List<SimpleObject>,
    'exampleMap': Map<String, SimpleObject>,
    'optionalExampleObject': Optional<SimpleObject>,
    'exampleObject': SimpleObject,
  };

  const ComplexObject({
    required this.exampleList,
    required this.exampleMap,
    required this.exampleObject,
    this.optionalExampleObject,
  });

  factory ComplexObject.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [
    exampleList, 
    exampleMap, 
    exampleObject, 
    optionalExampleObject,
  ];
}

void main() {
  registerType<SimpleObject>(
      SimpleObject.new, SimpleObject.nonPrimitiveMembers);
  registerType<ComplexObject>(
      ComplexObject.new, ComplexObject.nonPrimitiveMembers);

  final object1 = SimpleObject(myString: 'exampleStr', myDouble: 12.5);
  final objectJson1 = {'myString': 'exampleStr', 'myDouble': 12.5};

  assert(SimpleObject.fromJson(objectJson1) == object1);

  final object2 = SimpleObject(myString: 'exampleStr2', myDouble: 102.5);
  final objectJson2 = {'myString': 'exampleStr2', 'myDouble': 102.5};

  assert(SimpleObject.fromJson(objectJson2) == object2);

  final complexObject = ComplexObject(
    exampleList: [object1, object2],
    exampleMap: {'object1': object1, 'object2': object2},
    exampleObject: object1,
  );

  final complexObjectJson = {
    'exampleList': [objectJson1, objectJson2],
    'exampleMap': {'object1': objectJson1, 'object2': objectJson2},
    'exampleObject': objectJson1,
  };

  assert(ComplexObject.fromJson(complexObjectJson) == complexObject);
}
```

## Inheritance/Polymorphic types:

With polymorphic base types, in order to register them you need to use `registerPolymorphicType` instead of `registerType`. You also need to provide a `polymorphicKey` and a `polymorphicId` for each subclass. The `polymorphicKey` is the key in the JSON that will be used to determine the type of the object. The `polymorphicId` is the value of the `polymorphicKey` that will be used to determine the type of the object. The `polymorphicId` must be unique for each subclass.

```dart
import 'package:parse_json/parse_json.dart';

final class BaseClass extends Equatable {
  static const polymorphicKey = 'type';
  
  final String myString;
  final double myDouble;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const BaseClass({
    required this.myString,
    required this.myDouble,
  });

  factory BaseClass.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [myString, myDouble];
}

final class SubClassA extends BaseClass {
  static const polymorphicId = 'A';

  final int myInt;

  static const Map<String, Type> nonPrimitiveMembers = {};

  const SubClassA({
    required super.myString,
    required super.myDouble,
    required this.myInt,
  }) : super();

  factory SubClassA.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [...super.props, myInt];
}

final class SubClassB extends BaseClass {
  static const polymorphicId = 'B';

  final ExampleObject myExampleObject;

  static const Map<String, Type> nonPrimitiveMembers = {
    'myExampleObject': ExampleObject,
  };

  const SubClassB({
    required super.myString,
    required super.myDouble,
    required this.myExampleObject,
  }) : super();

  factory SubClassB.fromJson(Map<String, dynamic> json) => parse(json);

  @override
  List<Object?> get props => [...super.props, myExampleObject];
}

void main() {
  registerType<ExampleObject>(ExampleObject.new, ExampleObject.nonPrimitiveMembers); // Defined elsewhere
  
  registerType<SubClassA>(SubClassA.new, SubClassA.nonPrimitiveMembers);
  registerType<SubClassB>(SubClassB.new, SubClassB.nonPrimitiveMembers);
  
  registerPolymorphicType<BaseClass>(
    BaseClass.polymorphicKey,
    {
      SubClassA.polymorphicId: SubClassA,
      SubClassB.polymorphicId: SubClassB,
    },
    (BaseClass.new, BaseClass.nonPrimitiveMembers),
  );

  final objectA = SubClassA(myString: 'exampleStr', myDouble: 12.5, myInt: 10);
  final objectJsonA = {
    'type': 'A',
    'myString': 'exampleStr',
    'myDouble': 12.5,
    'myInt': 10,
  };

  final objectB = SubClassB(
    myString: 'exampleStr2',
    myDouble: 102.5,
    myExampleObject: ExampleObject(
      myString: 'exampleStr',
      myDouble: 12.5,
      myInt: 10,
      myBool: false,
    ),
  );

  final objectJsonB = {
    'type': 'B',
    'myString': 'exampleStr2',
    'myDouble': 102.5,
    'myExampleObject': {
      'myString': 'exampleStr',
      'myDouble': 12.5,
      'myInt': 10,
      'myBool': false,
    },
  };

  final baseClass = BaseClass(myString: 'exampleStr', myDouble: 12.5);
  final baseClassJson = {'myString': 'exampleStr', 'myDouble': 12.5};

  assert(SubClassA.fromJson(objectJsonA) == objectA);
  assert(SubClassB.fromJson(objectJsonB) == objectB);
  assert(BaseClass.fromJson(baseClassJson) == baseClass);

  // polymorphism
  assert(BaseClass.fromJson(objectJsonA) == objectA);
  assert(BaseClass.fromJson(objectJsonB) == objectB);
}
```

### License/Disclaimer

See [LICENSE](https://github.com/JohnSiegel/parse_json/blob/main/LICENSE)
