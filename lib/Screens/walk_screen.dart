import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eis/main.dart';

class WalkScreen extends StatefulWidget {
  const WalkScreen({Key? key}) : super(key: key);

  @override
  _WalkScreenState createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  // Define the duration of the walk in seconds (5 minutes)
  static const int _walkDurationSeconds = 5 * 60;
  int _remainingSeconds = _walkDurationSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the walk timer when the screen is initialized
    _startWalkTimer();
  }

  @override
  void dispose() {
    // Cancel the timer when leaving the screen to prevent memory leaks
    _timer?.cancel();
    super.dispose();
  }

  void _startWalkTimer() {
    // Creates a periodic timer that decreases the remaining seconds every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        // When the timer reaches zero, stop it and trigger the walk finished action
        timer.cancel();
        _onWalkFinished();
      }
    });
  }

  void _onWalkFinished() {
    // Action triggered when the timer ends, e.g., show a dialog or return to the home screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Insets for dialog margins
        insetPadding: const EdgeInsets.all(8.0),

        // Aligns the dialog actions at the center (from Flutter 2.5 onward)
        actionsAlignment: MainAxisAlignment.center,

        // Padding for the title of the dialog
        titlePadding: const EdgeInsets.only(
          top: 24.0, // Top margin
          left: 16.0,
          right: 16.0,
          bottom: 0.0,
        ),

        // Padding for the actions (e.g., OK button) at the bottom
        actionsPadding: const EdgeInsets.only(
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
        ),

        title: Center(
          // Dialog title text
          child: Text(
            'Time to return!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog and navigate back to the home screen
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate minutes and seconds from the remaining seconds
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;

    return Scaffold(
      // Sets the background color of the screen to black
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Small circular icon at the top of the screen
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 20, // Icon width
                  height: 20, // Icon height
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC0CB), // Background color (pink)
                    shape: BoxShape.circle, // Circular shape
                  ),
                  child: const Center(
                    // Adds a pause icon inside the circle
                    child: Icon(
                      Icons.pause_circle,
                      color: Colors.brown, // Icon color
                      size: 12, // Icon size
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10), // Adds vertical spacing

              // Displays the countdown timer text
              Text(
                'Time remaining: \n${minutes.toString().padLeft(2, '0')}:'
                    '${seconds.toString().padLeft(2, '0')}', // Formats the time as MM:SS
                textAlign: TextAlign.center, // Center-aligns the text
                style: const TextStyle(
                  fontSize: 18, // Font size
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),

              const Spacer(), // Pushes the next widget to the bottom of the screen

              // Button to manually cancel the walk
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800], // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24), // Rounded corners
                      ),
                      minimumSize: const Size(120, 48), // Button size
                    ),
                    onPressed: () {
                      // Cancel the walk and return to the home screen
                      _timer?.cancel();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      'End',
                      style: TextStyle(color: Colors.white, fontSize: 12), // Button text style
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
