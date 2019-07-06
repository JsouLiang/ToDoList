import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Sync* 可以通过 yield 生成一个 Iterable
  test('Generator Test: Sync* generator Iterable',
      (WidgetTester tester) async {});

  test("Generator Test: async* generator Stream", () async {});

  testWidgets("Generator Test: yield* for Generator is recursive",
      (WidgetTester tester) async {});
}
