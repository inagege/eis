import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color,Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;

  SettingsScreen({required this.onThemeChanged, required this.isDarkMode, required this.onButtonColorChanged, required this.buttonColor, required this.buttonTextColor});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late String _buttonColor;
  late Color _buttonTextColor;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _buttonColor = 'lightred';  // Default color
    _buttonTextColor = Color(0xFF4D2324);  // Default text color for light red
  }

  void _updateButtonColor(String colorKey) {
    setState(() {
      _buttonColor = colorKey;
      _buttonTextColor = _getButtonTextColor(colorKey);
    });
  }

  Color _getButtonTextColor(String colorKey) {
    switch (colorKey) {
      case 'lightred':
        return Color(0xFF4D2324);
      case 'lightblue':
        return Color(0xFF003366);
      case 'lightgreen':
        return Color(0xFF2F4F4F);
      default:
        return _buttonTextColor;
    }
  }

  void _updateTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);

    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dark mode toggle
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                _updateTheme(value);
              },
              activeColor: colorOptions[_buttonColor], // Correct access to color by key
              activeTrackColor: _buttonTextColor, // Use _buttonTextColor directly
              inactiveThumbColor: _buttonTextColor, // Use _buttonTextColor directly
              inactiveTrackColor: colorOptions[_buttonColor], // Correct access to color by key
            ),

            // Color selection buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: colorOptions.entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          _updateButtonColor(entry.key);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: entry.value,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _buttonColor == entry.key
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 10),

                  // Button preview
                  ElevatedButton(
                    child: Text(
                      'Sample Button',
                      style: TextStyle(color: _buttonTextColor),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorOptions[_buttonColor],
                    ),
                  ),
                ],
              ),
            ),

            // Confirm button
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                // Pass the selected button color and text color to the parent screen
                widget.onButtonColorChanged(
                  colorOptions[_buttonColor]!, // Pass button color
                  _buttonTextColor, // Pass text color
                );
                widget.onThemeChanged(_isDarkMode);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Color options map
  final Map<String, Color> colorOptions = {
    'lightred': Color(0xFFFFC0CB),
    'lightblue': Color(0xFFADD8E6),
    'lightgreen': Color(0xFF90EE90),
  };
}
