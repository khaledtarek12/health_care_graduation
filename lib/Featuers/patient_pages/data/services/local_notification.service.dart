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

  final Set<String> scheduledNotifications = {};

  Future<void> scheduleNotification({required AlarmInfo alarmInfo}) async {
    if (scheduledNotifications.contains(alarmInfo.id)) {
      return;
    }
    DateTime now = DateTime.now();

    if (alarmInfo.interval == 0) {
      // Schedule a one-time notification at the selected time of day
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: alarmInfo.id.hashCode,
          channelKey: 'basic_channel',
          title: alarmInfo.title,
          body: alarmInfo.description,
          actionType: ActionType.Default,
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          autoDismissible: false,
          category: NotificationCategory.Alarm,
          // timeoutAfter: Durations.short4,
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
    } else {
      // Schedule the first notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: alarmInfo.id.hashCode,
          channelKey: 'basic_channel',
          title: alarmInfo.title,
          body: alarmInfo.description,
          actionType: ActionType.Default,
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          autoDismissible: false,
          category: NotificationCategory.Alarm,
          // timeoutAfter: Durations.short4,
          duration: const Duration(seconds: 60),
        ),
        schedule: NotificationCalendar(
          weekday: now.weekday,
          hour: alarmInfo.alarmDateTime.hour,
          minute: alarmInfo.alarmDateTime.minute,
          second: 0,
          allowWhileIdle: true,
        ),
      );

      // Calculate the time for the next notification based on the interval
      DateTime nextNotificationTime =
          now.add(Duration(hours: alarmInfo.interval));

      // Schedule subsequent notifications at the specified interval for a certain duration
      while (nextNotificationTime.isBefore(now.add(const Duration(days: 7)))) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: alarmInfo.id.hashCode +
                nextNotificationTime.hour +
                nextNotificationTime.minute,
            channelKey: 'basic_channel',
            title: alarmInfo.title,
            body: alarmInfo.description,
            actionType: ActionType.Default,
            notificationLayout: NotificationLayout.Default,
            wakeUpScreen: true,
            autoDismissible: false,
            category: NotificationCategory.Alarm,
            // timeoutAfter: Durations.short4,
            duration: const Duration(seconds: 60),
          ),
          schedule: NotificationCalendar(
            weekday: nextNotificationTime.weekday,
            hour: nextNotificationTime.hour,
            minute: nextNotificationTime.minute,
            second: 0,
            allowWhileIdle: true,
          ),
        );

        // Move to the next notification time
        nextNotificationTime =
            nextNotificationTime.add(Duration(hours: alarmInfo.interval));
      }
    }
    scheduledNotifications.add(alarmInfo.id);
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
