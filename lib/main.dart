import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(EISApp());
}

class EISApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EIS App',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}