import 'package:eis/main.dart';
import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Oben Titel "Break Time"
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  'Break Time',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFD3D3D3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Mittiger Text
            Expanded(
              child: Center(
                child: Text(
                  'Based on your Biosignals\nit would be time for a break',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFD3D3D3),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Navigationsbutton "Start break"
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD3D3D3), // Button-Hintergrund
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  // Navigation zu YogaScreens
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text(
                  'Start break',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4D2324)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
