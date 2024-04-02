import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> GetCartData(String itemName, BuildContext context) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('items')
        .doc(itemName.toString())
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> itemData =
          documentSnapshot.data() as Map<String, dynamic>;
      // Assuming your document has fields named field1, field2, and field3
      print("-----------------------itemData-------------------------");
      var name = itemData['name'];
      var price = itemData['price'];
      var image = itemData['image'];

      // Now you have your three fields saved into variables
      print('Field 1: $name');
      print('Field 2: $price');
      print('Field 3: $image');

      _updateCart(context, name, price.toDouble(), image);
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching and saving data: $e');
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
