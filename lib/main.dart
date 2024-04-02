// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dash_buy/pages/testPage.dart';
import 'package:flutter_dash_buy/utilities/cart.dart';
import 'package:flutter_dash_buy/utilities/getTransactions.dart';
import 'package:flutter_dash_buy/utilities/getUserName.dart';
import 'firebase_options.dart';

import 'package:flutter_dash_buy/pages/login_page.dart';
import 'package:flutter_dash_buy/pages/common_page.dart';
import 'package:flutter_dash_buy/pages/lodaing_page.dart';
import 'package:flutter_dash_buy/pages/qr_cam.dart';
import 'package:flutter_dash_buy/pages/reciept.dart';

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
      // home: TestPage(),
      // home: GetUserName("71tcjdPFWkSDYgvJjsPmzERxx3r2", "name"),
      routes: {
        '/common': (context) => CommonPage(),
        '/login': (context) => LogInPage(),
        '/cart': (context) => CartPage(),
      },
      // home: LogInPage(),
      // home: SafeArea(child: CommonPage()),
      // home: SafeArea(child: Reciept()),
      // home: SafeArea(child: QrScanner()),
      // home: SafeArea(
      //   child: GetTransactionHistory("71tcjdPFWkSDYgvJjsPmzERxx3r2"),
      // ),
    );
  }
}

// items {
// 	id, name, price, image
// }
// -----> scanner(scan product) ---> check if product is in items
// ---> if true return (name, price, image) ---> user.cart

// user {
// 	id, name, email, pass, image, transactionHistory{transID, date, totalPurchase}, cart, note
// }
//  -----> take (name, image, transHistory) ---> when checkout then push(cart) to transHistory
//  -----> take note from firestore ---> update note and push(note) to firestore  