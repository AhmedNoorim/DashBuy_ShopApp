import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetTransactionHistory extends StatelessWidget {
  final String documentId;

  GetTransactionHistory(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data!.data();
          if (data != null && data.containsKey("transactionHistory")) {
            List<dynamic> transactionHistory = data["transactionHistory"];
            return ListView.builder(
              itemCount: transactionHistory.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> transaction = transactionHistory[index];
                // Extracting data from the transaction map
                String transactionId = transaction["TransactionID"];
                String date = transaction["Date"];
                double totalPurchase = transaction["TotalPurchase"].toDouble();

                return ListTile(
                  title: Text("Transaction ID: $transactionId"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: $date"),
                      Text(
                          "Total Purchase: \$${totalPurchase.toStringAsFixed(2)}"),
                    ],
                  ),
                );
              },
            );
          } else {
            return Text("No transaction history found");
          }
        }

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        return Text("Loading");
      },
    );
  }
}
