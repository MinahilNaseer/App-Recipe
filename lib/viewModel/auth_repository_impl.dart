
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/User.dart';
import '../Model/auth_repository.dart';


class AuthRepositoryImpl implements AuthenticationRepository {
  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> createUser(UserData user) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user!.uid)
          .set({
        'firstname': user.firstname.trim(),
        'lastname': user.lastname.trim(),
        'email': user.email.trim(),
        'password': user.password.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationException(
            code: e.code, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthenticationException(
            code: e.code,
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      throw AuthenticationException(code: '', message: e.toString());
    }
  }

}

class AuthenticationException implements Exception {
  final String code;
  final String? message;

  AuthenticationException({required this.code, required this.message});
}