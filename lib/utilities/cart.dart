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
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      height: 130,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9CAB3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // image
                          Column(
                            children: [
                              Icon(
                                Icons.apple,
                                size: 40,
                              )
                            ],
                          ),

                          // center text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text("Description"),
                                ],
                              ),

                              // price
                              Text("\$Price")
                            ],
                          ),

                          // count button
                          Column(),
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
