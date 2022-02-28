import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/helpers/extensions.dart';
import 'package:sglh/models/user_model.dart';
import 'package:sglh/repositories/user_repository.dart';
import 'package:sglh/stores/auth_store.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? password1;

  @observable
  String? password2;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword1(String value) => password1 = value;

  @action
  void setPassword2(String value) => password2 = value;

  @computed
  bool get nameIsString => name is String;

  @computed
  bool get emailIsString => email is String;

  @computed
  bool get password1IsString => password1 is String;

  @computed
  bool get password2IsString => password2 is String;

  @computed
  bool get nameValid {
    if (name != null && (name.toString()).length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  @computed
  dynamic get nameError {
    if (nameIsString) {
      if (nameValid) {
        return null;
      } else if ((name.toString()).isEmpty) {
        return "Campo Obrigatorio";
      } else {
        return "Nome muito curto";
      }
    } else {
      return null;
    }
  }

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  dynamic get emailErro {
    if (emailIsString) {
      if (emailValid) {
        return null;
      } else if (email!.isEmpty) {
        return "Campo Obrigatorio";
      } else {
        return "E-mail inválido";
      }
    } else {
      return null;
    }
  }

  @computed
  bool get password1Valid => password1 != null && password1!.length >= 6;

  @computed
  dynamic get password1Error {
    if (password1IsString) {
      if (password1Valid) {
        return null;
      } else if (password1!.isEmpty) {
        return "Campo Obrigatorio";
      } else {
        return "Senha muito curta";
      }
    } else {
      return null;
    }
  }

  @computed
  bool get password2Valid => password2 != null && password2! == password1;

  @computed
  dynamic get password2Error {
    if (password2IsString) {
      if (password2Valid) {
        return null;
      } else if (password2!.isEmpty) {
        return "Campo Obrigatorio";
      } else {
        return "Senhas não coindidem!";
      }
    } else {
      return null;
    }
  }

  @observable
  bool showPassword1 = false;

  @action
  void showHidePassword1() => showPassword1 = !showPassword1;

  @observable
  bool showPassword2 = false;

  @action
  void showHidePassword2() => showPassword2 = !showPassword2;

  @observable
  String? error;

  @computed
  bool get isFormValid =>
      nameValid && emailValid && password1Valid && password2Valid;

  @computed
  dynamic get signupPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool loading = false;

  @observable
  User? user;

  @computed
  bool get userCreated => user != null;

  @action
  Future<void> _signUp() async {
    loading = true;

    final userToCreate = User(
      name: name!,
      email: email!,
      password: password1!,
    );

    try {
      final resultUser = await UserRepository().signUp(userToCreate);
      if (resultUser != null) {
        GetIt.I.get<AuthStore>().setUser(resultUser);
        user = resultUser;
      }
    } catch (e) {
      error = e as String;
    } finally {
      loading = false;
    }

    loading = false;
  }
}
