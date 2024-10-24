import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/authentication/login.dart';
import 'package:recipe_app/homePage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final cnfPassword_controller = TextEditingController();

//signup function
  void signupuser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if (password_controller.text == cnfPassword_controller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email_controller.text,
          password: password_controller.text,
        );

        showCustomSnackbar(context, "Signup succesfully", Colors.green);
        print('hey');


      // closing show Dialog box
        Navigator.pop(context);

        
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Homepage()));
       
       
      } else {
        // closing Dialog box
        Navigator.pop(context);

        //print password didn't message
        print('password did not match');
      }
    } on FirebaseAuthException catch (e) {
      // closing Dialog box
      Navigator.pop(context);

      if (e.code == 'weak-password') {
        print('weak password');
        showCustomSnackbar(context, "Too Weak Password", Colors.red);
      } else if (e.code == 'email-already-exist') {
        print('email-already-exist');
        showCustomSnackbar(context, "email already exist", Colors.red);
      } else {
        print(e.code);
        showCustomSnackbar(context, e.code, Colors.red);
      }
    }
  }

  //snackbar
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/auth/signup.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 85, left: 50, right: 34),
              child: Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: //EdgeInsets.only(top: 200),
                    EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: email_controller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: password_controller,
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: cnfPassword_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
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
                            print(123);
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                signupuser();
                              },
                              icon: Icon(Icons.arrow_forward),
                              iconSize: 23,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>Login()),
                              // );
                              Navigator.pop(context);
                            },
                            child: Text(
                              'already have account',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff4c505b),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            )),
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
//signup page