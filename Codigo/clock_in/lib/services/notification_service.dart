import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:clock_in/models/recommendation/schedule_clock_in.dart';
import 'package:clock_in/views/components/utils/notification.dart';

Future<void> createPunchClockNotification(
    ScheduleClockIn scheduledClockIn) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: 'Hora de bater o ponto!',
      body: scheduledClockIn.toString(),
      notificationLayout: NotificationLayout.Default,
      locked: true,
      payload: scheduledClockIn.toJson(),
    ),
    schedule: NotificationCalendar(
      preciseAlarm: true,
      timeZone: 'America/Sao_Paulo',
      allowWhileIdle: true,
      repeats: false,
      year: scheduledClockIn.timeToClockIn.year,
      month: scheduledClockIn.timeToClockIn.month,
      day: scheduledClockIn.timeToClockIn.day,
      hour: scheduledClockIn.timeToClockIn.hour,
      minute: scheduledClockIn.timeToClockIn.minute,
      second: scheduledClockIn.timeToClockIn.second,
      millisecond: scheduledClockIn.timeToClockIn.millisecond,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'PUNCH_CLOCK',
        label: 'Marcar ponto',
        color: Colors.teal,
        buttonType: ActionButtonType.KeepOnTop,
      ),
      NotificationActionButton(
        key: 'NOT_PUNCH_CLOCK',
        label: 'Agora não',
        color: Colors.red,
        buttonType: ActionButtonType.DisabledAction,
      ),
    ],
  );
}

Future<void> createGeofencingNotification(String title) async {
  ScheduleClockIn scheduleClockIn = ScheduleClockIn(DateTime.now());
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'geolocation_channel',
      title: title,
      body: "Deseja marcar o ponto agora?",
      notificationLayout: NotificationLayout.Default,
      locked: true,
      payload: scheduleClockIn.toJson(),
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'PUNCH_CLOCK',
        label: 'Marcar agora',
        color: Colors.teal,
        buttonType: ActionButtonType.KeepOnTop,
      ),
      NotificationActionButton(
        key: 'NOT_PUNCH_CLOCK',
        label: 'Agora não',
        color: Colors.red,
        buttonType: ActionButtonType.DisabledAction,
      ),
    ],
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<List<NotificationModel>> getNotifications() async {
  return await AwesomeNotifications().listScheduledNotifications();
}
