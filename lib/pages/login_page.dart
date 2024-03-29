// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// user@gmail.com password
// test@email.com test01

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dash_buy/pages/auth.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("--------Successful--------");
      Navigator.pushNamed(context, "/common");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF90323D),
      body: Stack(
        children: [
          _bgImage(),
          _authOptions(),
        ],
      ),
    );
  }

  Widget _bgImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/BG.png"),
          opacity: 0.6,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
        ),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
    );
  }

  Widget _authOptions() {
    return Center(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // page text
            RichText(
              text: TextSpan(
                text: "every\npurchase is just a ",
                style: TextStyle(
                  color: Color(0xFFD9CAB3),
                  fontFamily: "Poppins",
                  fontSize: 46,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(1),
                      blurRadius: 40,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "DASH",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: " away!",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              children: [
                // text box
                Column(
                  children: [
                    // email or phone
                    TextField(
                      controller: emailController,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Color(0xFF5E0B15),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Email or Phone',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5E0B15),
                        ),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Color(0xFFD9CAB3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // while writing
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // password
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Color(0xFF5E0B15),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5E0B15),
                        ),
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: Color(0xFFD9CAB3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // while writing
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 16,
                ),
                // buttons -> login, Signup
                Row(
                  children: [
                    // log in
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF5E0B15)),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color(0xFFD9CAB3),
                              width: 2,
                            ),
                          ),
                        ),

                        // ! on press
                        onPressed: _signIn,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                          child: Text(
                            "Log IN",
                            style: TextStyle(
                                color: Color(0xFFD9CAB3),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 8,
                    ),
                    // sign up
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFD9CAB3)),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Color(0xFFD9CAB3),
                              width: 2,
                            ),
                          ),
                        ),

                        // ! on press
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                          child: Text(
                            "Sign UP",
                            style: TextStyle(
                                color: Color(0xFF5E0B15),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
