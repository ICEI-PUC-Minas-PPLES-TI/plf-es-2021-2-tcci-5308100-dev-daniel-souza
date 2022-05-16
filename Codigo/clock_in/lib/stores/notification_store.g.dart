// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationStore on _NotificationStore, Store {
  late final _$notificationsAtom =
      Atom(name: '_NotificationStore.notifications', context: context);

  @override
  ObservableFuture<List<NotificationModel>>? get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableFuture<List<NotificationModel>>? value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$lastKnowStatusAtom =
      Atom(name: '_NotificationStore.lastKnowStatus', context: context);

  @override
  GeofenceStatus? get lastKnowStatus {
    _$lastKnowStatusAtom.reportRead();
    return super.lastKnowStatus;
  }

  @override
  set lastKnowStatus(GeofenceStatus? value) {
    _$lastKnowStatusAtom.reportWrite(value, super.lastKnowStatus, () {
      super.lastKnowStatus = value;
    });
  }

  late final _$clearAllNotificationsAsyncAction =
      AsyncAction('_NotificationStore.clearAllNotifications', context: context);

  @override
  Future<void> clearAllNotifications() {
    return _$clearAllNotificationsAsyncAction
        .run(() => super.clearAllNotifications());
  }

  late final _$scheduleNotificationAsyncAction =
      AsyncAction('_NotificationStore.scheduleNotification', context: context);

  @override
  Future<void> scheduleNotification(DateTime dateTime) {
    return _$scheduleNotificationAsyncAction
        .run(() => super.scheduleNotification(dateTime));
  }

  late final _$showNotificationAsyncAction =
      AsyncAction('_NotificationStore.showNotification', context: context);

  @override
  Future<void> showNotification(String title, GeofenceStatus status) {
    return _$showNotificationAsyncAction
        .run(() => super.showNotification(title, status));
  }

  late final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore', context: context);

  @override
  Future<dynamic> fetchNotifications() {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.fetchNotifications');
    try {
      return super.fetchNotifications();
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastKnowStatus(GeofenceStatus status) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.setLastKnowStatus');
    try {
      return super.setLastKnowStatus(status);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notifications: ${notifications},
lastKnowStatus: ${lastKnowStatus}
    ''';
  }
}
