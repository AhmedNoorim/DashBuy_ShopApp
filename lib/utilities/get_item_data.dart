import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> GetCartData(String itemName, BuildContext context) async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('items')
      .doc(itemName.toString())
      .get();

  if (documentSnapshot.exists) {
    Map<String, dynamic> itemData =
        documentSnapshot.data() as Map<String, dynamic>;

    var name = itemData['name'];
    var price = itemData['price'];
    var image = itemData['image'];

    _updateCart(context, name, price.toDouble(), image);
  } else {
    print('Document does not exist');
  }
}

Future<void> _updateCart(
    BuildContext context, String name, double price, String image) async {
  // Get current user's UID
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    // Handle the case when user is not logged in
    return;
  }

  // Push the new map to Firebase
  await FirebaseFirestore.instance.collection('users').doc(uid).update({
    'cart': FieldValue.arrayUnion([
      {
        'name': name,
        'price': price,
        'image': image,
        'quantity': 1,
      }
    ]),
  });
}
