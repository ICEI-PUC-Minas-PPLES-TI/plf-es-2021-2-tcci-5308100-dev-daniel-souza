// removed android:name="${applicationName}" line from AndroidManifest.xml

import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clock_in/stores/app_settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:permission_handler/permission_handler.dart';

import 'stores/auth_store.dart';
import 'stores/month_labor_time_store.dart';
import 'stores/page_store.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await doInitializations();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<void> _initializeNotifications() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Notificações por horário agendado',
      ),
      NotificationChannel(
        channelKey: 'geolocation_channel',
        channelName: 'Geolocation Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Notificações por localização',
      ),
    ],
  );
}

Future<void> doInitializations() async {
  debugPrint('initializing parse');
  await _initializeParse();
  debugPrint('initializing locators');
  await _setupLocators();
  // await _initPlatformState();

  if (Platform.isIOS || Platform.isAndroid) {
    debugPrint('Checking permissions');
    await [Permission.notification, Permission.location].request();
    debugPrint('initializing notifications');
    await _initializeNotifications();
  }
}

Future<void> _initializeParse() async {
  await dotenv.load();
  final keyApplicationId = dotenv.get('APP_ID');
  final keyClientKey = dotenv.get('CLIENT_KEY');
  final keyParseServerUrl = dotenv.get('SERVER_URL');

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );
}

Future<void> _setupLocators() async {
  GetIt.I.registerSingleton(AuthStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(MonthLaborTimeStore());
  GetIt.I.registerSingleton(AppSettingsStore());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permitir Notificações'),
              content:
                  const Text('ClockIn gostaria de te enviar notificações!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Não permitir',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Permitir',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
    AwesomeNotifications().actionStream.listen((notification) {
      debugPrint('notification received');
      debugPrint(notification.toString());
      if (notification.payload != null) {
        GetIt.I<MonthLaborTimeStore>().punchClock(DateTime.now());
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CLOCK IN',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        fontFamily: 'google_fonts/Inter-Regular.ttf',
        primarySwatch: Colors.grey,
        primaryColor: Colors.white60,
        backgroundColor: Colors.green,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.deepPurple,
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: WillStartForegroundTask(
        onWillStart: () async {
          return GetIt.I<AppSettingsStore>().geolocationEnabled;
        },
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'geofence_service_notification_channel',
          channelName: 'Geofence Service Notification',
          channelDescription:
              'Serviço de geolocalização rodando em segundo plano',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
          isSticky: false,
        ),
        iosNotificationOptions: const IOSNotificationOptions(),
        notificationTitle: 'Serviço de geolocalização está ativo',
        notificationText: 'Toque para voltar para o aplicativo',
        foregroundTaskOptions: const ForegroundTaskOptions(),
        child: const LoginScreen(),
      ),
    );
  }
}
