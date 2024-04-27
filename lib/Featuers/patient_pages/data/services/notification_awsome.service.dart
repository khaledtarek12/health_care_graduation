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
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          locked: false,
          icon: 'resource://drawable/logo',
        ),
      ],
    );
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
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationCalendar(
        weekday: now.weekday,
        hour: alarmInfo.alarmDateTime.hour,
        minute: alarmInfo.alarmDateTime.minute,
        second: 0,
        repeats: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'dismiss_button',
          label: 'Dismiss',
          autoDismissible: true,
          actionType: ActionType.DisabledAction,
          enabled: true,
        ),
        NotificationActionButton(
          key: 'view_alarm_button',
          label: 'View Alarm',
          autoDismissible:
              false, // Do not dismiss the notification when this button is clicked
          enabled: true,
          showInCompactView: true,
        ),
      ],
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
