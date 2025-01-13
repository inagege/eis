import 'package:flutter/material.dart';
import 'walk_screen.dart';

class WalkStartScreen extends StatelessWidget {
  const WalkStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sets the background color of the entire screen to black
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Punkt oben wie in den anderen Screens
            Container(
              margin: const EdgeInsets.only(top: 10), // Gleiche Positionierung wie in anderen Screens
              width: 20, // Gleiche Größe wie in anderen Screens
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFFFC0CB), // Gleiche Farbe wie in anderen Screens
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(height: 5), // Abstand wie in anderen Screens

            // Inhalt des WalkStartScreens
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text
                      const Text(
                        'Ready to take a 5 minute walk?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      // Bild
                      Image.asset(
                        'assets/walk_image.png',
                        width: 50,
                        height: 50,
                      ),

                      const SizedBox(height: 12),

                      // Button
                      SizedBox(
                        height: 48,
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const WalkScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Start Walk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
