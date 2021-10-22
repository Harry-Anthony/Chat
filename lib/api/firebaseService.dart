import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final instance = FirebaseService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool erro;
  Future<dynamic> signIn(String email, String password) async {
    dynamic result = "not ok";
    try {
       result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password
      );

      return result;
    } on FirebaseAuthException catch  (e) {
      print(e.code);
      return result;
    }
    // final result = await _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password).catchError((error){
    //   print(error);
    // });
    // return result;
  }
  Future<UserCredential> signUp(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password);
    return result;
  }

}