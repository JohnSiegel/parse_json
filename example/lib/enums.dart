import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';

import 'main.dart';

enum TestEnum {
  a,
  b,
  c;

  factory TestEnum.fromJson(dynamic json) => TestEnum.values.firstWhere(
        (e) => e.name == json,
        orElse: () => throw Exception('Unknown enum value'),
      );
}

final class TestObject extends Equatable {
  final TestEnum a;
  final TestEnum? b;
  final Map<String, List<TestEnum>>? c;

  const TestObject({
    required this.a,
    this.b,
    this.c,
  }) : super();

  static const List<String> keys = ['a', 'b', 'c'];

  @override
  List<Object?> get props => [a, b, c];
}

enum TestEnum2 {
  a,
  b,
  c;

  factory TestEnum2.fromJson(dynamic json) => TestEnum2.values[json as int];
}

final class TestObject2 extends Equatable {
  final TestEnum2 a;
  final TestEnum2? b;
  final List<TestEnum2> c;

  const TestObject2({
    required this.a,
    required this.b,
    required this.c,
  }) : super();

  static const List<String> keys = ['a', 'b', 'c'];

  @override
  List<Object?> get props => [a, b, c];
}

void enums() {
  registerEnum<TestEnum>(TestEnum.fromJson);
  registerJson<TestObject>(TestObject.new, TestObject.keys);
  registerEnum<TestEnum2>(TestEnum2.fromJson);
  registerJson<TestObject2>(TestObject2.new, TestObject2.keys);

  final object1 = TestObject(
    a: TestEnum.a,
    c: {
      'first': [TestEnum.a, TestEnum.b, TestEnum.c],
      'second': [TestEnum.b, TestEnum.c]
    },
  );
  final objectJson1 = {
    'a': 'a',
    'c': {
      'first': ['a', 'b', 'c'],
      'second': ['b', 'c']
    },
  };
  check(fromJson<TestObject>(objectJson1) == object1);

  final object2 = TestObject2(
    a: TestEnum2.a,
    b: TestEnum2.b,
    c: [TestEnum2.c, TestEnum2.a, TestEnum2.b],
  );
  final objectJson2 = {
    'a': 0,
    'b': 1,
    'c': [2, 0, 1],
  };
  check(fromJson<TestObject2>(objectJson2) == object2);
}
