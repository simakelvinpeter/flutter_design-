import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:application_1/main.dart';
import 'package:application_1/demo_order.dart';

void main() {
  test('order keeps chosen details, total and actual creation date', () {
    final order = DemoOrder(address: 'My address', contact: '+254700000000',
      paymentMethod: 'Cash on delivery', createdAt: DateTime(2026, 10, 28));
    expect(order.total, 12);
    expect(order.date, '2026-10-28');
    expect(order.id, startsWith('DEMO-'));
  });

  testWidgets('edit address validation and checkout use the same order', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.byIcon(Icons.edit).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your details'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Nairobi, House 12');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Place demo order'));
    await tester.tap(find.text('Place demo order'));
    await tester.pumpAndSettle();
    expect(find.textContaining('No payment was collected'), findsOneWidget);
    await tester.tap(find.text('Track order'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Order ID: DEMO-'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Nairobi, House 12'), 200);
    expect(find.text('Nairobi, House 12'), findsOneWidget);
    expect(find.text('Cash on delivery'), findsOneWidget);
  });
}
