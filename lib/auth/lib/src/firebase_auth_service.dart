import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);

  Future<User> signInAnonymously() async {
    final result = await _firebaseAuth.signInAnonymously();

    return _userFromFirebase(result.user);
  }

  _userFromFirebase(FirebaseUser user) {
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