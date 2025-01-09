import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  SettingsScreen({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late Color _buttonColor;
  late Color _buttonTextColor;
  late String _screenSelection;
  List<Color> colorList = [
    Color(0xFFFFC0CB), // Pink
    Color(0xFFADD8E6), // Light Blue
    Color(0xFF90EE90), // Light Green
  ];

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _buttonColor = widget.buttonColor;
    _buttonTextColor = widget.buttonTextColor; // Default text color for light red
    _screenSelection = widget.screenSelection; // Default screen choice
  }

  void _updateButtonColor(Color buttonColor) {
    setState(() {
      _buttonColor = buttonColor;
      _buttonTextColor = _getButtonTextColor(buttonColor);
    });
  }

  Color _getButtonTextColor(Color colorKey) {
    switch (colorKey.value) {
      case 0xFFFFC0CB: // Pink
        return Color(0xFF4D2324);
      case 0xFFADD8E6: // Light Blue
        return Color(0xFF003366);
      case 0xFF90EE90: // Light Green
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
    widget.onThemeChanged(isDarkMode);
  }

  void _loadScreenPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _screenSelection = prefs.getString('screenSelection') ?? 'Grid';
    });
  }

  void _saveScreenPreference(String screenSelection) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('screenSelection', screenSelection);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Circle with settings icon
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.settings,
                    color: _buttonTextColor,
                    size: 15.0,
                  ),
                ),
              ),

              SizedBox(height: 5),

              // Dark mode toggle
              SwitchListTile(
                title: Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (bool value) {
                  _updateTheme(value);
                },
                activeColor: _buttonColor,
                activeTrackColor: _buttonTextColor,
                inactiveThumbColor: _buttonTextColor,
                inactiveTrackColor: _buttonColor,
              ),

              Divider(color: Colors.grey, height: 10),
              SizedBox(height: 10),

              // Color selection buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Select Color Scheme'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: colorList.map((entry) {
                        return GestureDetector(
                          onTap: () {
                            _updateButtonColor(entry);
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: entry,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _buttonColor == entry
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
                  ],
                ),
              ),

              Divider(color: Colors.grey, height: 10),
              SizedBox(height: 10),

              // Activity screen style selection
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Text('Select Screen Style'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space evenly between and around items
                      children: [
                        _buildOptionPreview(
                          label: 'Grid',
                          isSelected: _screenSelection == 'Grid',
                          child: _buildGridPreview(),
                          onTap: () {
                            setState(() {
                              _screenSelection = 'Grid';
                            });
                            _saveScreenPreference('Grid');
                          },
                        ),
                        _buildOptionPreview(
                          label: 'Sliding',
                          isSelected: _screenSelection == 'Sliding',
                          child: _buildSlidingPreview(),
                          onTap: () {
                            setState(() {
                              _screenSelection = 'Sliding';
                            });
                            _saveScreenPreference('Sliding');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(color: Colors.grey, height: 10),
              SizedBox(height: 10),

              // Confirm button
              ElevatedButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: _buttonTextColor),
                ),
                onPressed: () {
                  widget.onButtonColorChanged(
                    _buttonColor,
                    _buttonTextColor,
                  );
                  widget.onThemeChanged(_isDarkMode);
                  widget.onScreenSelectionChanged(_screenSelection);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a preview container with label
  Widget _buildOptionPreview({
    required String label,
    required bool isSelected,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? _buttonColor : Colors.grey[800],
              border: Border.all(
                color: isSelected ? _buttonTextColor : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: child,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildGridPreview() {
    return Container(
      width: 75,
      height: 75,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: List.generate(9, (index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSlidingPreview() {
    return Container(
      width: 75,
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8),
          Icon(Icons.swipe, color: Colors.white),
        ],
      ),
    );
  }
}
