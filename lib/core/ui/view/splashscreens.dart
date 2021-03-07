import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/ui/view/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = false;
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        setState(
          () {
            isAnimate = true;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.2),
                      child: Image.asset(
                        'assets/images/icon.png',
                        width: size.height * 0.60,
                      ),
                    ),
                    Text(
                      'Pegawaiku',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              left: (isAnimate)
                  ? -((size.height - size.width) / 2)
                  : size.width / 2,
              top: (isAnimate) ? -300 : size.height / 2,
              duration: Duration(milliseconds: 295),
              child: AnimatedContainer(
                height: size.height + 600,
                width: size.height + 600,
                onEnd: () => goToNext(),
                decoration: BoxDecoration(
                    color: ColorPallete.primary, shape: BoxShape.circle),
                transform: Matrix4.identity()
                  ..scale((isAnimate) ? 1.0 : 0.0005),
                duration: Duration(milliseconds: 300),
              ),
            )
          ],
        ),
      ),
    );
  }

  goToNext() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => Home(),
        ),
      );
}
