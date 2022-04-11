// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationStore on _NotificationStore, Store {
  final _$notificationsAtom = Atom(name: '_NotificationStore.notifications');

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

  final _$clearAllNotificationsAsyncAction =
      AsyncAction('_NotificationStore.clearAllNotifications');

  @override
  Future<void> clearAllNotifications() {
    return _$clearAllNotificationsAsyncAction
        .run(() => super.clearAllNotifications());
  }

  final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore');

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
  String toString() {
    return '''
notifications: ${notifications}
    ''';
  }
}
