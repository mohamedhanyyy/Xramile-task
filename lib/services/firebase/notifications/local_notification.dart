import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


/// handling notification when app is opened

class CustomLocalNotification {
  static late AndroidNotificationChannel channel;
  static late LatLng? myCoordinates;
  static bool isFlutterLocalNotificationsInitialized = false;

  static Future<void> setupLocalNotifications({required LatLng? latLng}) async {
    myCoordinates = latLng;
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    /// configuring channel

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    isFlutterLocalNotificationsInitialized = true;
  }

  static void showFlutterNotification(RemoteMessage message) {
    double lat = double.parse(message.data['lat']);
    double lng = double.parse(message.data['lng']);
    double distance = Geolocator.distanceBetween(
        lat, lng, myCoordinates!.latitude, myCoordinates!.longitude);
    /// sending notification if the distance between my location and entered location is <= 100000000000000

    if (kDebugMode) {
      print('Distance is $distance');
      print(
          'Local coordinates (${myCoordinates?.latitude}, ${myCoordinates?.longitude})');
      print('Remote coordinates $lat, $lng');
    }
    if (message.notification != null &&
        message.notification?.android != null
        && distance <= 100000000000000
    ) {
      flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
      if (kDebugMode) {
        print('local notification ${message.notification?.title}');
        print('distance $distance');
      }
    }
  }

  static Future<void> onMessageOpenedApp(RemoteMessage message) async {
    log('${message.data}');
    log('${message.messageId}');
  }
}
