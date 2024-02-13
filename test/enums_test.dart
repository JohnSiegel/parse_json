import 'package:equatable/equatable.dart';
import 'package:parse_json/parse_json.dart';
import 'package:test/test.dart';

enum TestEnum {
  a,
  b,
  c;

  factory TestEnum.fromJson(dynamic json) => switch (json) {
        'abbracaddabra' => TestEnum.a,
        'bye-bye' => TestEnum.b,
        'ciao' => TestEnum.c,
        _ => throw Exception('Unknown enum value')
      };
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

  factory TestObject.fromJson(Map<String, dynamic> json) =>
      parse(TestObject.new, json, {
        'a': TestEnum.fromJson.required,
        'b': TestEnum.fromJson.optional,
        'c': TestEnum.fromJson.list.stringMap.optional,
      });

  @override
  List<Object?> get props => [a, b, c];
}

enum TestEnum2 {
  a,
  b,
  c;

  factory TestEnum2.fromJson(dynamic json) => switch (json) {
        0 => TestEnum2.a,
        1 => TestEnum2.b,
        2 => TestEnum2.c,
        _ => throw Exception('Unknown enum value'),
      };
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

  factory TestObject2.fromJson(Map<String, dynamic> json) =>
      parse(TestObject2.new, json, {
        'a': TestEnum2.fromJson.required,
        'b': TestEnum2.fromJson.optional,
        'c': TestEnum2.fromJson.list,
      });

  @override
  List<Object?> get props => [a, b, c];
}

void main() {
  test(
    'Simple enum deserialization',
    () {
      final object1 = TestObject(
        a: TestEnum.a,
        c: {
          'first': [TestEnum.a, TestEnum.b, TestEnum.c],
          'second': [TestEnum.b, TestEnum.c]
        },
      );
      final objectJson1 = {
        'a': 'abbracaddabra',
        'c': {
          'first': ['abbracaddabra', 'bye-bye', 'ciao'],
          'second': ['bye-bye', 'ciao']
        },
      };
      expect(TestObject.fromJson(objectJson1), object1);

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
      expect(TestObject2.fromJson(objectJson2), object2);
    },
  );
}
