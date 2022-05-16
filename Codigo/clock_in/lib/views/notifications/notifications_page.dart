import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/stores/notification_store.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  NotificationStore store = NotificationStore();

  @override
  void initState() {
    store.fetchNotifications();
    super.initState();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          final future = store.notifications;

          if (future == null) {
            return const CircularProgressIndicator();
          }

          switch (future.status) {
            case FutureStatus.pending:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              );

            case FutureStatus.rejected:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Falha ao carregar as notificações.',
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    child: const Text('Toque para tentar novamente'),
                    onPressed: _refresh,
                  )
                ],
              );

            case FutureStatus.fulfilled:
              final List<NotificationModel> items = future.result;
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.notification_add),
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      onConfirm: (date) async {
                        if (date.isBefore(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text(
                                'O horário especificado não é valido. \nDefina um horário no futuro!',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        } else {
                          await store.scheduleNotification(date);
                          await _refresh();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Marcação de ponto agendada!',
                              ),
                            ),
                          );
                          setState(() {});
                        }
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.pt,
                    );
                  },
                ),
                appBar: AppBar(
                  title: const Text("Notificações"),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.clear_all_outlined),
                      onPressed: store.clearAllNotifications,
                    ),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: _refresh,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (_, index) {
                            final item = items[index];
                            return Dismissible(
                              key: Key(item.toString()),
                              onDismissed: (direction) async {
                                await AwesomeNotifications()
                                    .dismiss(item.content!.id!);
                                await AwesomeNotifications()
                                    .cancel(item.content!.id!);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Recomendação excluída!'),
                                  ),
                                );
                              },
                              background: Container(
                                alignment: Alignment.centerLeft,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Icon(Icons.clear),
                                ),
                                color: Colors.red,
                              ),
                              child: ListTile(
                                leading: Text(
                                  '${item.content!.payload!["clockInDay"]}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                title: Text(
                                  '${item.content!.payload!["formattedHour"]}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '${item.content!.payload!["formattedDate"]}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      );

  Future _refresh() => store.fetchNotifications();
}
