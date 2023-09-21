import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/View/profile_menu.dart';
import 'package:firstapp/View/welcome_page.dart';
import 'package:firstapp/screen/style/color.dart';
import 'package:flutter/material.dart';
import '../Model/User.dart';
import '../viewModel/cart_repository_impl.dart';
import '../viewModel/profile_repository.dart';
import 'Account.dart';
import 'Cart_details.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserRepository _userRepository = UserRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final CartRepository _cartRepository = CartRepository();
  //late String name;
  UserData? _userData;
  User? customer;

  @override
  void initState() {
    super.initState();
    //user = _auth.currentUser;
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        customer = user;
      });
      String? userName = await _userRepository.getUserName(user.uid);
      if (userName != null) {
        setState(() {
          _userData = UserData(firstname: userName, lastname: '', email: '', password: '');
        });
      } else {
        // User document doesn't exist
        print('User document does not exist');
      }
    } else {
      // No user logged in
      print('No user logged in');
    }
  }

  Future<void> _signOut() async {
    try {
      await _userRepository.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: maincolor,width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/image.png'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Text(
              _userData?.firstname ?? '',
              style: TextStyle(
                fontSize: 18,
                color: font,
                fontFamily: 'ro',
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateAccountDetail()
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: StadiumBorder(),
                ),
                child: Text('Edit Profile',style: TextStyle(color: Colors.black87),),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 40,
                thickness: 2,
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: Icons.person,
              press: () => {},
            ),
            ProfileMenu(
              text: "Cart",
              icon: Icons.shopping_cart,
              press: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(cart: CartRepositoryImpl(),),
                    )
                );
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Sign Out'),
                        content: const Text('Do you want to sign out?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await _signOut();
                                //Navigator.of(context).pop();
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: ()async{
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')
                          )
                        ],
                      );
                    }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}