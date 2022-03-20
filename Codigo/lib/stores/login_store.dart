import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/helpers/extensions.dart';
import 'package:sglh/repositories/user_repository.dart';
import 'package:sglh/stores/auth_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email.isEmailValid();

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password.length > 5;

  @observable
  bool loading = false;

  @computed
  bool get formValid =>
      email.length > 5 && password.length > 5 && emailValid && passwordValid;

  @computed
  dynamic get loginPressed =>
      (formValid && !loading) ? _login : _makeErrorsVisible;

  @observable
  String? error;

  @observable
  bool showErrors = false;

  @action
  void _makeErrorsVisible() => showErrors = true;

  @observable
  bool showPassword = false;

  @action
  void showHidePassword() => showPassword = !showPassword;

  @action
  Future<void> _login() async {
    _makeErrorsVisible();
    loading = true;
    try {
      final user = await UserRepository.loginWithEmail(email, password);
      if (user != null) {
        GetIt.I<AuthStore>().setUser(user);
      }
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }
}
