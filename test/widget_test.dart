import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_store/main.dart';

void main() {
  testWidgets('Beauty Store app test', (WidgetTester tester) async {
    await tester.pumpWidget(const BeautyStoreApp());

    expect(find.text('Beauty Store'), findsOneWidget);
    expect(find.text('Face Cream'), findsOneWidget);
    expect(find.text('Perfume'), findsOneWidget);
  });
}