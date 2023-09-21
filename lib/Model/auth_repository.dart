import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'User.dart';



abstract class AuthenticationRepository {
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<void> createUser(UserData user);
}


