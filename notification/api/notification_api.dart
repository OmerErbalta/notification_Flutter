// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, override_on_non_overriding_member, await_only_futures
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  @override
  Future<void> initState() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var iosinitializationSettings = new DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosinitializationSettings);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  }

  static final _notification = FlutterLocalNotificationsPlugin();
  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }

  static Future showSchedulNotification(
      {int? id,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate}) async {
    tz.initializeTimeZones();
    _notification.zonedSchedule(
        id!,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('chanal id', 'chanel name',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}
}
