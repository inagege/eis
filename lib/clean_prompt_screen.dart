import 'package:eis/clean_video.dart';
import 'package:flutter/material.dart';

class CleaningPromptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double circleSize = 20.0;
    double iconSize = 12.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  color: Color(0xFFFFC0CB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.cleaning_services,
                    color: Colors.black,
                    size: iconSize,
                  ),
                ),
              ),
        ),
        SizedBox(height: 8),

        Text(
          'Cleaning',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'How about some cleaning time?',
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
                  MaterialPageRoute(builder: (context) => CleaningVideoScreen()),
                );
              },
              child: Text(
                'Start your cleaning session!',
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