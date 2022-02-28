import 'package:mobx/mobx.dart';
import 'package:sglh/models/user_model.dart';
import 'package:sglh/repositories/user_repository.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore() {
    _getCurrentStore();
  }

  @observable
  User? user;

  @action
  void setUser(User value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentStore() async {
    final user = await UserRepository().currentUser();
    if (user != null) {
      setUser(user);
    }
  }
}
