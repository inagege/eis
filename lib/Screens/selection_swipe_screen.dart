import 'package:flutter/material.dart';
//Todo: Hier könnt ihr eure Screens auskommentieren, dann unten im switch case noch passenden Screen auskommentieren
import 'yogascreens.dart';
//import 'walk_screen.dart';
//import 'nap_screen.dart';
//import 'Vent_screen.dart';
import 'CoffeeScreen.dart';
import 'CleaningScreen.dart';

// Home Screen with Activity Slides and Icons
class SelectionSwipeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  SelectionSwipeScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor, required this.onScreenSelectionChanged, required this.screenSelection});


  final List<Map<String, dynamic>> activities = [
    {'name': 'Yoga', 'icon': Icons.self_improvement},
    {'name': 'Walk', 'icon': Icons.directions_walk},
    {'name': 'Nap', 'icon': Icons.bed},
    {'name': 'Vent', 'icon': Icons.air},
    {'name': 'Coffee', 'icon': Icons.local_cafe},
    {'name': 'Clean', 'icon': Icons.cleaning_services},
  ];

  @override
  Widget build(BuildContext context) {
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

          // PageView for swiping between activities
          Expanded(
            child: PageView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                var activity = activities[index];
                return GestureDetector(
                  onTap: () {
                    Widget targetScreen;
                    switch (activity['name']) {
                    //Todo: Screen auskommentieren
                    case 'Yoga':
                        targetScreen = YogaScreens(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                    /*case 'Walk':
                        targetScreen = WalkScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Nap':
                        targetScreen = NapScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      case 'Vent':
                        targetScreen = VentScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;*/
                      case 'Clean':
                        targetScreen = CleaningPromptScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                      case 'Coffee':
                        targetScreen = CoffeePromptScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,);
                        break;
                      default:
                        targetScreen = SelectionSwipeScreen(onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,
                        ); // Fallback screen
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => targetScreen),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        activity['icon'],
                        size: 100, // Adjust size as needed
                        color: buttonColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        activity['name'],
                        style: TextStyle(
                          fontSize: 20,
                          color: buttonColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
