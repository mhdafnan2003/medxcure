import 'package:flutter/material.dart';
import 'package:medxecure/screens/home/home.dart';
import 'package:medxecure/screens/map.dart';
import 'package:medxecure/screens/profilepage/profile_page.dart';
import 'package:medxecure/screens/rewards.dart';
import 'package:medxecure/screens/wallet/walletscreen.dart';

class Mainscreen extends StatefulWidget {
  Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _currentIndex = 0; // Track current tab index

  final List<Widget> _pages = [
    HomePage(),
    MapScreen(),
    WalletScreen(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the corresponding page
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // Ensures background color applies correctly
  backgroundColor: Colors.black, // Set background color
  unselectedItemColor: Colors.white, // Color for unselected items
  selectedItemColor: Colors.grey, // Color for selected item
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index; // Update index and reload UI
    });
  },
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Hotspot'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
    BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
  ],
),

    );
  }
}
