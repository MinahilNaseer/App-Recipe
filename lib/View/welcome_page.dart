
import 'package:firstapp/View/signin_page.dart';
import 'package:flutter/material.dart';

import '../Model/auth_repository.dart';
import '../viewModel/auth_repository_impl.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  gotoFirstActivity(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
  gotoSecondActivity(BuildContext context){
    final AuthenticationRepository authenticationRepository = AuthRepositoryImpl();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn(authenticationRepository: authenticationRepository,)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Center(
                child: Image.asset(
                    'assets/foodie.jpeg',
                  fit: BoxFit.cover,
                  width: 280,
                ),
              ),
          ),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Welcome to Foodie',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                          'Improve your cooking skills and enjoy delicious food',
                        style: TextStyle(
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 60,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          gotoFirstActivity(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                  ),
                  SizedBox(
                      height: 60,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          gotoSecondActivity(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),
                        child: const Text(
                          'SignIn',
                          style: TextStyle(
                              color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }
}
