// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'get_item_data.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String _scanResult = "Nothing";

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanCode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "Failed To Scan";
    }

    setState(() {
      _scanResult = barcodeScanRes;
    });

    GetCartData(_scanResult, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/BG.png"),
        fit: BoxFit.cover,
        opacity: 0.2,
      )),
      alignment: Alignment.center,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$_scanResult is added to cart!",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50))),
            onPressed: () {
              scanCode();
            },
            child: Text(
              "Scan Product",
              style: TextStyle(
                color: Color(0xFF5E0B15),
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
