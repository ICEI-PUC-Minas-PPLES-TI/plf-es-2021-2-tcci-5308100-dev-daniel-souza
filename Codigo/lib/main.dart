import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/auth/login_screen.dart';
import 'package:sglh/views/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  await setupLocators();
  runApp(const MyApp());
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
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(AuthStore());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SGLH',
      routes: routes,
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
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.deepPurple,
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: const BaseScreen(),
    );
  }
}
