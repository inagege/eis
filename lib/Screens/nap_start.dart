import 'package:flutter/material.dart';
import 'nap_screen.dart';

class NapStartScreen extends StatelessWidget {
  const NapStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App-Symbol oben
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC0CB),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.pause_circle,
                    color: Colors.brown,
                    size: 12,
                  ),
                ),
              ),

              const SizedBox(height: 6), // Abstand verringert

              // Text: "Ready to take a 5 minute nap?"
              const Text(
                'Ready to take a 5 minute nap?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 2), // Abstand verringert

              // Das Bild
              Image.asset(
                'assets/nap_image.png',
                width: 50,
                height: 50,
              ),

              const SizedBox(height: 6), // Abstand verringert

              // Button, der zum NapScreen navigiert
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  minimumSize: const Size(90, 36),
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
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
