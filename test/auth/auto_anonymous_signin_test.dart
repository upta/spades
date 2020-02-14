import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:spades/auth/auth.dart';

class TestingException implements Exception{}

void main() {

  group("AutoAnonymousSignIn", () {
    final landingKey = GlobalKey();
    final landing = Container(key: landingKey);
    final standBy = Container();
    final error = Container();

    var sut = AutoAnonymousSignIn(
      landingBuilder: (BuildContext context, User user) => landing,
      standByBuilder: (BuildContext context) => standBy,
      errorBuilder: (BuildContext context, String e) => error,
    );

    Widget widget;
    MemoryAuthService service;

    setUp(() {
      service = MemoryAuthService();
      widget = Provider<AuthService>(
          create: (_) => service,
          child: sut,
        );
    });

    testWidgets('shows "standBy" when auth hasn\'t resolved', (WidgetTester tester) async {

      await tester.runAsync(() async {

        service.signInAnonymouslyFuture = Future<User>(null);

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byWidget(standBy), findsOneWidget);
        expect(find.byWidget(landing), findsNothing);
        expect(find.byWidget(error), findsNothing);

      });

    });

    testWidgets('shows "error" when auth fails', (WidgetTester tester) async {  

      await tester.runAsync(() async {

          service.signInAnonymouslyFuture = Future<User>.error(TestingException());

          await tester.pumpWidget(widget);
          await tester.pumpAndSettle();

          expect(find.byWidget(standBy), findsNothing);
          expect(find.byWidget(landing), findsNothing);
          expect(find.byWidget(error), findsOneWidget);

      });
        
    });

    testWidgets('shows "landing" when auth succeeds', (WidgetTester tester) async { 

        await tester.runAsync(() async {

          service.signInAnonymouslyFuture = Future<User>.value(User(
            uid: "uid"
          ));

          await tester.pumpWidget(widget);
          await tester.pumpAndSettle();

          expect(find.byWidget(standBy), findsNothing);
          expect(find.byWidget(landing), findsOneWidget);
          expect(find.byWidget(error), findsNothing);

        });

    });

    testWidgets('provides User to "landing" when auth succeeds', (WidgetTester tester) async {    

        await tester.runAsync(() async {

          final user = User(
            uid: "uid"
          );

          service.signInAnonymouslyFuture = Future<User>.value(user);

          await tester.pumpWidget(widget);
          await tester.pumpAndSettle();

          expect(Provider.of<User>(landingKey.currentContext, listen: false), user);

        });
    });
  });
}