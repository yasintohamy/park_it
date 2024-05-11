import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:park_it/Notification/Notifications.dart';
import 'package:park_it/auth/SignUp.dart';
import 'package:park_it/auth/login.dart';
import 'package:park_it/compo/HomePage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'Park',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Park',
      enableSound: true,
      allowBubbles: true,
      showBadge: true,
      enableVibration: true,
    );
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('================================ User is currently signed out!');
      } else {
        await notification.getFirebaseMessagingToken();
        print('================================ User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : Login(),
      routes: {
        'SignUp': (context) => SignUp(),
        'Login': (context) => Login(),
        'HomePage': (context) => HomePage(),
      },
    );
  }
}
