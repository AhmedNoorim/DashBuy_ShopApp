// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/pages/auth_page.dart';
import 'package:flutter_dash_buy/pages/common_page.dart';
import 'package:flutter_dash_buy/pages/lodaing_page.dart';
import 'package:flutter_dash_buy/pages/qr_cam.dart';
import 'package:flutter_dash_buy/pages/reciept.dart';

void main() {
  runApp(const DashBuyApp());
}

class DashBuyApp extends StatelessWidget {
  const DashBuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoadingPage(),
      // home: AuthPage(),
      home: SafeArea(child: CommonPage()),
      // home: SafeArea(child: Reciept()),
      // home: SafeArea(child: QrScanner()),
    );
  }
}
