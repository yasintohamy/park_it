import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:park_it/Notification/Notifications.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget icon(double redsize) {
    return Icon(
      size: redsize,
      color: Color.fromARGB(255, 255, 255, 255),
      Icons.car_crash_outlined,
    );
  }

  Widget icontp(double redsize) {
    return Icon(
      size: redsize,
      color: Color.fromARGB(255, 255, 255, 255),
      Icons.car_crash_outlined,
    );
  }

  Widget iconfull(double sizewd) {
    return Transform.rotate(
      angle: 55,
      child: Icon(
        size: sizewd,
        color: Color.fromARGB(255, 255, 255, 255),
        Icons.local_parking_outlined,
      ),
    );
  }

  Widget icontop(double sizeht) {
    return Icon(
      size: sizeht,
      color: Color.fromARGB(255, 255, 255, 255),
      Icons.local_parking_outlined,
    );
  }

  Color? color = Colors.green;
  Color? color1;
  Color? color2;
  Color? color3;
  Color? color4;
  Color? color5;
  Color? color6;
  Color? color7;
  Color? color8;
  Color? color9;
  Color? color10;
  Color? color11;
  Color? color12;
  Color? color13;
  int c = 0, c1 = 0;
  bool done = false;
  final ref = FirebaseDatabase.instance.ref().child('/parking1');
  String dataValue = '';

  @override
  void initState() {
    super.initState();
    // Listen for changes in the database reference
    ref.onValue.listen((event) {
      setState(() {
        c = 0;
        c1 = 0;
        // Update the data value when changes occur
        //dataValue = event.snapshot.value.toString();
        List<dynamic> dataList = event.snapshot.value as List<dynamic>;
        if (dataList != null && dataList.length < 15) {
          if (dataList[1] == 1) {
            color1 = Colors.green;
            c++;
          } else {
            color1 = Colors.red;
            c1++;
          }

          if (dataList[2] == 1) {
            color2 = Colors.green;
            c++;
          } else {
            color2 = Colors.red;
            c1++;
          }

          if (dataList[3] == 1) {
            color3 = Colors.green;
            c++;
          } else {
            color3 = Colors.red;
            c1++;
          }

          if (dataList[4] == 1) {
            color4 = Colors.green;
            c++;
          } else {
            color4 = Colors.red;
            c1++;
          }

          if (dataList[5] == 1) {
            color5 = Colors.green;
            c++;
          } else {
            color5 = Colors.red;
            c1++;
          }

          if (dataList[6] == 1) {
            color6 = Colors.green;
            c++;
          } else {
            color6 = Colors.red;
            c1++;
          }

          if (dataList[7] == 1) {
            color7 = Colors.green;
            c++;
          } else {
            color7 = Colors.red;
            c1++;
          }

          if (dataList[8] == 1) {
            color8 = Colors.green;
            c++;
          } else {
            color8 = Colors.red;
            c1++;
          }

          if (dataList[9] == 1) {
            color9 = Colors.green;
            c++;
          } else {
            color9 = Colors.red;
            c1++;
          }

          if (dataList[10] == 1) {
            color10 = Colors.green;
            c++;
          } else {
            color10 = Colors.red;
            c1++;
          }

          if (dataList[11] == 1) {
            color11 = Colors.green;
            c++;
          } else {
            color11 = Colors.red;
            c1++;
          }

          if (dataList[12] == 1) {
            color12 = Colors.green;
            c++;
          } else {
            color12 = Colors.red;
            c1++;
          }

          if (dataList[13] == 1) {
            color13 = Colors.green;
            c++;
          } else {
            color13 = Colors.red;
            c1++;
          }
          if (c1 == 13) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              title: 'معذرا',
              desc: 'لا يوجد مكان متاح الأن, هل ترغب في أعلامك عند توافر مكان؟',
              btnCancelOnPress: () => done = false,
              btnOkOnPress: () => done = true,
            ).show();
          }
          if (c > 0 && done == true) {
            log('C: $c');
            notification.sendPushNotification(
                'أصبح هناك مكان متاح للركن الان بامكانك المجئ');
            done = false;
            log('$done');
          }
        } else {
          dataValue = '';
        }
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;

    double sizeWidth = (screenWidth - 12) / 5;
    double screenHeight = mediaQueryData.size.height;

    double sizeHeight = (screenHeight - 390) / 4;
    double sizeSpace = (screenWidth - 240);
    return Scaffold(
      backgroundColor: Color(0xff5E8CA6),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 69, 101, 98),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: sizeWidth,
                  height: 50,
                  child: Center(
                      child: Text(
                    '$c1',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.red, // Set background color
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
            Container(
              child: Center(
                child: Text(
                  'find & park',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: sizeWidth,
              height: 50,
              child: Center(
                  child: Text(
                '$c',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                color: Colors.green, // Set background color
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            color: Color.fromARGB(255, 240, 21, 5),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('Login', (route) => true);
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: color9 == color
                        ? icontop(sizeHeight / 1.85)
                        : icontp(sizeWidth / 1.25),
                    width: sizeWidth,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color9,
                      // Set background color
                      border: Border.all(
                        // Set border
                        color: const Color.fromARGB(255, 255, 249, 249),
                        width: 3.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Container(
                    child: color10 == color
                        ? icontop(sizeHeight / 1.85)
                        : icontp(sizeWidth / 1.25),
                    width: sizeWidth,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color10, // Set background color
                      border: Border.all(
                        // Set border
                        color: const Color.fromARGB(255, 255, 249, 249),
                        width: 3.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Container(
                    child: color11 == color
                        ? icontop(sizeHeight / 1.85)
                        : icontp(sizeWidth / 1.25),
                    //child: iconfull,
                    width: sizeWidth,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color11, // Set background color
                      border: Border.all(
                        // Set border
                        color: const Color.fromARGB(255, 255, 249, 249),
                        width: 3.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Container(
                    child: color12 == color
                        ? icontop(sizeHeight / 1.85)
                        : icontp(sizeWidth / 1.25),
                    width: sizeWidth,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color12, // Set background color
                      border: Border.all(
                        // Set border
                        color: const Color.fromARGB(255, 255, 249, 249),
                        width: 3.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                  ),
                  Container(
                    child: color13 == color
                        ? icontop(sizeHeight / 1.85)
                        : icontp(sizeWidth / 1.25),
                    width: sizeWidth,
                    height: 120,
                    decoration: BoxDecoration(
                      color: color13, // Set background color
                      border: Border.all(
                        // Set border
                        color: const Color.fromARGB(255, 255, 249, 249),
                        width: 3.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 70,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 2.0,
                    child: CustomPaint(
                      painter: _DashedLinePainter(),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(children: [
                  Column(
                    children: [
                      Container(
                        child: color1 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color1, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color2 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color2, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color3 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color3, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color4 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color4, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: sizeSpace,
                    child: Center(
                      child: Container(
                        height: (sizeHeight * 4) - 30,
                        width: 1.0,
                        child: CustomPaint(
                          painter: _VerticalDashedLinePainter(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: color5 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color5, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color6 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color6, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color7 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color7, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                      ),
                      Container(
                        child: color8 == color
                            ? iconfull(sizeWidth / 1.2)
                            : icon(sizeHeight / 1.5),
                        width: 120,
                        height: sizeHeight,
                        decoration: BoxDecoration(
                          color: color8, // Set background color
                          border: Border.all(
                            // Set border
                            color: const Color.fromARGB(255, 255, 249, 249),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final dashWidth = 15;
    final dashSpacing = 40;
    double startX = 13.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0.0),
        Offset(startX + dashWidth, 0.0),
        paint,
      );
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}

class _VerticalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final dashHeight = 15;
    final dashSpacing = 40;
    double startY = 30.0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0.0, startY),
        Offset(0.0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(_VerticalDashedLinePainter oldDelegate) => false;
}
