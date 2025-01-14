import 'package:flutter/material.dart';
import 'cleaning_screen.dart';

class CleaningVideoScreen extends StatefulWidget {
  @override
  _CleaningVideoScreenState createState() => _CleaningVideoScreenState();
}

class _CleaningVideoScreenState extends State<CleaningVideoScreen>
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
              MaterialPageRoute(builder: (context) => CleaningScreen()),
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
    double circleSize = 15.0;
    double iconSize = 10.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFC0CB),
                    shape: BoxShape.circle,
                  ),

                child: Center(
                  child: Icon(
                    Icons.cleaning_services,
                    color: Colors.black,
                    size: 12,
                  ),
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
