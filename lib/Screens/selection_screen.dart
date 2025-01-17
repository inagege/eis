import 'package:flutter/material.dart';
import 'yogascreens.dart';
import 'walk_start.dart';
import 'nap_start.dart';
import 'air_start.dart';
import 'CoffeeScreen.dart';
import 'CleaningScreen.dart';

// Home Screen with Main Round Buttons and Circle on Top
class SelectionScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  SelectionScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor, required this.onScreenSelectionChanged, required this.screenSelection});

  final List<String> categories = ['Yoga', 'Walk', 'Nap', 'Vent', 'Coffee', 'Clean'];

  @override
  Widget build(BuildContext context) {
    // Calculate button size based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth - 10) / 3; // Subtract padding and spacing

    return Scaffold(
      body: Column(
        children: [
          // Small circle at the top of the screen
          Container(
            margin: EdgeInsets.only(top: 10), // Position circle downwards
            width: 20, // Diameter of the circle
            height: 20,
            decoration: BoxDecoration(
              color: buttonColor, // Light pink color
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.hourglass_bottom, // Replace with the desired icon
                color: buttonTextColor, // Icon color
                size: 15.0, // Adjust size as needed
              ),
            ),
          ),

          // Spacing below the circle
          SizedBox(height: 5),

          // Grid of Round Buttons
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              padding: EdgeInsets.all(25),
              children: categories.map((name) => RoundButton(
                label: name,
                size: buttonSize,
                onPressed: () {
                  Widget targetScreen;
                  switch (name) {
                      case 'Yoga':
                        targetScreen = YogaScreens(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Walk':
                        targetScreen = WalkStartScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Nap':
                        targetScreen = NapStartScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Vent':
                        targetScreen = AirStartScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Coffee':
                        targetScreen = CoffeePromptScreen(
                        onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Clean':
                        targetScreen = CleaningPromptScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                    default:
                      targetScreen = SelectionScreen(onThemeChanged: onThemeChanged,
                        isDarkMode: isDarkMode,
                        onButtonColorChanged: onButtonColorChanged, // Pass button color callback
                        buttonColor: buttonColor, // Pass the button color
                        buttonTextColor: buttonTextColor,
                        onScreenSelectionChanged: onScreenSelectionChanged,
                        screenSelection: screenSelection,// Pass the button text color
                      ); // Fallback screen
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => targetScreen),
                  );
                },
              buttonColor: buttonColor, buttonTextColor: buttonTextColor,))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double size; // Add size parameter
  final Color buttonColor; // Add button color parameter
  final Color buttonTextColor; // Add text color parameter

  const RoundButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.size,
    required this.buttonColor, // Accept button color
    required this.buttonTextColor, // Accept text color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size, // Use dynamic size
        height: size, // Use dynamic size
        decoration: BoxDecoration(
          color: buttonColor, // Set button color dynamically
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: size * 0.2, // Adjust font size based on button size
              color: buttonTextColor, // Set text color dynamically
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
