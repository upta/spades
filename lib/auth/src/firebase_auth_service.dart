import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

abstract class AuthService {
  Future<User> signInAnonymously();
}

class MemoryAuthService implements AuthService {

  final Completer<User> signInAnonymouslyCompleter = Completer();
  Future<User> signInAnonymouslyFuture;

  @override
  Future<User> signInAnonymously() => signInAnonymouslyFuture;
  // Future<User> signInAnonymously() => Future<User>.error("broke");

}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final result = await _firebaseAuth.signInAnonymously();

    return _userFromFirebase(result.user);
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    return User(
      uid: user.uid,
      email: user.email,
      photoUrl: user.photoUrl,
      displayName: user.displayName
    );
  }
}