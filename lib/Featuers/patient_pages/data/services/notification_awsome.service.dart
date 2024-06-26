import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Featuers/patient_pages/data/model/alarm_info.module.dart';

class Notifications {
  bool isFirstNotificationFired =
      false; // Track if the first notification has fired

  Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
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
    await initializeNotification(); // Ensure initialization before scheduling

    int notificationId = alarmInfo.id.hashCode;

    // Schedule first notification
    // ignore: unused_local_variable
    var firstNotificationResponse =
        await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: alarmInfo.title,
        body: alarmInfo.description,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        autoDismissible: true,
        duration: const Duration(minutes: 1),
        category: NotificationCategory.Alarm,
      ),
      schedule: NotificationCalendar(
        weekday: DateTime.now().weekday,
        hour: alarmInfo.alarmDateTime.hour,
        minute: alarmInfo.alarmDateTime.minute,
        second: 0,
        repeats: true,
        allowWhileIdle: true,
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
          autoDismissible: false,
          enabled: true,
          showInCompactView: true,
        ),
      ],
    );

    // Store the response of the first notification
    isFirstNotificationFired = true;

    // Schedule second notification if the first one has fired
    if (isFirstNotificationFired) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'basic_channel',
          title: alarmInfo.title,
          body: alarmInfo.description,
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          autoDismissible: false,
          category: NotificationCategory.Alarm,
          duration: const Duration(seconds: 60),
        ),
        schedule: NotificationInterval(
          interval: 60,
          repeats: true,
          preciseAlarm: true,
          allowWhileIdle: true,
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
            autoDismissible: false,
            enabled: true,
            showInCompactView: true,
          ),
        ],
      );
    }
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
