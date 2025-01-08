import 'package:flutter/material.dart';
//Todo: Hier könnt ihr eure Screens auskommentieren, dann unten im switch case noch passenden Screen auskommentieren
//import 'Screens/yoga_screen.dart';
//import 'Screens/walk_screen.dart';
//import 'Screens/nap_screen.dart';
//import 'Screens/air_screen.dart';
//import 'Screens/coffee_screen.dart';
//import 'Screens/clean_screen.dart';

// Home Screen with Main Round Buttons and Circle on Top
class HomeScreen extends StatelessWidget {

  final List<String> categories = ['Yoga', 'Walk', 'Nap', 'Air', 'Coffee', 'Clean'];

  @override
  Widget build(BuildContext context) {
    // Calculate button size based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth - 10) / 3; // Subtract padding and spacing

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Small circle at the top of the screen
          Container(
            margin: EdgeInsets.only(top: 10), // Position circle downwards
            width: 20, // Diameter of the circle
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFFFC0CB), // Light pink color
              shape: BoxShape.circle,
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
                      targetScreen = YogaScreen();
                      break;
                    case 'Walk':
                      targetScreen = WalkScreen();
                      break;
                    case 'Nap':
                      targetScreen = NapScreen();
                      break;
                    case 'Vent':
                      targetScreen = VentScreen();
                      break;
                    case 'Coffee':
                      targetScreen = CoffeeScreen();
                      break;
                    case 'Food':
                      targetScreen = FoodScreen();
                      break;*/
                    default:
                      targetScreen = HomeScreen(); // Fallback screen
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => targetScreen),
                  );
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