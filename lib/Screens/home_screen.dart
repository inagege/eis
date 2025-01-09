import 'package:flutter/material.dart';
import 'selection_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;

  HomeScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor});

  // Navigate to Settings Screen
  void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
          onButtonColorChanged: onButtonColorChanged, // Pass button color callback
          buttonColor: buttonColor, // Pass the button color
          buttonTextColor: buttonTextColor, // Pass the button text color
        ),
      ),
    );
  }

  // Navigate to Selection Screen
  void navigateToSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(onThemeChanged: onThemeChanged,
        isDarkMode: isDarkMode,
        onButtonColorChanged: onButtonColorChanged, // Pass button color callback
        buttonColor: buttonColor, // Pass the button color
        buttonTextColor: buttonTextColor, // Pass the button text color
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Settings Button (Smaller)
            ElevatedButton(
              onPressed: () => navigateToSettings(context),
              child: Icon(Icons.settings, color: buttonTextColor),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                side: BorderSide(
                  color: buttonColor,
                  width: 1,
                ),
                shape: CircleBorder(
                  side: BorderSide(
                    color: buttonColor,
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Main text and Start Session Button
            Text(
              'Need a break?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: buttonColor,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => navigateToSelection(context),
              child: Text(
                'Start Session',
                style: TextStyle(color: buttonTextColor, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}