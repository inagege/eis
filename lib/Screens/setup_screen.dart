import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_first_run/is_first_run.dart';
import 'home_screen.dart';

class SetupScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  SetupScreen({required this.onThemeChanged, required this.isDarkMode});

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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'This app requires access to:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Local Network Devices\nSamsung Health',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
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
