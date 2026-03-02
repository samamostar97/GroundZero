import 'package:flutter_test/flutter_test.dart';
import 'package:groundzero_mobile/main.dart';

void main() {
  testWidgets('App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const GroundZeroApp());
    expect(find.text('GroundZero'), findsOneWidget);
  });
}
