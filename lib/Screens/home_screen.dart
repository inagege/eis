import 'package:flutter/material.dart';
//Todo: Hier könnt ihr eure Screens auskommentieren, dann unten im switch case noch passenden Screen auskommentieren
import 'selection_screen.dart';
import 'settings_screen.dart';
import 'selection_swipe_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  HomeScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor, required this.onScreenSelectionChanged, required this.screenSelection});

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
          onScreenSelectionChanged: onScreenSelectionChanged,
          screenSelection: screenSelection,
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
        onScreenSelectionChanged: onScreenSelectionChanged,
        screenSelection: screenSelection,
      )),
    );
  }

  // Navigate to Selection Swipe Screen
  void navigateToSelectionSwipe(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionSwipeScreen(onThemeChanged: onThemeChanged,
        isDarkMode: isDarkMode,
        onButtonColorChanged: onButtonColorChanged, // Pass button color callback
        buttonColor: buttonColor, // Pass the button color
        buttonTextColor: buttonTextColor, // Pass the button text color
        onScreenSelectionChanged: onScreenSelectionChanged,
        screenSelection: screenSelection,
      )),
    );
  }

  void navigateBasedOnSelection(String screenSelection, BuildContext context) {
    if (screenSelection == 'Grid') {
      // Navigate to SelectionScreen
      navigateToSelection(context);
    } else {
      // Navigate to SelectionSwipeScreen
      navigateToSelectionSwipe(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
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
                color: isDarkMode ? buttonColor : buttonTextColor,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 160, // <-- match_parent
              height: 50, // <-- match-parent
              child:
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                onPressed: () => navigateBasedOnSelection(screenSelection, context),
                child: Text(
                  'Start Session',
                  style: TextStyle(
                      color: buttonTextColor,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
