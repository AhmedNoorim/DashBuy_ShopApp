// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

          // profile
          // ProfileTop(),

          SizedBox(
            height: 10,
          ),

          // card container
          // _cardContainer(),
          Expanded(
            child: Container(
              height: 100,
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
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFF5E0B15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: Color(0xFFD9CAB3),
                                fontFamily: "Poppins",
                                fontSize: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Transaction ID"),
                                    Text(
                                      "#2134ik22r",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Date"),
                                    Text(
                                      "22-Jan-2024",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Purchase"),
                                    Text(
                                      "\$460",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _cardContainer() {
  //   return ListView(
  //     children: [
  //       Container(
  //         height: 100,
  //         color: Colors.blue,
  //       ),
  //     ],
  //   );
  // }
}
