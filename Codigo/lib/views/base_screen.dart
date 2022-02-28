import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/models/user_model.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/admin_home_page.dart';
import 'package:sglh/views/auth/login_screen.dart';
import 'package:sglh/views/home_screen.dart';

import 'components/custom_drawer/custom_drawer.dart';

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

  @override
  void initState() {
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
          'SGLH',
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
          Observer(builder: (context) {
            return IconButton(
              icon: Icon(
                userManagerStore.isLoggedIn ? Icons.logout : Icons.login,
                color: Colors.black,
              ),
              tooltip: 'Sair',
              onPressed: () {
                userManagerStore.isLoggedIn
                    ? _logout(context)
                    : _login(context);
              },
            );
          }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Home(),
            Container(color: Colors.blueAccent),
            Container(color: Colors.cyan),
            Container(color: Colors.lime),
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
          userManagerStore.user = null;
          pageStore.setPage(0);
        },
        label: 'Confirmar',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _login(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginScreen()))
        .then((_) {
      if (GetIt.I<AuthStore>().user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Login realizado com sucesso!",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 75, 168, 164),
          duration: Duration(seconds: 2),
        ));
      }
    });
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
    if (userManagerStore.user?.type == UserType.admin) {
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
