// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Stack(
        children: [
          _bgImage(),
          _logo(),
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
