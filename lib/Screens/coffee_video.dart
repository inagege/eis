import 'package:flutter/material.dart';
import 'coffee_screen.dart';

class CoffeeVideoScreen extends StatefulWidget {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CoffeeScreen()),
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
      backgroundColor: Colors.black,
      body: SafeArea( // Wrap with SafeArea
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
          child: Column(
            children: [
              Padding( // Use Padding for consistent top spacing
                padding: const EdgeInsets.only(top: 10.0), // Adjust this value as needed
                child: Container(
                  width: 20, // Fixed size for the icon circle
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC0CB),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.local_cafe,
                      color: Colors.brown,
                      size: 12, // Fixed icon size
                    ),
                  ),
                ),
              ),



              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 110, // Set the desired height in pixels
                    child: Image.asset(
                      'assets/coffee.gif',
                      fit: BoxFit.contain, // Maintain aspect ratio
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