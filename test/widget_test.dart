import 'package:flutter_test/flutter_test.dart';

import 'package:awn/main.dart';
import 'package:awn/providers/app_state.dart';
import 'package:awn/router/app_router.dart';

void main() {
  testWidgets('Awn app loads', (WidgetTester tester) async {
    final appState = AppState();
    final router = createAppRouter(appState);
    await tester.pumpWidget(AwnApp(appState: appState, router: router));
    await tester.pump();
    expect(find.byType(AwnApp), findsOneWidget);
  });
}
