import 'package:flutter/material.dart';
//Todo: Hier könnt ihr eure Screens auskommentieren, dann unten im switch case noch passenden Screen auskommentieren
//import 'Screens/yoga_screen.dart';
//import 'Screens/walk_screen.dart';
//import 'Screens/nap_screen.dart';
//import 'Screens/air_screen.dart';
//import 'Screens/coffee_screen.dart';
//import 'Screens/clean_screen.dart';

// Home Screen with Main Round Buttons and Circle on Top
class SelectionScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;

  SelectionScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor});

  final List<String> categories = ['Yoga', 'Walk', 'Nap', 'Air', 'Coffee', 'Clean'];

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
                  //Todo: Screen auskommentieren
                  /*case 'Yoga':
                      targetScreen = YogaScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;
                    case 'Walk':
                      targetScreen = WalkScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;
                    case 'Nap':
                      targetScreen = NapScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;
                    case 'Vent':
                      targetScreen = VentScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;
                    case 'Coffee':
                      targetScreen = CoffeeScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;
                    case 'Food':
                      targetScreen = FoodScreen(onThemeChanged: onThemeChanged,
            isDarkMode: isDarkMode,
            onButtonColorChanged: onButtonColorChanged, // Pass button color callback
            buttonColor: buttonColor, // Pass the button color
            buttonTextColor: buttonTextColor, // Pass the button text color
        );
                      break;*/
                    default:
                      targetScreen = SelectionScreen(onThemeChanged: onThemeChanged,
                        isDarkMode: isDarkMode,
                        onButtonColorChanged: onButtonColorChanged, // Pass button color callback
                        buttonColor: buttonColor, // Pass the button color
                        buttonTextColor: buttonTextColor, // Pass the button text color
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
