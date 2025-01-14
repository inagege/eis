import 'package:flutter/material.dart';
import 'home_screen.dart';

class CoffeeApp extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CoffeeApp({
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

    return MaterialApp(
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
        primaryColor: buttonColor,
        buttonTheme: ButtonThemeData(buttonColor: buttonColor),
      )
          : ThemeData.light().copyWith(
        primaryColor: buttonColor,
        buttonTheme: ButtonThemeData(buttonColor: buttonColor),
      ),
      initialRoute: '/start',
      routes: {
        '/': (context) => HomeScreen(
          onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
          onButtonColorChanged: onButtonColorChanged,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          onScreenSelectionChanged: onScreenSelectionChanged,
          screenSelection: screenSelection,
        ),
        '/start': (context) => CoffeePromptScreen(
          onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
          onButtonColorChanged: onButtonColorChanged,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          onScreenSelectionChanged: onScreenSelectionChanged,
          screenSelection: screenSelection,
        ),
        '/video': (context) => CoffeeVideoScreen(
          onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
          onButtonColorChanged: onButtonColorChanged,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          onScreenSelectionChanged: onScreenSelectionChanged,
          screenSelection: screenSelection,
        ),
        '/coffee': (context) => CoffeeScreen(
          onThemeChanged: onThemeChanged,
          isDarkMode: isDarkMode,
          onButtonColorChanged: onButtonColorChanged,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          onScreenSelectionChanged: onScreenSelectionChanged,
          screenSelection: screenSelection,
        ),
      },
    );
  }
}


class CoffeeIconCircle extends StatelessWidget {
  final double circleSize;
  final double iconSize;
  final Color buttonColor;
  final Color buttonTextColor;

  CoffeeIconCircle({required this.circleSize, required this.iconSize, required this.buttonColor, required this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: buttonColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.local_cafe,
          color: buttonTextColor,
          size: iconSize,
        ),
      ),
    );
  }
}

class CoffeePromptScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CoffeePromptScreen({
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CoffeeIconCircle(circleSize: 20.0, iconSize: 12.0, buttonColor: buttonColor,buttonTextColor: buttonTextColor),
              ),
              SizedBox(height: 8),
              Text(
                'Coffee',
                style: TextStyle(
                  fontSize: 16,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'How about a coffee break?',
                  style: TextStyle(
                    fontSize: 16,
                    color: buttonTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 22),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    minimumSize: Size(120, 48),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/video');
                  },
                  child: Text(
                    'Start coffee machine!',
                    style: TextStyle(color: buttonTextColor, fontSize: 12),
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

class CoffeeVideoScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CoffeeVideoScreen({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  _CoffeeVideoScreenState createState() => _CoffeeVideoScreenState();
}

class _CoffeeVideoScreenState extends State<CoffeeVideoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isGifFinished = false;
  int _gifPlayCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _gifPlayCount++;
        if (_gifPlayCount == 2 && !_isGifFinished) {
          setState(() {
            _isGifFinished = true;
          });

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, '/coffee');
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CoffeeIconCircle(
                  circleSize: 20.0,
                  iconSize: 12.0,
                  buttonColor: widget.buttonColor, // Use widget to access properties
                  buttonTextColor: widget.buttonTextColor,
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 110,
                    child: Image.asset(
                      'assets/coffee.gif',
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


class CoffeeScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  CoffeeScreen({
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CoffeeIconCircle(circleSize: 20.0, iconSize: 12.0, buttonColor: buttonColor, buttonTextColor: buttonTextColor),
              ),
              SizedBox(height: 30),
              Text(
                'Your coffee is ready and waiting to be enjoyed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: Size(120, 48),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text(
                      'Back to Home',
                      style: TextStyle(color: buttonTextColor, fontSize: 12),
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
