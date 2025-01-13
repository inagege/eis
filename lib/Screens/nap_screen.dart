import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class NapScreen extends StatefulWidget {
  const NapScreen({Key? key}) : super(key: key);

  @override
  _NapScreenState createState() => _NapScreenState();
}

class _NapScreenState extends State<NapScreen> {
  static const int _napDurationSeconds = 5 * 60;
  int _remainingSeconds = _napDurationSeconds;
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: const Text('OK'),
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Adjusted small circle at the top of the screen
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC0CB),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Time remaining: \n${minutes.toString().padLeft(2, '0')}:'
                    '${seconds.toString().padLeft(2, '0')}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //const Spacer(),
// Bild
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: Image.asset(
                  'assets/sleep_animation.gif',
                  width: 145,
                  height: 85,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      minimumSize: const Size(120, 48),
                    ),
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      'End',
                      style: TextStyle(color: Colors.white, fontSize: 12),
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
