import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class WalkScreen extends StatefulWidget {
  const WalkScreen({Key? key}) : super(key: key);

  @override
  _WalkScreenState createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  static const int _walkDurationSeconds = 5 * 60;
  int _remainingSeconds = _walkDurationSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startWalkTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startWalkTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        _onWalkFinished();
      }
    });
  }

  void _onWalkFinished() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(8.0),
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.only(
          top: 24.0,
          left: 16.0,
          right: 16.0,
          bottom: 0.0,
        ),
        actionsPadding: const EdgeInsets.only(
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
        ),
        title: const Center(
          child: Text(
            'Time to return!',
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
        child: Column(
          children: [
            // Punkt oben wie in den anderen Screens
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 20, // Gleiche Breite wie in den anderen Screens
              height: 20, // Gleiche Höhe wie in den anderen Screens
              decoration: const BoxDecoration(
                color: Color(0xFFFFC0CB), // Gleiche Farbe wie in den anderen Screens
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(height: 5), // Abstand unter dem Punkt

            // Countdown Timer Text
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

            const Spacer(), // Abstand zum unteren Bereich

            // End Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
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
    );
  }
}
