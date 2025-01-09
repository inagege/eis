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
        // Ensures content is displayed safely within visible areas, e.g., below status bars
        child: SingleChildScrollView(
          child: Padding(
            // Adds spacing between the top edge and the content
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              // Centers the child widgets vertically
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Creates a circular container widget as the app icon
                Container(
                  width: 20, // Width of the container
                  height: 20, // Height of the container
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC0CB), // Sets the background color (pink)
                    shape: BoxShape.circle, // Makes the container circular
                  ),
                  child: const Center(
                    // Adds an icon to the center of the container
                    child: Icon(
                      Icons.pause_circle,
                      color: Colors.brown, // Icon color
                      size: 12, // Icon size
                    ),
                  ),
                ),

                // Adds vertical spacing between widgets
                const SizedBox(height: 6),

                // Displays the welcome text
                const Text(
                  'Ready to take a 5 minute walk?', // Text content
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 14, // Font size
                  ),
                  textAlign: TextAlign.center, // Horizontally centers the text
                ),

                // Adds vertical spacing
                const SizedBox(height: 2),

                // Displays an image from the app's assets
                Image.asset(
                  'assets/walk_image.png', // Image path
                  width: 50, // Image width
                  height: 50, // Image height
                ),

                // Adds vertical spacing
                const SizedBox(height: 6),

                // Creates a button to navigate to the next screen
                SizedBox(
                  height: 48, // Button height
                  width: 120, // Button width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      // Navigates to the "WalkScreen" screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WalkScreen(),
                        ),
                      );
                    },
                    // Text displayed on the button
                    child: const Text(
                      'Start Walk',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 12, // Font size
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
