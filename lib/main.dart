import 'package:flutter/material.dart';
import 'Screens/setup_screen.dart';
import 'Screens/home_screen.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure widgets are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  // Check if it's the first start
  final bool firstStart = await IsFirstRun.isFirstRun();

  // Run the app
  runApp(EISApp(firstStart: firstStart, isDarkMode: isDarkMode));
}

class EISApp extends StatefulWidget {
  final bool firstStart;
  final bool isDarkMode;

  EISApp({required this.firstStart, required this.isDarkMode});

  @override
  _EISAppState createState() => _EISAppState();
}

class _EISAppState extends State<EISApp> {
  late bool _isDarkMode;
  Color _buttonColor = Color(0xFFFFC0CB); // Default button color (light red)
  Color _buttonTextColor = Color(0xFF4D2324); // Default button text color

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _updateTheme(bool isDarkMode) async {
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);

    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  // Method to update button color and text color
  void _updateButtonColors(Color buttonColor, Color buttonTextColor) {
    setState(() {
      _buttonColor = buttonColor;
      _buttonTextColor = buttonTextColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EIS App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: widget.firstStart
          ? SetupScreen(
        onThemeChanged: _updateTheme,
        isDarkMode: _isDarkMode,
        onButtonColorChanged: _updateButtonColors, // Pass button color callback
        buttonColor: _buttonColor, // Pass the button color
        buttonTextColor: _buttonTextColor, // Pass the button text color
      )
          : HomeScreen(
        onThemeChanged: _updateTheme,
        isDarkMode: _isDarkMode,
        onButtonColorChanged: _updateButtonColors, // Pass button color callback
        buttonColor: _buttonColor, // Pass the button color
        buttonTextColor: _buttonTextColor, // Pass the button text color
      ),
    );
  }
}
