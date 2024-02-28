import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';

class Notifications {
  Future<void> initalizeNotification() async {
    AwesomeNotifications().initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          enableLights: true,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          playSound: true,
          criticalAlerts: true,
          enableVibration: true,
          groupSort: GroupSort.Asc,
          icon: 'resource://drawable/logo',
          ledOffMs: 1000,
          ledOnMs: 1000,
        ),
      ],
      debug: true,
    );
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> scheduleNotification({required AlarmInfo alarmInfo}) async {
    // Assign the same ID for both notifications
    int notificationId = alarmInfo.id.hashCode;

    DateTime now = DateTime.now();

    // Schedule a one-time notification at the selected time of day
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: alarmInfo.title,
        body: alarmInfo.description,
        actionType: ActionType.Default,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        autoDismissible: false,
        category: NotificationCategory.Alarm,
        duration: const Duration(seconds: 30),
      ),
      schedule: NotificationCalendar(
        weekday: now.weekday,
        hour: alarmInfo.alarmDateTime.hour,
        minute: alarmInfo.alarmDateTime.minute,
        second: 0,
        allowWhileIdle: true,
      ),
    );
    // Schedule the interval notification with the same ID
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId, // Use the same ID
        channelKey: 'basic_channel',
        title: alarmInfo.title,
        body: alarmInfo.description,
        actionType: ActionType.Default,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        autoDismissible: false,
        category: NotificationCategory.Alarm,
        duration: const Duration(seconds: 60),
      ),
      schedule: NotificationInterval(
        interval: alarmInfo.interval * 60 * 60,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }

  Future<void> updateNotification({required AlarmInfo alarmInfo}) async {
    if (alarmInfo.isActive) {
      await scheduleNotification(alarmInfo: alarmInfo);
    } else {
      await cancelNotification(alarmInfo: alarmInfo);
    }
  }

  Future<void> cancelNotification({required AlarmInfo alarmInfo}) async {
    AwesomeNotifications().cancel(alarmInfo.id.hashCode);
  }
}
