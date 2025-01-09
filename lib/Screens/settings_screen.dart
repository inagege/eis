import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  SettingsScreen({required this.onThemeChanged, required this.isDarkMode});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode; // Local state to manage immediate theme changes

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode; // Initialize with the current global theme
  }

  void _updateTheme(bool isDarkMode) async {
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);

    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Apply the local theme to this screen only
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Switch to toggle dark mode locally
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value; // Update the local theme state
                });
                _updateTheme(_isDarkMode);
              },
            ),
            SizedBox(height: 20),
            // Confirm button to apply the theme globally
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                widget.onThemeChanged(_isDarkMode); // Apply the global theme
                Navigator.pop(context); // Return to the previous screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
