// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isLoading = false;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      "Notes",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _textEditingController,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: "Enter your text here",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  ElevatedButton(
                    onPressed: _saveNote,
                    child: _isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Save',
                            style: TextStyle(
                              color: Color(0xFF5E0B15),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                          ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _saveNote() async {
    setState(() {
      _isLoading = true;
    });

    final String noteText = _textEditingController.text.trim();

    // Add the note to Firebase
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'note': noteText,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Note saved successfully'),
    ));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    setState(() {
      _isLoading = true;
    });

    final DocumentSnapshot noteSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (noteSnapshot.exists) {
      final String? noteText =
          (noteSnapshot.data() as Map<String, dynamic>?)?['note'] as String?;
      if (noteText != null) {
        _textEditingController.text = noteText;
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
