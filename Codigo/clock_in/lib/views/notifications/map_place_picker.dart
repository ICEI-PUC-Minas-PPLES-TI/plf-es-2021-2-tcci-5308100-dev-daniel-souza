import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gmw;
import 'package:location/location.dart' as location_service;

import 'map_picker_strings.dart';

class PlacePickerResult {
  LatLng latLng;
  String address;

  PlacePickerResult(this.latLng, this.address);

  @override
  String toString() {
    return 'PlacePickerResult{latLng: $latLng, address: $address}';
  }
}

class PlacePickerScreen extends StatefulWidget {
  final String googlePlacesApiKey;
  final LatLng initialPosition;
  final Color mainColor;
  final MapPickerStrings mapStrings;
  final String placeAutoCompleteLanguage;

  const PlacePickerScreen(
      {Key? key,
      required this.googlePlacesApiKey,
      required this.initialPosition,
      required this.mainColor,
      required this.mapStrings,
      required this.placeAutoCompleteLanguage})
      : super(key: key);

  @override
  State<PlacePickerScreen> createState() => PlacePickerScreenState();
}

class PlacePickerScreenState extends State<PlacePickerScreen> {
  MapPickerStrings strings = MapPickerStrings.portuguese();
  String placeAutoCompleteLanguage = 'pt';

  late gmw.GoogleMapsPlaces _places;
  late GoogleMapController googleMapController;

  //Camera
  late LatLng centerCamera;
  double zoomCamera = 16;

  //My Location
  LatLng? myLocation;

  //Selected
  LatLng? selectedLatLng;
  String? selectedAddress;

  bool loadingAddress = false;
  bool movingCamera = false;
  bool ignoreGeocoding = false;

  final double _defaultZoom = 16;

  @override
  void initState() {
    centerCamera = LatLng(
        widget.initialPosition.latitude, widget.initialPosition.longitude);
    _places = gmw.GoogleMapsPlaces(apiKey: widget.googlePlacesApiKey);
    selectedLatLng = LatLng(
        widget.initialPosition.latitude, widget.initialPosition.longitude);
    super.initState();
  }

  ///BASIC
  _moveCamera(LatLng latLng, double zoom) async {
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoom)));
  }

  Future<location_service.LocationData?> _getLocation() async {
    var location = location_service.Location();
    location_service.LocationData? locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      debugPrint('Error getting location: $e');
      locationData = null;
    }

    if (locationData != null) {
      myLocation = LatLng(locationData.latitude!, locationData.longitude!);
    }

    return locationData;
  }

  Future<Placemark> _reverseGeocoding(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    var first = placemarks.first;
    return first;
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setSelectedAddress(LatLng? latLng, String? address) async {
      setState(() {
        selectedAddress = address;
        selectedLatLng = latLng;
      });
    }

    ///GO TO
    _searchPlace() async {
      LatLng latLng = LatLng(
        myLocation?.latitude ?? widget.initialPosition.latitude,
        myLocation?.longitude ?? widget.initialPosition.longitude,
      );

      // List<Placemark> location = await placemarkFromCoordinates(
      //     latLng.latitude, latLng.longitude,
      //     localeIdentifier: 'pt_BR');

      gmw.Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: widget.googlePlacesApiKey,
        mode: Mode.fullscreen,
        hint: "Pesquisar",
        language: widget.placeAutoCompleteLanguage,
        location: gmw.Location(lat: latLng.latitude, lng: latLng.longitude),
        offset: 0,
        radius: 1000,
        region: "br",
        types: [],
        components: [gmw.Component(gmw.Component.country, "br")],
        strictbounds: true,
        startText: '',
      );

      if (p != null && p.placeId != null) {
        gmw.PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId!);

        final lat = detail.result.geometry?.location.lat;
        final lng = detail.result.geometry?.location.lng;

        if (lat != null && lng != null) {
          var latLng = LatLng(lat, lng);

          CameraPosition newPosition = CameraPosition(
            target: latLng,
            zoom: _defaultZoom,
          );

          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(newPosition),
          );

          _setSelectedAddress(latLng, detail.result.formattedAddress);

          ignoreGeocoding = true;
        }
      }
    }

    _goToMyLocation() async {
      await _getLocation();
      if (myLocation != null) {
        _moveCamera(myLocation!, _defaultZoom);
      }
    }

    ///WIDGETS
    Widget _mapButtons() {
      return Padding(
        padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              heroTag: "FAB_SEARCH_PLACE",
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () async {
                await _searchPlace();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FloatingActionButton(
                heroTag: "FAB_LOCATION",
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await _goToMyLocation();
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: centerCamera,
                    zoom: zoomCamera,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                  onTap: (latLng) {
                    CameraPosition newPosition =
                        CameraPosition(target: latLng, zoom: _defaultZoom);
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(newPosition));
                  },
                  onCameraMoveStarted: () {
                    setState(() {
                      movingCamera = true;
                    });
                  },
                  onCameraMove: (position) {
                    centerCamera = position.target;
                    zoomCamera = position.zoom;
                  },
                  onCameraIdle: () async {
                    if (ignoreGeocoding) {
                      ignoreGeocoding = false;
                      setState(() {
                        movingCamera = false;
                      });
                    } else {
                      setState(() {
                        movingCamera = false;
                        loadingAddress = true;
                      });

                      Placemark address = (await _reverseGeocoding(
                          centerCamera.latitude, centerCamera.longitude));
                      loadingAddress = false;

                      _setSelectedAddress(
                        centerCamera,
                        _getAddressFromPlaceMark(address),
                      );
                    }
                  },
                ),
                _mapButtons(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Icon(
                      Icons.location_on,
                      size: 60,
                      color: widget.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: ListTile(
                  title: Text(strings.address),
                  subtitle: selectedAddress == null
                      ? Text(strings.firstMessageSelectAddress)
                      : Text(selectedAddress!),
                  trailing: loadingAddress
                      ? CircularProgressIndicator(
                          backgroundColor: widget.mainColor,
                        )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 160,
                      padding: const EdgeInsets.only(right: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(strings.cancel),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: widget.mainColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: !movingCamera &&
                                !loadingAddress &&
                                selectedAddress != null &&
                                selectedLatLng != null
                            ? () {
                                PlacePickerResult result = PlacePickerResult(
                                    selectedLatLng!, selectedAddress!);
                                Navigator.pop(context, result);
                              }
                            : () {
                                debugPrint('movingCamera');
                                debugPrint(movingCamera.toString());
                                debugPrint('loadingAddress');
                                debugPrint(loadingAddress.toString());
                                debugPrint('selectedLatLng');
                                debugPrint(selectedLatLng.toString());
                                debugPrint('selectedAddress');
                                debugPrint(selectedAddress);
                              },
                        child: Text(
                          strings.selectAddress,
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: widget.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: widget.mainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

String _getAddressFromPlaceMark(Placemark address) {
  return '''
    ${address.thoroughfare} ${address.subThoroughfare}, ${address.subLocality}
    ${address.subAdministrativeArea} - ${address.administrativeArea}, ${address.postalCode}''';
}
