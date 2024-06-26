import 'defaults.dart';
import 'enums.dart';
import 'nested_objects.dart';
import 'simple_objects.dart';

void check(bool test) {
  if (!test) {
    throw Exception('Test failed');
  }
}

void main() {
  simpleObjects();
  nestedObjects();
  enums();
  defaults();
}
