import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signUpUser({
    String email,
    String password,
    String username,
  }) async {
    String res = 'something happened';

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      res = 'created new user';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
