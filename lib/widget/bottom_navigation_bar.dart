import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:crypto_wallet_app/screen/profile_page.dart';
import 'package:crypto_wallet_app/screen/transaction_page.dart';
import 'package:crypto_wallet_app/screen/home_page.dart';
import 'package:crypto_wallet_app/screen/chat_assistant.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    TransactionPage(),
    ChatAssistantPage(),
    ProfilePage(), // Another page or any other you want
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(35.0),
          //   topRight: Radius.circular(45.0),
          // ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.yellowAccent[700],
            unselectedItemColor: Colors.white54,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.home, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.heart, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.chat, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBroken.profile, size: 25),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
