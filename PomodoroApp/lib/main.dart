import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Duration duration = Duration(minutes: 25);
  Timer? stop;
  bool isruning = false;
  bool isreusme = false;

  countdwan() {
    stop = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int inSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: inSeconds);

        if (duration.inSeconds == 0) {
          timer.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isruning = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(
            "PomodoroApp",
            style: TextStyle(fontSize: 25),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120,
              progressColor: Color.fromARGB(255, 116, 85, 255),
              backgroundColor: Colors.white,
              lineWidth: 8.0,
              percent: duration.inMinutes / 25,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1000,
              center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: TextStyle(fontSize: 35, color: Colors.white)),
            ),
            SizedBox(
              height: 30,
            ),
            isruning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isreusme
                          ? ElevatedButton(
                              onPressed: () {
                                countdwan();
                                isreusme = false;
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text(
                                "resume",
                                style: TextStyle(fontSize: 25),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                stop!.cancel();
                                isreusme = true;
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text(
                                "stop",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          stop!.cancel();
                          setState(() {
                            isruning = false;
                            duration = Duration(minutes: 25);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: Text(
                          "cancel",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      countdwan();
                      isruning = true;
                    },
                    child: Text(
                      "start",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
