import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/models/recommendation/schedule_clock_in.dart';
import 'package:clock_in/services/notification_service.dart';

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

  @observable
  GeofenceStatus? lastKnowStatus;

  @action
  void setLastKnowStatus(GeofenceStatus status) => lastKnowStatus = status;

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

  @action
  Future<void> showNotification(String title, GeofenceStatus status) async {
    // prevent showing the same notification ad eternum while the user is/outside the office
    if (lastKnowStatus != null && lastKnowStatus == status) {
      return;
    }
    await createGeofencingNotification(title);
    setLastKnowStatus(status);
  }
}
