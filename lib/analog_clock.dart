import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({Key? key}) : super(key: key);

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  double minutesAngle = 0;
  double secondsAngle = 0;
  double hoursAngle = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final now = DateTime.now();
      setState(() {
        secondsAngle = (pi / 30) * now.second;
        minutesAngle = pi / 30 * now.minute;
        hoursAngle = (pi / 6 * now.hour) + (pi / 45 * minutesAngle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ///Clock Image
            Container(
              height: 350,
              child: Image.asset(
                "assets/realClock.png",
                fit: BoxFit.contain,
                width: 350,
              ),
            ),

            ///Seconds
            RotatedBox(
              quarterTurns: 2,
              child: Transform.rotate(
                angle: secondsAngle,
                child: Transform.translate(
                  offset: const Offset(0, 34),
                  child: Center(
                    child: Container(
                      height: 90,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Minutes
            RotatedBox(
              quarterTurns: 2,
              child: Transform.rotate(
                angle: minutesAngle,
                child: Transform.translate(
                  offset: const Offset(0, 30),
                  child: Center(
                    child: Container(
                      height: 75,
                      width: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(192, 0, 0, 0),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Hours
            RotatedBox(
              quarterTurns: 2,
              child: Transform.rotate(
                angle: hoursAngle,
                child: Transform.translate(
                  offset: const Offset(0, 20),
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///Dot
            Container(
              height: 16,
              width: 16,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
