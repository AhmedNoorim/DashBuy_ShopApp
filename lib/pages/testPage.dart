import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // ! start - user id
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
  // ! end - user id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In User UID'),
      ),
      body: Center(
        child: loggedInUserUID != null
            ? Text('Logged In User UID: $loggedInUserUID')
            : CircularProgressIndicator(), // Show a loading indicator if UID is being fetched
      ),
    );
  }
}
