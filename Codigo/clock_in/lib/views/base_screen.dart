import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/helpers/extensions.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/stores/auth_store.dart';
import 'package:clock_in/stores/month_labor_time_store.dart';
import 'package:clock_in/stores/page_store.dart';
import 'package:clock_in/views/admin/admin_home_page.dart';
import 'package:clock_in/views/auth/login_screen.dart';
import 'package:clock_in/views/home/home_screen.dart';
import 'package:clock_in/views/settings/app_settings.dart';

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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sair do aplicativo?'),
            content: const Text(
                'Ao voltar para a tela inicial será necessário fazer login novamente'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  userManagerStore.logout();
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    laborTimeStore.fetchData();
    super.initState();
    reaction(
        (_) => pageStore.page, (int page) => pageController.jumpToPage(page));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              // WorkHoursPage(
              //   monthLaborTimeStore: laborTimeStore,
              //   monthReference: DateTime.now().getMonthReference(),
              // ),
              HistoryPage(
                pageController: pageController,
              ),
              AppSettings(),
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
      // const BottomNavigationBarItem(
      //   label: 'Histórico',
      //   icon: Icon(
      //     Icons.history,
      //     size: 30,
      //   ),
      // ),
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
