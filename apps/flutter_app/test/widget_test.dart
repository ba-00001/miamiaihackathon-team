import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/app.dart';

void main() {
  testWidgets('renders the MaRe growth dashboard', (tester) async {
    await tester.pumpWidget(const MareGrowthEngineApp());
    await tester.pumpAndSettle();

    expect(find.text('The MaRe Luxury Growth Engine'), findsOneWidget);
    expect(find.text('Luxury-grade AI growth system'), findsOneWidget);
    expect(find.text('Human approval required before send'), findsOneWidget);
  });
}
