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
  runApp(EISApp(firstStart: firstStart));
}

class EISApp extends StatefulWidget {
  final bool firstStart;

  EISApp({required this.firstStart});

  @override
  _EISAppState createState() => _EISAppState();
}

class _EISAppState extends State<EISApp> {
  bool _isDarkMode = true;

  void _updateTheme(bool isDarkMode) async {
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);

    setState(() {
      _isDarkMode = isDarkMode;
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
      )
          : HomeScreen(
        onThemeChanged: _updateTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}
