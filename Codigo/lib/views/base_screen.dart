import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/helpers/extensions.dart';
import 'package:sglh/models/auth/user_model.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/month_labor_time_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/admin/admin_home_page.dart';
import 'package:sglh/views/auth/login_screen.dart';
import 'package:sglh/views/home/home_screen.dart';
import 'package:sglh/views/settings/app_settings.dart';

import 'components/custom_drawer/custom_drawer.dart';
import 'hours_management/history_page.dart';
import 'hours_management/work_hours_page.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();
  final AuthStore userManagerStore = GetIt.I<AuthStore>();
  final MonthLaborTimeStore laborTimeStore = GetIt.I<MonthLaborTimeStore>();

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permitir Notificações'),
              content:
                  const Text('Nosso app gostaria de te enviar notificações!'),
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
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Marcação de ponto agendada!',
          ),
        ),
      );
    });
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }

      print("Action Stream!");
      // print(notification.toString());
      if (notification.payload != null) {
        print('Payload not null');
        print(notification.payload!['timeToClockIn']);
        laborTimeStore.punchClock(DateTime.now());
      }
    }, onDone: () {
      print('done');
    }, onError: (obj) {
      print('error on notification');
      print(obj.toString());
    });
    // // Fired whenever a location is recorded
    // bg.BackgroundGeolocation.onLocation((bg.Location location) {
    //   print('[location] - $location');
    // });
    // // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    // bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
    //   print('[motionchange] - $location');
    // });
    // // Fired whenever the state of location-services changes.  Always fired at boot
    // bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
    //   print('[providerchange] - $event');
    // });
    // ////
    // // 2.  Configure the plugin
    // //
    // bg.BackgroundGeolocation.ready(bg.Config(
    //         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    //         distanceFilter: 10.0,
    //         stopOnTerminate: false,
    //         startOnBoot: true,
    //         debug: true,
    //         logLevel: bg.Config.LOG_LEVEL_VERBOSE))
    //     .then((bg.State state) {
    //   if (!state.enabled) {
    //     ////
    //     // 3.  Start the plugin.
    //     //
    //     bg.BackgroundGeolocation.start();
    //   }
    // });
    laborTimeStore.fetchData();
    super.initState();
    reaction(
        (_) => pageStore.page, (int page) => pageController.jumpToPage(page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'ClockIn',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        elevation: 8,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[300]!, Colors.grey[500]!],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            tooltip: 'Sair',
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Home(),
            WorkHoursPage(
              monthLaborTimeStore: laborTimeStore,
              monthReference: DateTime.now().getMonthReference(),
            ),
            HistoryPage(
              pageController: pageController,
            ),
            const AppSettings(),
            AdminHome()
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) {
          return BottomNavigationBar(
            currentIndex: pageStore.page,
            onTap: (int currentIndex) => pageStore.setPage(currentIndex),
            backgroundColor: Colors.grey[100],
            type: BottomNavigationBarType.fixed,
            items: _getBottomNavigationItems(),
          );
        },
      ),
    );
  }

  _logout(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Realizar log out?'),
      action: SnackBarAction(
        onPressed: () {
          userManagerStore.logout();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LoginScreen();
              },
            ),
          );
        },
        label: 'Confirmar',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    List<BottomNavigationBarItem> bottomNavigationBarItemsList = [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(
          Icons.home,
          size: 30,
        ),
      ),
      const BottomNavigationBarItem(
        label: 'Ponto',
        icon: Icon(
          Icons.watch_later_outlined,
          size: 30,
        ),
      ),
      const BottomNavigationBarItem(
        label: 'Histórico',
        icon: Icon(
          Icons.history,
          size: 30,
        ),
      ),
      const BottomNavigationBarItem(
        label: 'Configurações',
        icon: Icon(
          Icons.settings,
          size: 30,
        ),
      ),
    ];
    if (userManagerStore.user.type == UserType.admin) {
      bottomNavigationBarItemsList.add(
        const BottomNavigationBarItem(
          label: 'Admin',
          icon: Icon(
            Icons.admin_panel_settings_outlined,
            size: 30,
          ),
        ),
      );
    }
    return bottomNavigationBarItemsList;
  }
}
