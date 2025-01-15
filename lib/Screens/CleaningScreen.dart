import 'package:flutter/material.dart';
import 'home_screen.dart';  // Assuming this class already implements the required functionality

class CleaningPromptScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CleaningPromptScreen({
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
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
                    Icons.cleaning_services,
                    color: buttonTextColor,
                    size: 15.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tidy up and let it shine!',
                style: TextStyle(
                  fontSize: 24,
                  color: isDarkMode ? buttonColor : buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 170, // <-- match_parent
                height: 50, // <-- match-parent
                child:
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CleaningVideoScreen(
                          onThemeChanged: onThemeChanged,
                          isDarkMode: isDarkMode,
                          onButtonColorChanged: onButtonColorChanged,
                          buttonColor: buttonColor,
                          buttonTextColor: buttonTextColor,
                          onScreenSelectionChanged: onScreenSelectionChanged,
                          screenSelection: screenSelection,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Start cleaning!',
                    style: TextStyle(color: buttonTextColor, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CleaningVideoScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CleaningVideoScreen({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  _CleaningVideoScreenState createState() => _CleaningVideoScreenState();
}

class _CleaningVideoScreenState extends State<CleaningVideoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isGifFinished = false;
  int _gifPlayCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this, // This should work as this class mixes in SingleTickerProviderStateMixin
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _gifPlayCount++;
        if (_gifPlayCount == 2 && !_isGifFinished) {
          setState(() {
            _isGifFinished = true;
          });

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CleaningScreen(
                  onThemeChanged: widget.onThemeChanged,
                  isDarkMode: widget.isDarkMode,
                  onButtonColorChanged: widget.onButtonColorChanged,
                  buttonColor: widget.buttonColor,
                  buttonTextColor: widget.buttonTextColor,
                  onScreenSelectionChanged: widget.onScreenSelectionChanged,
                  screenSelection: widget.screenSelection,
                ),
              ),
            );
          });
        } else {
          _controller.reverse();
          _controller.forward();
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.buttonColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.cleaning_services,
                    color: widget.buttonTextColor,
                    size: 15.0,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 110,
                    child: Image.asset(
                      'assets/gif/clean.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CleaningScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CleaningScreen({
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
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
                    Icons.cleaning_services,
                    color: buttonTextColor,
                    size: 15.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Bravo, cleaning done!',
                style: TextStyle(
                  fontSize: 24,
                  color: isDarkMode ? buttonColor : buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              SizedBox(
                width: 170, // <-- match_parent
                height: 50, // <-- match-parent
                child:
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}