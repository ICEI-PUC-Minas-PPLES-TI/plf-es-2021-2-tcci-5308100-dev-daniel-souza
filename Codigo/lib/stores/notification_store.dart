import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/models/recommendation/schedule_clock_in.dart';
import 'package:sglh/notifications/notification_service.dart';

part 'notification_store.g.dart';

enum FeedType { latest, top }

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  @observable
  ObservableFuture<List<NotificationModel>>? notifications;

  @action
  Future fetchNotifications() =>
      notifications = ObservableFuture(getNotifications());

  void loadNotifications() {
    fetchNotifications();
  }

  @action
  Future<void> clearAllNotifications() async {
    await AwesomeNotifications().dismissAllNotifications();
    await AwesomeNotifications().cancelAllSchedules();
    await AwesomeNotifications().cancelAll();
    await fetchNotifications();
  }

  @action
  Future<void> scheduleNotification(DateTime dateTime) async {
    ScheduleClockIn scheduleClockIn = ScheduleClockIn(dateTime);
    await createPunchClockNotification(scheduleClockIn);
    await fetchNotifications();
  }
}
