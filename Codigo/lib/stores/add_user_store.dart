import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/helpers/extensions.dart';
import 'package:sglh/models/user_model.dart';
import 'package:sglh/repositories/user_admin_repository.dart';

part 'add_user_store.g.dart';

class AddUserStore = _AddUserStore with _$AddUserStore;

abstract class _AddUserStore with Store {
  final Map<String, UserType> userTypeMap = {
    "Comum": UserType.user,
    "Administrador": UserType.admin,
  };

  final Map<UserType, String> userTypeMapReverse = {
    UserType.user: "Comum",
    UserType.admin: "Administrador",
  };

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  dynamic photo;

  @observable
  String post = "Trainee";

  @observable
  List<String> roles = ["Trainee", "Software Engineer", "Project Manager"];

  @observable
  UserType userType = UserType.user;

  @observable
  DateTime startDate = DateTime.now();

  @computed
  String? get userTypeString => userTypeMapReverse[userType];

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPhoto(dynamic value) => photo = value;

  @action
  void setStartDate(DateTime value) => startDate = value;

  @action
  void setUserType(String? value) {
    final selectedType = userTypeMap[value];
    if (value != null && selectedType != null) {
      userType = selectedType;
    }
  }

  @action
  void setPost(String? value) {
    if (value != null) {
      post = value;
    }
  }

  @computed
  bool get nameValid {
    return name.length > 8;
  }

  @computed
  dynamic get nameError {
    if (nameValid || !showErrors) {
      return null;
    } else if (name.isEmpty) {
      return "Campo Obrigatorio";
    } else {
      return "Nome muito curto";
    }
  }

  @computed
  bool get emailValid => email.isEmailValid();
  dynamic get emailError {
    if (emailValid || !showErrors) {
      return null;
    } else if (email.isEmpty) {
      return "Campo Obrigatório";
    } else {
      return "E-mail inválido";
    }
  }

  @computed
  dynamic get postError {
    if (!roles.contains(post) && !showErrors) {
      return "Cargo inválido";
    } else {
      return null;
    }
  }

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool userCreated = false;

  @computed
  bool get isFormValid => nameValid && emailValid;

  @computed
  dynamic get signupPressed => (isFormValid && !isLoading) ? _signUp : null;

  @observable
  bool userSavedForm = false;

  @computed
  bool get showErrors => userSavedForm;

  @action
  Future<void> _signUp() async {
    isLoading = true;

    final user = User(
      name: name,
      email: email,
      password: dotenv.get('DEFAULT_PASSWORD'),
      post: post,
      type: userType,
      photo: photo,
    );

    try {
      await UserAdminRepository().createUser(user);
      userCreated = true;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @override
  String toString() {
    return 'AddUserStore{name: $name, email: $email, photo: $photo, post: $post, userType: $userType, startDate: $startDate, isLoading: $isLoading, error: $error, userCreated: $userCreated, userSavedForm: $userSavedForm}';
  }
}
