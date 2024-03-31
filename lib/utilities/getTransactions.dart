import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey("transactionHistory")) {
            List<dynamic> transactionHistory = data["transactionHistory"];

            // ! List View
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: transactionHistory.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> transaction =
                    transactionHistory[index] as Map<String, dynamic>;
                String transactionId = transaction["transactionID"] ?? "";
                Timestamp dateTimestamp =
                    transaction["transactionDate"] as Timestamp;
                String date = DateFormat('yyyy-MM-dd, HH:mm')
                    .format(dateTimestamp.toDate());
                double totalPurchase =
                    (transaction["totalPurchase"] ?? 0).toDouble();

                return Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E0B15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        color: Color(0xFFD9CAB3),
                        fontFamily: "Poppins",
                        fontSize: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Transaction ID"),
                            Text(
                              transactionId,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Date"),
                            Text(
                              date,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Purchase"),
                            Text(
                              "\$${totalPurchase.toStringAsFixed(2)}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("No transaction history found");
          }
        }

        return const Text("Loading");
      },
    );
  }
}

//                         itemBuilder: (context, index) {
//                           return Container(
//                             padding: EdgeInsets.all(20),
//                             margin: EdgeInsets.only(bottom: 5, top: 5),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF5E0B15),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: DefaultTextStyle(
//                               style: TextStyle(
//                                   color: Color(0xFFD9CAB3),
//                                   fontFamily: "Poppins",
//                                   fontSize: 18),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Transaction ID"),
//                                       Text(
//                                         "$transactionId",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Date"),
//                                       Text(
//                                         "$date",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Total Purchase"),
//                                       Text(
//                                         "\$${totalPurchase.toStringAsFixed(2)}",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         padding: EdgeInsets.all(10),
//                       ),