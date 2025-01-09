import 'package:flutter/material.dart';
import 'startscreen.dart'; // Importiert die Startscreen-Datei
import 'yogascreens.dart'; // Importiert die Datei YogaScreens

void main() {
  runApp(EISApp());
}

class EISApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EIS App',
      theme: ThemeData.dark(),
      home: StartScreen(), // Startet mit der StartScreen-Seite
    );
  }
}

// Home Screen mit Haupt-Buttons und einem Kreis oben
class HomeScreen extends StatelessWidget {
  final List<String> categories = ['Yoga', 'Walk', 'Nap', 'Vent', 'Coffee', 'Food'];

  @override
  Widget build(BuildContext context) {
    // Berechne die Größe der Buttons basierend auf der Bildschirmbreite
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth - 80) / 3; // Subtrahiere Polster und Abstand

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Kleiner Kreis oben
          Container(
            margin: EdgeInsets.only(top: 10), // Abstand nach unten
            width: 20, // Durchmesser des Kreises
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFFFC0CB), // Hellrosa Farbe
              shape: BoxShape.circle,
            ),
          ),

          // Abstand unterhalb des Kreises
          SizedBox(height: 10),

          // Grid mit runden Buttons
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              padding: EdgeInsets.all(25),
              children: categories.map((name) {
                return RoundButton(
                  label: name,
                  size: buttonSize,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YogaScreens(category: name), // Verweis auf YogaScreens
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Runder Button
class RoundButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double size;

  const RoundButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color(0xFFFFC0CB),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: size * 0.2, color: Color(0xFF4D2324)), // Schriftgröße anpassen
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
