import 'package:mobx/mobx.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/repositories/user_admin_repository.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  ObservableFuture<List<User>> userListFuture =
      ObservableFuture(UserAdminRepository().getAllUsers());

  @action
  Future fetchUsers() =>
      userListFuture = ObservableFuture(UserAdminRepository().getAllUsers())
          .then((users) => users);

  void getTheUsers() {
    fetchUsers();
  }
}
