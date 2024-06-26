// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dash_buy/pages/login_page.dart';
import 'package:flutter_dash_buy/pages/common_page.dart';
import 'package:flutter_dash_buy/pages/lodaing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DashBuyApp());
}

class DashBuyApp extends StatelessWidget {
  const DashBuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        '/common': (context) => CommonPage(),
        '/login': (context) => LogInPage(),
      },
    );
  }
}

// items {
// 	name, price, image
// }
// -----> scanner(scan product) ---> check if product is in items
// ---> if true return (name, price, image) ---> user.cart

// user {
// 	name, transactionHistory{transID, date, totalPurchase}, cart{items}, note
// }

//  -----> take (name, image, transHistory) ---> when checkout then push(cart) to transHistory
//  -----> take note from firestore ---> update note and push(note) to firestore  