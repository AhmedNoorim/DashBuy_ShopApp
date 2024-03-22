// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(
                  color: Color(0xFF5E0B15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      height: 110,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9CAB3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // image
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 37,
                                backgroundImage:
                                    AssetImage("assets/images/BG.png"),
                              )
                            ],
                          ),

                          // center text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Name",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),

                              // price
                              Text("\$Price")
                            ],
                          ),

                          // count button
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Color(0xFF5E0B15),
                                    ),
                                    onPressed: decrement,
                                  ),
                                  Text(
                                    '$count',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Color(0xFF5E0B15),
                                    ),
                                    onPressed: increment,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 10,
                  padding: EdgeInsets.all(10),
                ),
              ),
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
                          Text("\$450"),
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
