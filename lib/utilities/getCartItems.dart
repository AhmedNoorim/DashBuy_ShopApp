// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dash_buy/utilities/GrandTotal.dart';

class GetCartItems extends StatefulWidget {
  final String documentId;

  GetCartItems(this.documentId);

  @override
  State<GetCartItems> createState() => _GetCartItemsState();
}

class _GetCartItemsState extends State<GetCartItems> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    double total = 0.0;

    GrandTotal grandTotal = GrandTotal();

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey("cart")) {
            List<dynamic> cart = data["cart"];

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> cartElement =
                    cart[index] as Map<String, dynamic>;
                String cartItemImage = cartElement["image"] ?? "";
                String cartItemName = cartElement["name"] ?? "";
                double cartItemPrice = (cartElement["price"] ?? 0).toDouble();
                int cartItemQuantity = (cartElement["quantity"] ?? 0);
                total += cartItemQuantity * cartItemPrice;
                grandTotal.updateTotal(total);
                print(grandTotal.getTotal());

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
                      Row(
                        children: [
                          // image
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                  radius: 37,
                                  backgroundImage: NetworkImage(cartItemImage))
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // center text
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItemName,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              // price
                              Text("\$$cartItemPrice"),
                            ],
                          ),
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
                                onPressed: () {
                                  // decrement
                                  int decrementedCount = cartItemQuantity > 0
                                      ? cartItemQuantity - 1
                                      : 0;
                                  updateCartItemQuantity(widget.documentId,
                                      index, decrementedCount);
                                },
                              ),
                              Text(
                                cartItemQuantity.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Color(0xFF5E0B15),
                                ),
                                onPressed: () {
                                  // increment
                                  int incrementedCount = cartItemQuantity + 1;
                                  updateCartItemQuantity(widget.documentId,
                                      index, incrementedCount);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: const Text("No Cart Item found",
                  style: TextStyle(color: Color(0xFFD9CAB3))),
            );
          }
        }

        return Center(
          child:
              const Text("Loading", style: TextStyle(color: Color(0xFFD9CAB3))),
        );
      },
    );
  }

  void updateCartItemQuantity(
      String documentId, int itemIndex, int newQuantity) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot snapshot = await users.doc(documentId).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> cart = data['cart'];
      cart[itemIndex]['quantity'] = newQuantity;
      await users.doc(documentId).update({'cart': cart});
      setState(() {});
    } else {
      print('Document does not exist');
    }
  }
}
