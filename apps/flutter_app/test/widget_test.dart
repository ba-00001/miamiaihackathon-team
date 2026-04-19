import 'package:flutter_app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the MaRe shell welcome flow', (tester) async {
    await tester.pumpWidget(const MareGrowthEngineApp());
    await tester.pumpAndSettle();

    expect(find.text('MaRe'), findsWidgets);
    expect(
      find.text(
        'One luxury scalp-health app for guests, MaRe internal teams, partner operators, and end users.',
      ),
      findsOneWidget,
    );
    expect(find.text('Continue as Guest'), findsOneWidget);
  });
}
