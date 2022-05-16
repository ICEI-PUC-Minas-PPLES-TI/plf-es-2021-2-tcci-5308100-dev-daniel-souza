import 'dart:async';

import 'package:clock_in/stores/app_settings_store.dart';
import 'package:clock_in/stores/notification_store.dart';
import 'package:clock_in/views/notifications/map_picker_strings.dart';
import 'package:clock_in/views/notifications/map_place_picker.dart';
import 'package:clock_in/views/notifications/keys.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:clock_in/views/notifications/notifications_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppSettings extends StatefulWidget {
  AppSettings({Key? key}) : super(key: key);

  final AppSettingsStore appSettingsStore = GetIt.I<AppSettingsStore>();
  final NotificationStore notificationStore = NotificationStore();

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  Geolocator geolocator = Geolocator();
  Position? position;
  bool isReady = false;

  Future<void> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
    );
    isReady = (position != null) ? true : false;
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();

    widget.appSettingsStore.getWorkPlaceLocation();
  }

  // bool _toggleRecomendations = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.blueGrey[350],
          children: [
            SpeedDialChild(
              child: const Icon(Icons.location_off),
              label: 'Desabilitar Georeferenciamento',
              backgroundColor: Colors.blueGrey[200],
              onTap: () async {
                if (geofenceStatusStream != null) {
                  EasyGeofencing.stopGeofenceService();
                  geofenceStatusStream?.cancel();
                  // show snackbar with confirmation
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Serviço de geolocalização desabilitado"),
                    backgroundColor: Colors.black,
                    duration: Duration(seconds: 2),
                  ));
                  widget.appSettingsStore.deleteWorkPlace();
                } else {
                  // show snackbar with confirmation
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Serviço de georeferenciamento já está desabilitado"),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                  ));
                }
              },
            ),
          ]),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Configurações",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsPage(),
                  ),
                );
              },
              child: const ListTile(
                title: Text('Notificações'),
                subtitle: Text(
                  'Realize a gestão de suas próximas marcações de ponto',
                ),
                leading: Icon(Icons.notifications),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
            GestureDetector(
              onTap: () async {
                final location = Location();
                var serviceEnabled = await location.serviceEnabled();
                if (!serviceEnabled) {
                  serviceEnabled = await location.requestService();
                }
                if (!serviceEnabled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Para ativar esta funcionalidade, é necessário que o serviço de localização esteja habilitado',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                  return;
                } else {
                  debugPrint('Service enabled');
                }
                debugPrint('Checking permission');
                var permissionGranted = await location.hasPermission();
                if (permissionGranted == PermissionStatus.denied) {
                  permissionGranted = await location.requestPermission();
                }

                if (permissionGranted != PermissionStatus.granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Para ativar esta funcionalidade, é necessário permitir o acesso à sua localização',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                  return;
                } else {
                  debugPrint('Permisions granted, proceeding to google maps');
                }
                // At this point, user granted permission and it is possible to get the location.
                final locationData = await location.getLocation();

                PlacePickerResult? pickerResult = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacePickerScreen(
                      googlePlacesApiKey: APIKeys.androidApiKey,
                      initialPosition: locationData.latitude != null &&
                              locationData.longitude != null
                          ? LatLng(
                              locationData.latitude!,
                              locationData.longitude!,
                            )
                          : widget.appSettingsStore.defaultLatLng,
                      mainColor: Colors.purple,
                      mapStrings: MapPickerStrings.portuguese(),
                      placeAutoCompleteLanguage: 'pt-BR',
                    ),
                  ),
                );

                if (pickerResult != null) {
                  widget.appSettingsStore.setWorkPlace(
                    pickerResult.latLng.latitude,
                    pickerResult.latLng.longitude,
                    pickerResult.address,
                  );

                  EasyGeofencing.startGeofenceService(
                    pointedLatitude: pickerResult.latLng.latitude.toString(),
                    pointedLongitude: pickerResult.latLng.longitude.toString(),
                    radiusMeter: "300",
                    eventPeriodInSeconds: 5,
                  );

                  geofenceStatusStream ??= EasyGeofencing.getGeofenceStream()!
                      .listen((GeofenceStatus status) {
                    switch (status) {
                      case GeofenceStatus.enter:
                        widget.notificationStore.showNotification(
                          "Você chegou ao seu trabalho",
                          status,
                        );
                        break;
                      case GeofenceStatus.exit:
                        widget.notificationStore.showNotification(
                          "Saindo do trabalho?",
                          status,
                        );
                        break;
                      default:
                        break;
                    }
                  });
                }
              },
              child: Observer(builder: (context) {
                if (widget.appSettingsStore.isLoading) {
                  return const CircularProgressIndicator();
                }
                return ListTile(
                  title: const Text(
                    'Meu local de trabalho',
                  ),
                  subtitle: widget.appSettingsStore.isWorkPlaceSet &&
                          geofenceStatusStream != null
                      ? Text(widget.appSettingsStore.workPlace!.address)
                      : Text(widget.appSettingsStore.defaultAddressText),
                  leading: const Icon(Icons.location_on),
                  trailing: const Icon(Icons.my_location_rounded),
                );
              }),
            ),
            const Divider(
              thickness: 1.2,
            ),
            // SwitchListTile(
            //   selectedTileColor: Colors.black,
            //   title: const Text(
            //     'Receber notificações baseadas no meu histórico de marcações',
            //   ),
            //   subtitle: const Text(
            //     'Habilite para receber notificações no horário que você '
            //     'está acostumado a marcar seu ponto',
            //   ),
            //   secondary: const Icon(Icons.history),
            //   onChanged: (value) {
            //     setState(() {
            //       _toggleRecomendations = value;
            //     });
            //   },
            //   value: _toggleRecomendations,
            // ),
          ],
        ),
      ),
    );
  }
}
