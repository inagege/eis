import 'package:flutter/material.dart';
import 'dart:async';

class YogaScreens extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  YogaScreens({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  _YogaScreensState createState() => _YogaScreensState();
}

class _YogaScreensState extends State<YogaScreens> {
  int currentIndex = 0;
  Timer? timer;
  int remainingTime = 60;  // Initial countdown time in seconds

  final List<Map<String, dynamic>> screens = [
    {
      'title': 'Ready to start?',
      'description': '5 exercises each 60 seconds!',
      'buttonText': 'Start Session!',
      'imageWidth': 85.0,
      'imageHeight': 40.0,
    },
    {
      'title': 'Yoga 1/5',
      'buttonText': 'Next',
      'image': 'assets/images/yoga1.png',
      'imageWidth': 100.0,
      'imageHeight': 50.0,
    },
    {
      'title': 'Yoga 2/5',
      'image': 'assets/images/yoga2.png',
      'buttonText': 'Next',
      'imageWidth': 100.0,
      'imageHeight':50.0,
    },
    {
      'title': 'Yoga 3/5',
      'image': 'assets/images/yoga3.png',
      'buttonText': 'Next',
      'imageWidth': 100.0,
      'imageHeight': 50.0,
    },
    {
      'title': 'Yoga 4/5',
      'image': 'assets/images/yoga4.png',
      'buttonText': 'Next',
      'imageWidth': 100.0,
      'imageHeight': 50.0,
    },
    {
      'title': 'Yoga 5/5',
      'image': 'assets/images/yoga5.png',
      'buttonText': 'Next',
      'imageWidth': 100.0,
      'imageHeight': 50.0,
    },
    {
      'title': 'Well done!',
      'description': 'Yoga session completed',
      'buttonText': 'Back to Home',
      'imageWidth': 66.0,
      'imageHeight': 40.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();  // Ensure to cancel existing timer
    remainingTime = 60;  // Reset timer for each exercise
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        moveToNextScreen();
      }
    });
  }

  void moveToNextScreen() {
    if (currentIndex < screens.length - 1) {
      setState(() {
        currentIndex++;
        startTimer(); // Restart timer for the next screen
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: widget.buttonColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/yogaicon.png',
                  width: 15.0,
                  height: 15.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            if (screens[currentIndex]['image'] == null)
              SizedBox(height: 20),
            if (screens[currentIndex]['image'] != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '$remainingTime seconds',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            if (screens[currentIndex]['image'] != null)
              SizedBox(height: 10),
            if (screens[currentIndex]['image'] != null)
              Image.asset(
                screens[currentIndex]['image'],
                width: screens[currentIndex]['imageWidth'],
                height: screens[currentIndex]['imageHeight'],
              ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: screens[currentIndex].containsKey('description') ?
              Text(
                screens[currentIndex]['description'],
                style: TextStyle(
                  fontSize: 23,
                  color: widget.isDarkMode ? widget.buttonColor : widget.buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ) : Container(),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: widget.buttonColor),
                onPressed: () {
                  if (currentIndex < screens.length - 1) {
                    setState(() {
                      currentIndex++;
                      startTimer();  // Ensure timer starts with the new screen
                    });
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                },
                child: Text(
                  screens[currentIndex]['buttonText'],
                  style: TextStyle(color: widget.buttonTextColor, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
