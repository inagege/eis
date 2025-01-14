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
  final Color buttonColor = Color(prefs.getInt('buttonColor') ?? 0xFFFFC0CB);
  final Color buttonTextColor = Color(prefs.getInt('buttonTextColor') ?? 0xFF4D2324);
  final String screenSelection = prefs.getString('ScreenSelection') ?? 'Grid';

  // Check if it's the first start
  final bool firstStart = await IsFirstRun.isFirstRun();

  // Run the app
  runApp(EISApp(firstStart: firstStart, isDarkMode: isDarkMode, buttonColor: buttonColor, buttonTextColor: buttonTextColor, screenSelection: screenSelection));
}

class EISApp extends StatefulWidget {
  final bool firstStart;
  final bool isDarkMode;
  final Color buttonColor;
  final Color buttonTextColor;
  final String screenSelection;

  EISApp({required this.firstStart, required this.isDarkMode, required this.buttonColor, required this.buttonTextColor, required this.screenSelection});

  @override
  _EISAppState createState() => _EISAppState();
}

class _EISAppState extends State<EISApp> {
  late bool _isDarkMode;
  late Color _buttonColor;
  late Color _buttonTextColor;
  late String _screenSelection;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _buttonColor = widget.buttonColor;
    _buttonTextColor = widget.buttonTextColor;
    _screenSelection = widget.screenSelection;
  }

  void _updateTheme(bool isDarkMode) async {
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);

    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  // Method to update button color and text color and save them to SharedPreferences
  void _updateButtonColors(Color buttonColor, Color buttonTextColor) async {
    final prefs = await SharedPreferences.getInstance();

    // Save colors as ARGB values
    await prefs.setInt('buttonColor', buttonColor.value);
    await prefs.setInt('buttonTextColor', buttonTextColor.value);

    setState(() {
      _buttonColor = buttonColor;
      _buttonTextColor = buttonTextColor;
    });
  }

  // Method to update button color and text color and save them to SharedPreferences
  void _updateScreenSelection(String screenSelection) async {
    final prefs = await SharedPreferences.getInstance();

    // Save colors as ARGB values
    await prefs.setString('screenSelection', screenSelection);

    setState(() {
      _screenSelection = screenSelection;
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
        onScreenSelectionChanged: _updateScreenSelection,
        screenSelection: _screenSelection,
      )
          : HomeScreen(
        onThemeChanged: _updateTheme,
        isDarkMode: _isDarkMode,
        onButtonColorChanged: _updateButtonColors, // Pass button color callback
        buttonColor: _buttonColor, // Pass the button color
        buttonTextColor: _buttonTextColor, // Pass the button text color
        onScreenSelectionChanged: _updateScreenSelection,
        screenSelection: _screenSelection,
      ),
    );
  }
}
