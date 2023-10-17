import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/pages/login_screen.dart';

import '../common/constants/color.dart';
import '../services/auth/auth_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Constants constants = Constants();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final FirebaseAuthService _authService = FirebaseAuthService();

  void _signUpUser() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String userName = usernameController.text;

    try {
      await _authService.registerWithEmailPassword(email, password, userName);
      print('User signed up successfully');
      // showDialog(
      //     context: context,
      //     builder: (_) {
      //       return CupertinoAlertDialog(
      //           title: const Text('successes please go to login page'),
      //           actions: [
      //             CupertinoDialogAction(
      //                 onPressed: () {
      //                   Navigator.pushReplacement(context,
      //                       MaterialPageRoute(builder: (_) => const SignInScreen()));
      //                 },
      //                 child: const Text('ok'))
      //           ]);
      //     });
    } on FirebaseAuthException catch (e) {
      print('Sign-up failed: ${e.message}');
      showDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
                title: Text('check your info details \n ${e.code}'),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                        dispose();
                      },
                      child: const Text('ok'))
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: constants.primaryColor.withOpacity(.5),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Signup',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
          child: Container(
            width: size.width * .95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: constants.linearGradientWhiteBlue,
                boxShadow: [
                  BoxShadow(
                      color: constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 5))
                ]),
            child: ListView(children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        // maxLength: 20,
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: "username",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "email",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: "password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: confirmController,
                        decoration: InputDecoration(
                            labelText: "confirm password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty &&
                              passwordController != confirmController) {
                            return 'this field must be the same with password';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _signUpUser();
                          }
                        },
                        child: const Text("confirm")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignInScreen()));
                          },
                          child: const Text("login",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
