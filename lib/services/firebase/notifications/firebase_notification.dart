import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:xramile/modules/notifications/business_logic/notifications_cubit.dart';
import 'package:xramile/modules/notifications/data/models/notifications_model.dart';
import 'package:xramile/shared/const/app_consts.dart';

import 'local_notification.dart';

class FirebaseCustomNotification {
  static final messaging = FirebaseMessaging.instance;

  static NotificationSettings? settings;


  /// handle background action notification
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  /// request notification permission from the user to grant sending notifications
  static Future<bool> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }


  /// initialing configuration of firebase
  static Future<void> setUpFirebase({required LatLng? latLng}) async {
    bool notificationStatus = await requestNotificationPermission();
    if (notificationStatus) {
      await CustomLocalNotification.setupLocalNotifications(latLng: latLng);
      FirebaseMessaging.onBackgroundMessage(
          FirebaseCustomNotification.firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage
          .listen(CustomLocalNotification.showFlutterNotification);
      FirebaseMessaging.onMessageOpenedApp
          .listen((CustomLocalNotification.onMessageOpenedApp));
      if (kDebugMode) {
        String? token = await FirebaseMessaging.instance.getToken();
        print('FIREBASE TOKEN: $token');
      }
    }
  }


  /// send a notification to a certain user with api key
  static void sendPushMessage(
      {required String body,
      required String title,
      required double lat,
      required double lng,
      required BuildContext context}) async {
    try {
      Response? response = await http.post(
        Uri.parse(AppConstants.googleApiFcmKey),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${AppConstants.firebaseApiKey}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'lat': lat,
              'lng': lng,
              'status': 'done'
            },
            "to": '${await FirebaseMessaging.instance.getToken()}',
          },
        ),
      );

      if (response.statusCode == 200 && context.mounted) {
        context.read<NotificationsCubit>().addNotification(
            notificationModel: NotificationModel(
                lng: lng, lat: lat, title: title, body: body));
      }
      if (kDebugMode) {
        print('Push notification done with title $title');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error push notification");
      }
    }
  }
}
