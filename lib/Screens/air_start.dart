import 'package:flutter/material.dart';
import 'Air_screen.dart';

class AirStartScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  AirStartScreen({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Adjusted small circle at the top of the screen
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: buttonColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.air,
                  color: buttonTextColor,
                  size: 15.0,
                ),
              ),
            ),

            SizedBox(height: 5),

            // Inhalt des AirStartScreens
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Should I open the window for you?',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? buttonColor : buttonTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 2),

                      Icon(
                        Icons.air,
                        color: isDarkMode ? buttonColor : buttonTextColor,
                        size: 37.0,
                      ),

                      const SizedBox(height: 6),

                      SizedBox(
                        width: 120, // <-- match_parent
                        height: 50, // <-- match-parent
                        child:
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AirScreen(onThemeChanged: onThemeChanged,
                                  isDarkMode: isDarkMode,
                                  onButtonColorChanged: onButtonColorChanged,
                                  buttonColor: buttonColor,
                                  buttonTextColor: buttonTextColor,
                                  onScreenSelectionChanged: onScreenSelectionChanged,
                                  screenSelection: screenSelection,),
                              ),
                            );
                          },
                          child: Text(
                            'Yes!',
                            style: TextStyle(color: buttonTextColor, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
