import 'package:flutter/material.dart';

class CleaningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  width: 20,
                  height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFFFC0CB),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.cleaning_services,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 32),

              Text(
                'Time to tidy up and make your space shine!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(), // Key change: adds space to push button down

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center( // Center the button horizontally
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: const Size(120, 48),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
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