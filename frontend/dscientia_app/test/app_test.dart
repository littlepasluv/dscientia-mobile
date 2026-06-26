import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dscientia_app/app/app.dart';

void main() {
testWidgets('App loads successfully', (tester) async {
await tester.pumpWidget(
const ProviderScope(
child: DscientiaApp(),
),
);

expect(find.text('DscienTia'), findsOneWidget);

});
}
