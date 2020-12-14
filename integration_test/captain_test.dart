import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_nautilus/main.dart' as app;

Future<void> main() async {
  app.main();

  group('end-to-end test', () {
    setUpAll(() async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('tap on the floating action button; verify counter',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          // Finds the floating action button to tap on.
          final Finder fab = find.byWidgetPredicate((widget) => widget is Text &&
              widget.data.startsWith('Log in'),);

          await tester.tap(fab);

          await tester.pumpAndSettle();

          expect(find.text('Authorization'), findsOneWidget);
        });
  });
}
