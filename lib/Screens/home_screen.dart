import 'package:flutter/material.dart';
import 'selection_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  HomeScreen({required this.onThemeChanged, required this.isDarkMode});

  // Navigate to Settings Screen
  void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
        ),
      ),
    );
  }

  // Navigate to Selection Screen
  void navigateToSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(
        onThemeChanged: onThemeChanged,
        isDarkMode: isDarkMode,
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
              child: Icon(Icons.settings, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                side: BorderSide(
                  color: Color(0xFFFFC0CB),
                  width: 1,
                ),
                shape: CircleBorder(
                  side: BorderSide(
                    color: Color(0xFFFFC0CB),
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
                color: Color(0xFFFFC0CB),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => navigateToSelection(context),
              child: Text(
                'Start Session',
                style: TextStyle(color: Color(0xFF4D2324), fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC0CB),
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
