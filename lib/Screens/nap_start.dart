import 'package:flutter/material.dart';
import 'nap_screen.dart';

class NapStartScreen extends StatelessWidget {
  const NapStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Punkt oben wie im HomeScreen
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 20, // Gleiche Größe wie im HomeScreen
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFFFC0CB), // Gleiche Farbe wie im HomeScreen
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(height: 5), // Spacing unter dem Punkt

            // Hauptinhalt des Screens
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Entfernt: Der alte Punkt (40x40 Kreis) wurde gelöscht.

                      // Text für die Aufforderung
                      const Text(
                        'Ready to take a 5 minute nap?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Bild
                      Image.asset(
                        'assets/nap_image.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 12),

                      // Start Nap Button
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
                                builder: (context) => const NapScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Start Nap',
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
