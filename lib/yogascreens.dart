import 'package:flutter/material.dart';

class YogaScreens extends StatefulWidget {
  final String category;

  const YogaScreens({super.key, required this.category});

  @override
  _YogaScreensState createState() => _YogaScreensState();
}

class _YogaScreensState extends State<YogaScreens> {
  int currentIndex = 0;

  final Map<String, List<Map<String, String>>> mockupScreens = {
    'Yoga': [
      {
        'title': 'Ready to start?',
        'description': 'Ready for a 5 Minute Yoga Session?',
        'image': 'assets/images/yogaicon.png',
        'buttonText': 'Start Session!',
      },
      {
        'title': 'Yoga 1/5',
        'description': '60 Seconds',
        'image': 'assets/images/yoga1.png',
        'buttonText': 'Next',
        'imageWidth': '85',
        'imageHeight': '40',
      },
      {
        'title': 'Yoga 2/5',
        'description': '60 Seconds',
        'image': 'assets/images/yoga2.png',
        'buttonText': 'Next',
        'imageWidth': '150',
        'imageHeight': '35',
      },
      {
        'title': 'Yoga 3/5',
        'description': '60 Seconds',
        'image': 'assets/images/yoga3.png',
        'buttonText': 'Next',
        'imageWidth': '105',
        'imageHeight': '40',
      },
      {
        'title': 'Yoga 4/5',
        'description': '60 Seconds',
        'image': 'assets/images/yoga4.png',
        'buttonText': 'Next',
        'imageWidth': '64',
        'imageHeight': '40',
      },
      {
        'title': 'Yoga 5/5',
        'description': '60 Seconds.',
        'image': 'assets/images/yoga5.png',
        'buttonText': 'Next',
        'imageWidth': '66',
        'imageHeight': '40',
      },
      {
        'title': 'Well done!',
        'description': 'You have completed the Yoga session.',
        'image': 'assets/images/yogaicon.png',
        'buttonText': 'End',
      },
    ],
    'Walk': [
      {'title': 'Lets go!', 'description': '', 'image': ''},
      {'title': 'Midway Check', 'description': '', 'image': ''},
      {'title': 'Almost there', 'description': '', 'image': ''},
      {'title': 'Done!', 'description': '', 'image': ''},
    ],
    'Nap': [
      {'title': 'Time to relax', 'description': '', 'image': ''},
      {'title': 'Close your eyes', 'description': '', 'image': ''},
      {'title': 'Done!', 'description': '', 'image': ''},
    ],
    'Vent': [
      {'title': 'Share your thoughts', 'description': '', 'image': ''},
      {'title': 'All set', 'description': '', 'image': ''},
    ],
    'Coffee': [
      {'title': 'Enjoy a coffee break', 'description': '', 'image': ''},
    ],
    'Food': [
      {'title': 'Enjoy some food', 'description': '', 'image': ''},
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> screens = mockupScreens[widget.category] ??
        [
          {'title': 'Screen', 'description': '', 'image': ''}
        ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                if (currentIndex == 0 || currentIndex == screens.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      screens[currentIndex]['description'] ?? '',
                      style: TextStyle(fontSize: 13, color: Color(0xFFD3D3D3)),
                      textAlign: TextAlign.center,
                    ),
                  )
                else if (screens[currentIndex]['image'] != null &&
                    screens[currentIndex]['image']!.isNotEmpty)
                  Column(
                    children: [
                      Image.asset(
                        screens[currentIndex]['image']!,
                        width: double.parse(
                            screens[currentIndex]['imageWidth'] ?? '20'),
                        height: double.parse(
                            screens[currentIndex]['imageHeight'] ?? '20'),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          screens[currentIndex]['description'] ?? '',
                          style: TextStyle(fontSize: 13, color: Color(0xFFD3D3D3)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFFFC0CB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/yogaicon.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                screens[currentIndex]['title']!,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFD3D3D3),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD3D3D3),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                ),
                onPressed: () {
                  if (currentIndex < screens.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  currentIndex == screens.length - 1 ? 'Done' : 'Next',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D2324)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
