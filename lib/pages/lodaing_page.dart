// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/pages/auth_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        color: Color(0xFFD9CAB3),
        child: Stack(
          children: [
            _bgImage(),
            _logo(),
          ],
        ),
      ),
      nextScreen: AuthPage(),
      duration: 3000,
      splashIconSize: 950,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Color(0xFFD9CAB3),
    );
  }

  Widget _bgImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/BG.png"),
          opacity: 0.1,
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Image(
          image: AssetImage("assets/images/logo-text.png"),
          width: 225,
        ),
      ),
    );
  }
}
