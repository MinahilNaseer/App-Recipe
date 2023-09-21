import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screen/style/color.dart';
import 'package:flutter/material.dart';
import '../viewModel/profile_repository.dart';

class UpdateAccountDetail extends StatefulWidget {
  const UpdateAccountDetail({super.key});

  @override
  State<UpdateAccountDetail> createState() => _UpdateAccountDetailState();
}

class _UpdateAccountDetailState extends State<UpdateAccountDetail> {
  final UserRepository _userRepository = UserRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        final userName = await _userRepository.getUserName(user.uid);
        final email = await _userRepository.getEmail(user.uid);
        final password = await _userRepository.getPassword(user.uid);
        if (userName != null) {
          setState(() {
            _usernameController.text = userName;
            _emailController.text = email!;
            _passwordController.text = password!;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _updateUserDetails() async {
    final username = _usernameController.text;
    final firstname = username.split(' ')[0]; // Extract first name from username
    final lastname = username.split(' ')[1]; // Extract last name from username

    try {
      final user = await _userRepository.getCurrentUser();
      if (user != null) {
        await user.updateEmail(_emailController.text);
        await user.updatePassword(_passwordController.text);

        await _userRepository.updateUserDetails(
          user.uid,
          firstname,
          lastname,
          _emailController.text,
          _passwordController.text,
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('User details updated successfully!'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error updating user details: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to update user details. Please try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: maincolor, width: 2),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/image.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    label: const Text('Username'),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      label: const Text('Email'),
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.fingerprint),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            )),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: (){
                  //handleProfileUpdate(_usernameController,_emailController.text, _passwordController.text);
                  _updateUserDetails();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
