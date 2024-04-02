// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_dash_buy/utilities/qr_cam.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // top box
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xFFD9CAB3),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Scan Barcode",
                style: TextStyle(
                  color: Color(0xFF5E0B15),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // camera qr scan display
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9CAB3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: QrScanner(),
            ),
          )
        ],
      ),
    );
  }
}
