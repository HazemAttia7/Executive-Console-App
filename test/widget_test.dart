import 'package:flutter_test/flutter_test.dart';
import 'package:employee_management_system/main.dart';

void main() {
  testWidgets('Executive Console app loads test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExecutiveConsoleApp());

    // Verify that Executive Console title appears
    expect(find.text('Executive Console'), findsOneWidget);
  });
}
