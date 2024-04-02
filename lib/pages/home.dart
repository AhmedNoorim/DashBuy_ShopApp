// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/utilities/getTransactions.dart';
import 'package:flutter_dash_buy/utilities/getUserName.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //! start - getting active user id from firestore

  String? loggedInUserUID;

  Future<String> getLoggedInUserUID() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      print("User UID: $uid");
      return uid;
    } else {
      print("No user logged in");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  child: GetUserName(loggedInUserUID.toString(), "name"),
                ),
              ),

              // logout
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9CAB3),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Icon(Icons.logout),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFD9CAB3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Text(
                      "Transaction History",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: GetTransactionHistory(loggedInUserUID.toString()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
