import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_first_run/is_first_run.dart';
import 'home_screen.dart';

class SetupScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  SetupScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor, required this.onScreenSelectionChanged, required this.screenSelection});

  void _handleDeny(BuildContext context) async {
    // Reset first run status
    await IsFirstRun.reset();

    Future.delayed(Duration.zero, () {
      SystemNavigator.pop(); // Exits the application
    });
  }

  void _handleAgree(BuildContext context) {
    // Navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
            onThemeChanged: onThemeChanged,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
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
                  Icons.settings, // Replace with the desired icon
                  color: buttonTextColor, // Icon color
                  size: 15.0, // Adjust size as needed
                ),
              ),
            ),

            // Spacing below the circle
            SizedBox(height: 10),
            Text(
              'This app requires\naccess to:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Local Network Devices\nSamsung Health',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 90, // <-- match_parent
                    height: 50, // <-- match-parent
                    child:
                      ElevatedButton(
                        onPressed: () => _handleDeny(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text('Deny'),
                      ),
                ),
                SizedBox(
                    width: 90, // <-- match_parent
                    height: 50, // <-- match-parent
                    child:
                      ElevatedButton(
                        onPressed: () => _handleAgree(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: Text('Agree'),
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
