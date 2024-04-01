// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/utilities/GrandTotal.dart';
import 'package:flutter_dash_buy/utilities/getCartItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //! start - getting active user id from firestore
  String? loggedInUserUID;

  Future<String> getLoggedInUserUID() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the function to get the UID of the logged-in user
    getLoggedInUserUID().then((uid) {
      setState(() {
        loggedInUserUID = uid;
      });
    });
  }
  //! end - getting active user id from firestore

  GrandTotal grandTotal = GrandTotal();

  double total = 0.0;

  void _updateTotal() {
    total = grandTotal.getTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _updateTotal();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTextStyle(
        style: TextStyle(
          // color: Color(0xFFD9CAB3),
          color: Color(0xFF000000),
          fontFamily: "Poppins",
          fontSize: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Text(
                  "My Cart",
                  style: TextStyle(
                      color: Color(0xFFD9CAB3),
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF5E0B15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GetCartItems(loggedInUserUID.toString())),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9CAB3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // grand total
                    DefaultTextStyle(
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Grand Total"),
                          Text("\$ $total"),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    // checkout button
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF5E0B15),
                                padding: EdgeInsets.all(10)),
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                  color: Color(0xFFD9CAB3),
                                  fontFamily: "Poppins",
                                  fontSize: 27),
                            ),
                          ),
                        ),
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
