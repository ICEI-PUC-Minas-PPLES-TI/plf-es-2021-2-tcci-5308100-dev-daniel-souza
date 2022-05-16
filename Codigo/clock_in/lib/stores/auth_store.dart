import 'package:mobx/mobx.dart';
import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/repositories/user_repository.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore() {
    _getCurrentStore();
  }

  static User anonUser = User(
    name: 'Anonymous',
    email: 'anonymous@email.com',
    isActive: false,
  );

  @observable
  User user = anonUser;

  @action
  void logout() => user = anonUser;

  @action
  void setUser(User value) {
    user = value;
  }

  @computed
  bool get isLoggedIn => user.objectId != null;

  @action
  Future<void> _getCurrentStore() async {
    final user = await UserRepository.currentUser();
    if (user != null) {
      setUser(user);
    }
  }
}
