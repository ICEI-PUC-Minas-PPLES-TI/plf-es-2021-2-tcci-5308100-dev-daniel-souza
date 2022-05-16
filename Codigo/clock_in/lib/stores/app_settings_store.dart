import 'package:clock_in/models/auth/user_model.dart';
import 'package:clock_in/models/recommendation/work_place_model.dart';
import 'package:clock_in/repositories/work_place_repository.dart';
import 'package:clock_in/stores/auth_store.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'app_settings_store.g.dart';

class AppSettingsStore = _AppSettingsStore with _$AppSettingsStore;

abstract class _AppSettingsStore with Store {
  // Liberty Square PUC
  final LatLng defaultLatLng = const LatLng(
    -19.933056692748362,
    -43.93640811215041,
  );

  final String defaultAddressText =
      'Defina seu local de trabalho no mapa para receber uma notificação ao chegar e sair do trabalho!';

  @observable
  bool geolocationEnabled = true;

  @observable
  bool notificationsEnabled = true;

  @observable
  bool remindersEnabled = true;

  @observable
  bool isLoading = false;

  @action
  void setGeolocationEnabled(bool value) => geolocationEnabled = value;

  @action
  void setNotificationsEnabled(bool value) => notificationsEnabled = value;

  @action
  void setRemindersEnabled(bool value) => remindersEnabled = value;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @observable
  WorkPlace? workPlace;

  @computed
  bool get isWorkPlaceSet => workPlace != null;

  @action
  Future<void> getWorkPlaceLocation() async {
    User user = GetIt.I.get<AuthStore>().user;
    setIsLoading(true);
    workPlace = await WorkPlaceRepository.getUserWorkPlace(user);
    setIsLoading(false);
  }

  @action
  Future<void> setWorkPlace(
    double latitude,
    double longitude,
    String address,
  ) async {
    User user = GetIt.I.get<AuthStore>().user;

    workPlace = WorkPlace(
      address: address,
      latitude: latitude,
      longitude: longitude,
      user: user,
      isActive: true,
    );

    setIsLoading(true);
    await WorkPlaceRepository.saveData(workPlace!);
    await getWorkPlaceLocation();
    setIsLoading(false);
  }

  @action
  Future<void> deleteWorkPlace() async {
    setIsLoading(true);
    await WorkPlaceRepository.deleteData(workPlace!);
    workPlace = null;
    setIsLoading(false);
  }

  @observable
  String? searchResult;

  @action
  void search(String value) => searchResult = value;

  @action
  void clearSearch() => searchResult = null;
}
