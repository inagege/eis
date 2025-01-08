import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eis/main.dart';


class NapScreen extends StatefulWidget {
  const NapScreen({Key? key}) : super(key: key);

  @override
  _NapScreenState createState() => _NapScreenState();
}

class _NapScreenState extends State<NapScreen> {
  static const int _napDurationSeconds = 5 * 60; // 5 Minuten in Sekunden
  int _remainingSeconds = _napDurationSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startNapTimer();
  }

  @override
  void dispose() {
    // Timer beenden, wenn der Screen verlassen wird,
    // um Speicherlecks zu vermeiden.
    _timer?.cancel();
    super.dispose();
  }

  void _startNapTimer() {
    // Erstellt einen Timer, der jede Sekunde die verbleibenden Sekunden verringert.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        // Timer ist abgelaufen
        timer.cancel();
        _onNapFinished();
      }
    });
  }

  void _onNapFinished() {
    // Aktion, wenn der Timer abgelaufen ist:
    // z. B. Dialog anzeigen oder automatische Rückkehr zum Home-Screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Dialog-Randabstand
        insetPadding: const EdgeInsets.all(8.0),

        // Zentrierung der Actions (ab Flutter 2.5)
        actionsAlignment: MainAxisAlignment.center,

        // Title-Padding: Achtung, falls Sie „content“ definieren,
        // wird dessen Abstand ggf. separat gesteuert.
        titlePadding: const EdgeInsets.only(
          top: 24.0,  // gewünschter Abstand nach oben
          left: 16.0,
          right: 16.0,
          bottom: 0.0,
        ),

        // Actions-Padding: steuert den Abstand nach unten (z. B. 24.0)
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
              Navigator.of(context).pop(); // Dialog schließen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ); // Zurück zum Home-Screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    // In Minuten und Sekunden aufsplitten
    final int minutes = _remainingSeconds ~/ 60;
    final int seconds = _remainingSeconds % 60;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Kleiner Kreis analog zur CoffeeScreen
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC0CB),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.pause_circle,
                      color: Colors.brown,
                      size: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Text zum Countdown
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

              const Spacer(),

              // Button zum manuellen Abbrechen
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
                      // Nap frühzeitig beenden und zum Home-Screen zurückkehren
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
