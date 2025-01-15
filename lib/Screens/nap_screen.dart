import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class NapScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final Function(Color, Color) onButtonColorChanged;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function(String) onScreenSelectionChanged;
  final String screenSelection;

  NapScreen({
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onButtonColorChanged,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onScreenSelectionChanged,
    required this.screenSelection,
  });

  @override
  _NapScreenState createState() => _NapScreenState();
}

class _NapScreenState extends State<NapScreen> {
  static const int _NapDurationSeconds = 5 * 60;
  int _remainingSeconds = _NapDurationSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startNapTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startNapTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _onNapFinished();
      }
    });
  }

  void _onNapFinished() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(8.0),
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.only(
          top: 24.0,
          left: 16.0,
          right: 16.0,
        ),
        actionsPadding: const EdgeInsets.only(
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
        ),
        title: Center(
          child: Text(
            'Time to wake up!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen(onThemeChanged: widget.onThemeChanged,
                    isDarkMode: widget.isDarkMode,
                    onButtonColorChanged: widget.onButtonColorChanged,
                    buttonColor: widget.buttonColor,
                    buttonTextColor: widget.buttonTextColor,
                    onScreenSelectionChanged: widget.onScreenSelectionChanged,
                    screenSelection: widget.screenSelection),),
              );
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Adjusted small circle at the top of the screen
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
                    Icons.bed,
                    color: widget.buttonTextColor,
                    size: 15.0,
                  ),
                ),
              ),

              SizedBox(height: 5),

              Text(
                'Time left: ${minutes.toString().padLeft(2, '0')}:'
                    '${seconds.toString().padLeft(2, '0')}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: widget.isDarkMode ? widget.buttonColor : widget.buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 2),

              //const Spacer(),
// Bild
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Image.asset(
                  'assets/sleep_animation.gif',
                  width: 100,
                  height: 60,
                ),
              ),
              SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Center(
                    child: SizedBox(
                      width: 170, // <-- match_parent
                      height: 50, // <-- match-parent
                      child:
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: widget.buttonColor),
                        onPressed: () {
                          _timer?.cancel();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomeScreen(onThemeChanged: widget.onThemeChanged,
                                isDarkMode: widget.isDarkMode,
                                onButtonColorChanged: widget.onButtonColorChanged,
                                buttonColor: widget.buttonColor,
                                buttonTextColor: widget.buttonTextColor,
                                onScreenSelectionChanged: widget.onScreenSelectionChanged,
                                screenSelection: widget.screenSelection)),
                          );
                        },
                        child: Text(
                          'Back to Home',
                          style: TextStyle(color: widget.buttonTextColor, fontSize: 18),
                        ),
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
