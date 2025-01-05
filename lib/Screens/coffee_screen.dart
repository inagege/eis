import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart'; // For controlling screen orientation

class CoffeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Take a Coffee Break ☕',
              style: TextStyle(fontSize: 20, color: Colors.brown, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          // Spacing
          SizedBox(height: 20),

          // GIF or Video
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/coffee.gif', // Ensure you have this file in the assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Spacing
          SizedBox(height: 20),

          // Button to Return Home
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Go back to Home Screen
            },
            child: Text(
              'Back to Home',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
