import 'package:clock_in/views/admin/add_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
// ignore: implementation_imports
import 'package:mobx/src/api/async.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/stores/user_store.dart';
import 'package:clock_in/views/components/admin/user_tile.dart';

class AdminHome extends StatelessWidget {
  final UserStore userStore = UserStore();

  AdminHome({Key? key}) : super(key: key) {
    userStore.getTheUsers();
  }

  Future _refresh() => userStore.fetchUsers();

  Widget _getUserList(ObservableFuture<List<User>> future) {
    return Observer(builder: (_) {
      switch (future.status) {
        case FutureStatus.pending:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case FutureStatus.rejected:
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Falha ao carregar os usuários',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text('Toque para tentar novamente'),
                  onPressed: _refresh,
                )
              ],
            ),
          );
        case FutureStatus.fulfilled:
          final List<User> users = future.result;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) {
                final user = users[index];
                return UserTile(user: user);
              },
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final future = userStore.userListFuture;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddUserScreen()))
              .then((_) {
            _refresh();
          });
        },
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: TextStyle(color: Colors.blueGrey),
              decoration: InputDecoration(
                  hintText: "Pesquisar...",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  icon: Icon(Icons.search, color: Colors.blueGrey)),
            ),
          ),
          Expanded(
            child: _getUserList(future),
          ),
        ],
      ),
    );
  }
}
