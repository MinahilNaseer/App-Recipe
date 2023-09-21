import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screen/style/palatte.dart';
import 'package:firstapp/widgets/backgroundlogin.dart';
import 'package:firstapp/widgets/emailtext-input.dart';
import 'package:firstapp/widgets/loginbuttonloginpage.dart';
import 'package:firstapp/widgets/password-input.dart';
import 'package:flutter/material.dart';
import '../Model/auth_repository.dart';
import '../viewModel/auth_repository_impl.dart';
import 'navigation.dart';


class Login extends StatefulWidget {
  const Login({super.key});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading=false;
  UserCredential? userCredential ;
  RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  TextEditingController email=TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthenticationRepository authenticationRepository = AuthRepositoryImpl() as AuthenticationRepository;

  Future<void> loginAuth()async{
    final emailValue = email.text.trim();
    final passwordValue = password.text.trim();
    if (emailValue.isEmpty || passwordValue.isEmpty) {
      // an error message indicating that the email or password is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password.'),
        ),
      );
      return;
    }
    try {

      userCredential = await authenticationRepository.signInWithEmailAndPassword(
        emailValue,
        passwordValue,
      );
      if(userCredential != null) {
        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Navigation(),
          ),
              (Route<dynamic> route) => false,
        );
      }
    } on AuthenticationException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password. Please try again'),
          ),
        );
      }
      setState(() {
        loading=false;
      });
    }
  }

  void validation() {
    if (email.text.trim().isEmpty && password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All Field is Empty"),
        ),
      );
    }
    if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is Empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter valid Email",
          ),
        ),
      );
      return;
    }
    if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password is Empty"),
        ),
      );
      return;
    } else {
      setState(() {
        loading=true;
      });
      loginAuth();

    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundLogin(),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 140,
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'Foodie',
                      style: kHeading,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                   ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children:  [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextInput(
                            controller: email,
                            obscureText: false,
                              icon: Icons.email,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                          ),
                          PasswordInput(
                              controller: password,
                              obscureText: true,
                              icon: Icons.lock,
                              hint: 'Password',
                              inputAction: TextInputAction.done
                          ),
                        ],
                      ),
                      loading?const CircularProgressIndicator()
                          :
                      Container(
                        margin: const EdgeInsets.all(60),
                        height: 60,
                        width: 300,
                        child: LoginButton(
                          onPressed: (){
                            validation();
                            },
                          buttonText: 'Login',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
}
}




