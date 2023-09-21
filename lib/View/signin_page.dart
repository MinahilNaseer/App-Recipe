import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/widgets/backgroundsignin.dart';
import 'package:firstapp/widgets/signin_button.dart';
import 'package:firstapp/widgets/signup-input.dart';
import 'package:flutter/material.dart';
import '../Model/User.dart';
import '../Model/auth_repository.dart';
import 'login_page.dart';

class SignIn extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  SignIn({super.key, required this.authenticationRepository});

  //static Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //late final String e;
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  TextEditingController firstname =TextEditingController();
  TextEditingController lastname =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  GlobalKey<ScaffoldMessengerState>globalScaffoldKey=GlobalKey<ScaffoldMessengerState>();

  Future sendData()async{
    try {
      userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance.
      collection('userData').
      doc(userCredential.user?.uid).
      set({
        'firstname':firstname.text.trim(),
        'lastname':lastname.text.trim(),
        'email':email.text.trim(),
        'password':password.text.trim(),
      });
    }on FirebaseAuthException
    catch(e){
      if(e.code=='Weak password'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The password provided is too weak.')
            )
        );
      }else if(e.code=='email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The account already exists for that email.')
            )
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Login()
            )
        );
      }
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e as String),
        ),
      );
      setState(() {
        loading=true;
      });
    }
    setState(() {
      loading=false;
    });

  }

  void validation(){
    if(firstname.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('FirstName is Empty',)
          )
      );
      return;
    }
    if(lastname.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('LastName is Empty',)
          )
      );
      return;
    }
    if(email.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Email is Empty',)
          )
      );
      return;
    }else if(!regExp.hasMatch(email.text)){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enter valid Email',)
          )
      );
      return;
    }
    if(password.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                'Password is Empty',
              )
          )
      );
      return;
    }
    else{
      setState(() {
        loading=true;
      });
      final user = UserData(
        firstname: firstname.text.trim(),
        lastname: lastname.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
      );
      widget.authenticationRepository.createUser(user).then((_) {
        // User created successfully
        // Navigate to the next screen or perform any other action
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Login()
            )
        );
      }).catchError((error) {
        // Handle authentication error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
      });
    }
  }
  goBackToPreviousScreen(BuildContext context){

    Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundSignIn(),
        Scaffold(
          key: globalScaffoldKey,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldSignin(
                          controller: firstname,
                          obscureText: false,
                          hint: 'First Name',
                        ),
                        TextFieldSignin(
                          controller: lastname,
                          obscureText: false,
                          hint: 'Last Name',
                        ),
                        TextFieldSignin(
                          controller: email,
                          obscureText: false,
                          hint: 'Email',
                        ),
                        TextFieldSignin(
                          controller: password,
                          obscureText: true,
                          hint: 'Password',

                        )
                      ],
                    ),
                  ),
                  loading?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      CircularProgressIndicator(),
                    ],
                  )
                      :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SignInButtons(
                        onPressed: (){
                          goBackToPreviousScreen(context);
                        },
                        buttonName: 'Cancel',
                        color: Colors.grey,
                        textColor: Colors.black,

                      ),
                      const SizedBox(width: 10,),
                      SignInButtons(
                        onPressed: (){
                          validation();
                        },
                        buttonName: 'Register',
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}