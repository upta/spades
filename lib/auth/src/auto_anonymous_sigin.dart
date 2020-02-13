import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spades/auth/auth.dart';

class AutoAnonymousSignIn extends StatefulWidget {

    AutoAnonymousSignIn({
      Key key,
      @required this.landingBuilder,
      @required this.errorBuilder,
      @required this.standByBuilder
    }) : super(key: key);

    final Widget Function(BuildContext context, User user) landingBuilder;
    final Widget Function(BuildContext context, String error) errorBuilder;
    final Widget Function(BuildContext context) standByBuilder;

  @override
  _AutoAnonymousSignInState createState() => _AutoAnonymousSignInState();
}

class _AutoAnonymousSignInState extends State<AutoAnonymousSignIn> {
  Future<User> future;

  @override
  void initState() {
    super.initState();
    final authService = Provider.of<FirebaseAuthService>(context, listen: false);

    future = authService.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;

          return MultiProvider(
            providers: [
              Provider<User>.value(value: user)
            ],
            child: widget.landingBuilder(context, user),
          );
        }
        else if (snapshot.hasError) {
          return widget.errorBuilder(context, snapshot.error);
        }

        return widget.standByBuilder(context);
      },
    );
  }
}