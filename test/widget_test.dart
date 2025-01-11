import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youtube/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construir la app
    await tester.pumpWidget(MyApp());

    // Verificar que inicia en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tocar el botón '+' e incrementar
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verificar que incrementó a 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
