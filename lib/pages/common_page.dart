// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash_buy/utilities/cart.dart';
import 'package:flutter_dash_buy/utilities/home.dart';
import 'package:flutter_dash_buy/utilities/notes.dart';
import 'package:flutter_dash_buy/utilities/qr.dart';

class CommonPage extends StatefulWidget {
  const CommonPage({super.key});

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    CartPage(),
    NotesPage(),
    QRPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90323D),
      body: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          _bgImage(),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
              child: _pages[_selectedIndex],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: _bottomNav(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigateBottomBar,
        backgroundColor: Color(0xFF5E0B15),
        unselectedItemColor: Color(0xFFD9CAB3),
        selectedItemColor: Color(0xFFFFFFFF),
        items: [
          // home
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),

          // cart
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            activeIcon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            label: 'Cart',
          ),

          // notes
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note_outlined,
            ),
            activeIcon: Icon(
              Icons.note,
              size: 30,
            ),
            label: 'Notes',
          ),

          // QR
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code,
            ),
            activeIcon: Icon(
              Icons.qr_code_scanner,
              size: 30,
            ),
            label: 'QR',
          ),
        ],
      ),
    );
  }

  Widget _bgImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/BG.png"),
          opacity: 0.6,
        ),
      ),
    );
  }
}
