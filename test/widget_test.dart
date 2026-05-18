// Widget test for the offline UENR campus guide application.

import 'package:flutter_test/flutter_test.dart';

import 'package:smart_campus_guide1/main.dart';

void main() {
  testWidgets('App shows splash screen and navigates to main page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UenrCampusGuideApp());

    expect(find.text('UENR Campus Guide'), findsOneWidget);
    expect(
      find.text('Offline navigation for visitors and new students'),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to UENR'), findsOneWidget);
    expect(find.text('Major Campus Buildings'), findsOneWidget);
  });
}
