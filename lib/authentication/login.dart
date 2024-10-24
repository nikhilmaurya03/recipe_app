import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/authentication/signup.dart';
import 'package:recipe_app/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
//  final user = FirebaseAuth.instance.currentUser; // current loggedin user name
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  void showCustomSnackbar(BuildContext context, String message, Color Colour) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colour,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.yellow,
        onPressed: () {
          // Dismiss action code
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // signin method
  void signin() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      showCustomSnackbar(context, "login success", Colors.green);
      print('hello');
    } on FirebaseAuthException catch (e) {
      //Navigator.pop(context);
      if (e.code == "user-not-found") {
        print("user not found");
        showCustomSnackbar(context, "User not found", Colors.red);
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        showCustomSnackbar(context, "Wrong password", Colors.red);
      } else
        showCustomSnackbar(context, e.code, Colors.red);
      // pop the loading circle
    }
    Navigator.pop(context);
  }

  void changePassword(User user) async {
    try {
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      showCustomSnackbar(context, e.code, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/auth/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 85, left: 50, right: 34),
              child: Text(
                'Welcome User',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: //EdgeInsets.only(top: 200),
                    EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.42,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      controller: emailcontroller,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: passwordcontroller,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff4c505b),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            signin();
                            print(" clicked");
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff4c505b),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            )),
                        TextButton(
                            onPressed: () {
                              //await user?.sendEmailVerification();

                              changePassword(user!);
                            },
                            child: Text(
                              'Forget password',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff4c505b),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
