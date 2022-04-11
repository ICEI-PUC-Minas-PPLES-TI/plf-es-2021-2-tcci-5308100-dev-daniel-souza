import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/month_labor_time_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await doInitializations();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

void initializeNotification() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'Notificações básicas',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: '',
      ),
      NotificationChannel(
        channelKey: 'geolocation_channel',
        channelName: 'Geolocation Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Notificações por localização',
      ),
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Reminder Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Notificações por recomendação',
      ),
    ],
  );
}

Future<void> doInitializations() async {
  await initializeParse();
  await setupLocators();
  initializeNotification();
}

Future<void> initializeParse() async {
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

Future<void> setupLocators() async {
  GetIt.I.registerSingleton(AuthStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(MonthLaborTimeStore());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SGLH',
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
      home: const LoginScreen(),
    );
  }
}
