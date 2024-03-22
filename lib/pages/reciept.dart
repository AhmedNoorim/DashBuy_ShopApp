import 'package:flutter/material.dart';

class Reciept extends StatelessWidget {
  const Reciept({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90323D),
      body: _bgImage(),
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
    );
  }
}
