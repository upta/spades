import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spades/auth/auth.dart';

class SignInSwitch extends StatelessWidget {

  const SignInSwitch({
    Key key,
    @required this.signIn,
    @required this.landing,
    @required this.standBy
  }) : super(key: key);

  final Widget signIn;
  final Widget landing;
  final Widget standBy;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active)
        {
          return snapshot.hasData ? landing : signIn;
        }
        
        return standBy;
      },
    );
  }

}