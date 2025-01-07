import 'package:flutter/material.dart';
import 'coffee_video.dart';

class CoffeePromptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double circleSize = 20.0;
    double iconSize = 12.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
          child: Column(
            children: [
              // Use Padding to control top spacing consistently
              Padding(
                padding: const EdgeInsets.only(top: 10.0), // Adjust this value as needed
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC0CB),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.local_cafe,
                      color: Colors.brown,
                      size: iconSize,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Coffee',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'How about a coffee break?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 36),

              Center( // Center the button horizontally
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    minimumSize: Size(120, 48),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoffeeVideoScreen()),
                    );
                  },
                  child: Text(
                    'Start coffee machine!',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}