import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  updateDisplayName(String? dispalyName) async {
    _firebaseAuth.currentUser?.updateDisplayName(dispalyName);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
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
