// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/utilities/GrandTotal.dart';
import 'package:flutter_dash_buy/utilities/getCartItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

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
                            onPressed: () {
                              _checkout(context);
                              Navigator.pushNamed(context, "/common");
                            },
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

  Future<void> _checkout(BuildContext context) async {
    try {
      // Get current user's UID
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        // Handle the case when user is not logged in
        return;
      }

      // Generate a unique transaction ID
      String transactionId = _generateTransactionId();

      // Get the total purchase amount
      double totalPurchase = _getTotalPurchase();

      // Get the current date
      DateTime currentDate = DateTime.now();

      // Push the new map to Firebase
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'transactionHistory': FieldValue.arrayUnion([
          {
            'transactionID': transactionId.toString(),
            'totalPurchase': totalPurchase,
            'transactionDate': Timestamp.fromDate(currentDate),
          }
        ]),
      });

      // Clear the cart array to Firebase
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'cart': FieldValue.delete(),
      });

      // Clear Grand Total
      GrandTotal grandTotal = GrandTotal();
      grandTotal.updateTotal(0.00);

      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Checkout successful!'),
        ),
      );
    } catch (e) {
      print('Error during checkout: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred during checkout.'),
        ),
      );
    }
  }

  String _generateTransactionId() {
    // Generate a random 6-digit number as the transaction ID
    Random random = Random();
    int randomNumber = random.nextInt(900000) +
        100000; // Generates a number between 100000 and 999999
    return 'TID-$randomNumber'; // Customize the prefix as needed
  }

  double _getTotalPurchase() {
    return grandTotal.getTotal();
  }
}
