import 'package:flutter/material.dart';
import 'screens/nap_start.dart';

void main() {
  runApp(EISApp());
}

class EISApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EIS App',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

// Home Screen with Main Round Buttons and Circle on Top
class HomeScreen extends StatelessWidget {
  final List<String> categories = ['Yoga', 'Walk', 'Nap', 'Vent', 'Coffee', 'Food'];

  @override
  Widget build(BuildContext context) {
    // Calculate button size based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth - 80) / 3; // Subtract padding and spacing

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Small circle at the top of the screen
          Container(
            margin: EdgeInsets.only(top: 10), // Position the circle slightly downwards
            width: 20, // Diameter of the circle
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFFFC0CB), // Light pink color for the circle
              shape: BoxShape.circle, // Makes the container a  circle
            ),
            child: Center(
              child: Icon(
                Icons.pause_circle, // Pause symbol inside the circle
                color: Colors.brown, // Color of the pause symbol
                size: 12, // Size of the pause symbol
              ),
            ),
          ),

          // Spacing below the circle
          SizedBox(height: 10),

          // Grid of Round Buttons
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              padding: EdgeInsets.all(25),
              children: categories
                  .map((name) => RoundButton(
                label: name,
                size: buttonSize,
                onPressed: () {
                  if (name == 'Nap') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NapStartScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScreenRow(category: name)),
                    );
                  }
                },
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Round Button Widget
class RoundButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double size; // Add size parameter

  const RoundButton({super.key,
    required this.label,
    required this.onPressed,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size, // Use dynamic size
        height: size, // Use dynamic size
        decoration: BoxDecoration(
          color: Color(0xFFFFC0CB),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: size * 0.2, color: Color(0xFF4D2324)), // Adjust font size
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Screens in Each Row (Mockups)
class ScreenRow extends StatefulWidget {
  final String category;

  const ScreenRow({super.key, required this.category});

  @override
  _ScreenRowState createState() => _ScreenRowState();
}

class _ScreenRowState extends State<ScreenRow> {
  int currentIndex = 0;

  final Map<String, List<String>> mockupScreens = {
    'Yoga': ['Ready to start?', 'Pose 1', 'Pose 2', 'Done!'],
    'Walk': ['Let\'s go!', 'Midway Check', 'Almost there', 'Done!'],
    'Nap': ['Time to relax', 'Close your eyes', 'Done!'],
    'Vent': ['Share your thoughts', 'All set'],
    'Coffee': ['Enjoy a coffee break'],
    'Food': ['Enjoy some food']
  };

  @override
  Widget build(BuildContext context) {
    List<String> screens = mockupScreens[widget.category] ?? ['Screen'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Screen Text
            Text(
              screens[currentIndex],
              style: TextStyle(fontSize: 24, color: Color(0xFF4D2324)),
            ),
            SizedBox(height: 40),

            // Navigation Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC0CB), // Replace 'primary' with 'backgroundColor'
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                if (currentIndex < screens.length - 1) {
                  setState(() {
                    currentIndex++;
                  });
                } else {
                  // Close app after last screen
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                currentIndex == screens.length - 1 ? 'Done' : 'Next',
                style: TextStyle(fontSize: 18, color: Color(0xFF4D2324)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
