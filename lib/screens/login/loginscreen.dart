import 'package:flutter/material.dart';
class CenteredTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hello, Flutter!',
          style: TextStyle(fontSize: 12), // Small text size
        ),
      ),
    );
  }
}