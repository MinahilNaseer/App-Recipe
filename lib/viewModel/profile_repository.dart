import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firstapp/Domain/User.dart';

//import '../Domain/Profile.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;

  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> clearCart() async {
    QuerySnapshot cartSnapshot =
    await FirebaseFirestore.instance.collection('Cart').get();
    List<QueryDocumentSnapshot> cartItems = cartSnapshot.docs;
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var cartItem in cartItems) {
      batch.delete(cartItem.reference);
    }
    await batch.commit();
  }
  Future<String?> getUserName(String userId) async {
    DocumentSnapshot userSnapshot =
    await _firestore.collection('userData').doc(userId).get();
    if (userSnapshot.exists) {
      String? firstName = userSnapshot.get('firstname');
      String? lastName = userSnapshot.get('lastname');
      /*String? email = userSnapshot.get('eamil');
      String? password = userSnapshot.get('password');*/
      if (firstName != null && lastName != null) {
        return '$firstName $lastName';
      }
      /*if (password != null) {
        return password;
      }
      if (email != null) {
        return email;
      }*/
      return null;
    }
  }
  Future<String?> getEmail(String userId) async {
    DocumentSnapshot userSnapshot =
    await _firestore.collection('userData').doc(userId).get();
    if (userSnapshot.exists) {
      String? email = userSnapshot.get('email');
      if (email != null) {
        return email;
      }
      return null;
    }
  }
  Future<String?> getPassword(String userId) async {
    DocumentSnapshot userSnapshot =
    await _firestore.collection('userData').doc(userId).get();
    if (userSnapshot.exists) {
      String? password = userSnapshot.get('password');
      if (password != null) {
        return password;
      }
      return null;
    }
  }
  /*Future<String?> loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      user = user;
      DocumentSnapshot userSnapshot =
      await _firestore.collection('userData').doc(user.uid).get();
      if (userSnapshot.exists) {
        String firstname = userSnapshot.get('firstname');
        String lastname = userSnapshot.get('lastname');
        String? userName = userSnapshot.get('$firstname $lastname');
        return userName;
      } else {
        throw Exception('User document does not exist');
      }
    } else {
      throw Exception('No user logged in');
    }
  }*/
  Future<void> updateUserDetails(
      String uid, String firstname, String lastname, String upemail, String uppassword) async {
    try {
      await user?.updateEmail(upemail);
      await user?.updatePassword(uppassword);
      await _firestore.collection('userData').doc(uid).update({
        'firstname': firstname,
        'lastname': lastname,
        'email': upemail,
        'password': uppassword,
      });
    } catch (e) {
      print('Error updating user details: $e');
      throw e;
    }
  }
  Future<void> updateLoginDetails(String uid, String updatedEmail, String updatedPassword) async {
    try {
      await _firestore.collection('userData').doc(uid).update({
        'email': updatedEmail,
        'password': updatedPassword,
      });
    } catch (e) {
      throw Exception('Failed to update user details.');
    }
  }

  Future<void> signOut() async {
    await clearCart();
    await _auth.signOut();
  }
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final userDoc = await _firestore.collection('userData').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to fetch user data.');
    }
  }
}