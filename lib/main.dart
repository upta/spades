import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spades/auth/auth.dart';
import 'package:spades/routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => FirebaseAuthService())
      ],
      child: AutoAnonymousSignIn(
        standByBuilder: (_) => CircularProgressIndicator(),
        errorBuilder: (_, error) => Text(error),
        landingBuilder: (_, user) => MaterialApp(
          title: 'Spades Tracker',
          theme: ThemeData(primarySwatch: Colors.blueGrey),
          onGenerateRoute: generateRoute,
        )
      ),
    );
  }
}