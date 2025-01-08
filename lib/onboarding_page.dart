import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset(
                'assets/images/onboarding.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              // Expanded(child: SizedBox()),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "TRACK IT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white.withOpacity(0.5),
                                offset: Offset(3, 3), // Shadow offset (x, y)
                                blurRadius: 8,
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Text("OWN IT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            offset: Offset(3, 3), // Shadow offset (x, y)
                            blurRadius: 8,
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(height: 36),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[400],
                      side: BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 24)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Explore',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5)),
                      SizedBox(width: 40),
                      Transform.scale(
                        scaleX: 4.0,
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
