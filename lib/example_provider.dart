// 1. import the riverpod_annotation.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 2. add the part 'example_provider.g.dart';
part 'example_provider.g.dart';

// 3. add the @riverpod annotation and create your provider function
@riverpod
String example(ExampleRef ref) {
  return 'This an example provider';
}
