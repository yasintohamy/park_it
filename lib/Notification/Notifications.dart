import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'Model_Notification.dart';

class notification
{

  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get user => auth.currentUser!;
  static Notification_Model me = Notification_Model(
      pushToken: '',
  );

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
// for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await messaging.requestPermission();

    await messaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
  });
}
//   // for handling foreground messages
//   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //   log('Got a message whilst in the foreground!');
//   //   log('Message data: ${message.data}');
//
//   //   if (message.notification != null) {
//   //     log('Message also contained a notification: ${message.notification}');
//   //   }
//   // });
// }
// for sending push notification
static Future<void> sendPushNotification(
     String msg) async {
  try {
    log('Push Token notification: ${me.pushToken}');
    final body = {
      "to": me.pushToken,
      "notification": {
        "title": 'Arknely', //our name should be send
        "body": msg,
        "android_channel_id": "Park"
      },
      // "data": {
      //   "some_data": "User ID: ${me.id}",
      // },
    };

    var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
          'key=AAAAn7sNggE:APA91bENZN_GNo7CmBBWskjir8xo9ghGR6MOHCJlxez_Vw9ANtQMu_55kt4C7uD2ZkPFOfOXWSx2xtrNldefnVyl3OUpNvzlZeI8YyyFWRCmm6X8_6Hjzskbp70-H0h0FZMEhVEjsSpG'
        },
        body: jsonEncode(body));
    log('Response status: ${res.statusCode}');
    log('Response body: ${res.body}');
  } catch (e) {
    log('\nsendPushNotificationE: $e');
  }
}
}

