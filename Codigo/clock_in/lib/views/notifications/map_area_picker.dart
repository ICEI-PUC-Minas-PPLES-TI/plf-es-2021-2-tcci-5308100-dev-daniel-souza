import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/utils/poly_utils.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as location_service;

import 'map_picker_strings.dart';

class AreaPickerResult {
  LatLng selectedLatLng;
  double radiusInMeters;
  List<LatLng> polygonPoints;

  AreaPickerResult(
      this.selectedLatLng, this.radiusInMeters, this.polygonPoints);

  @override
  String toString() {
    return 'AreaPickerResult{selectedLatLng: $selectedLatLng, radiusInMeters: $radiusInMeters, polygonPoints: $polygonPoints}';
  }
}

class AreaPickerScreen extends StatefulWidget {
  const AreaPickerScreen({
    Key? key,
    required this.markerAsset,
    this.mainColor = Colors.cyan,
    required this.googlePlacesApiKey,
    required this.initialPosition,
    this.distanceSteps = const [
      10,
      50,
      100,
      200,
      400,
      800,
      1600,
      3200,
      6400,
    ],
    this.initialStepIndex = 0,
    this.initialPolygon = const [],
    this.enableFreeDraw = true,
    required this.mapStrings,
    required this.placeAutoCompleteLanguage,
  }) : super(key: key);

  final String markerAsset;
  final Color mainColor;
  final String googlePlacesApiKey;
  final LatLng initialPosition;
  final List<double> distanceSteps;
  final int initialStepIndex;
  final List<LatLng> initialPolygon;
  final bool enableFreeDraw;
  final String placeAutoCompleteLanguage;
  final MapPickerStrings mapStrings;

  @override
  _AreaPickerScreenState createState() => _AreaPickerScreenState();
}

class _AreaPickerScreenState extends State<AreaPickerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BitmapDescriptor? iconSelectedLocation;
  late GoogleMapsPlaces _places;
  GoogleMapController? googleMapController;

  //Camera
  late LatLng centerCamera;
  late double zoomCamera;

  //My Location
  LatLng? myLocation;

  //CIRCLE
  late LatLng selectedLatLng;
  late double radiusInMeters;

  //POLYGON
  List<LatLng> polygonPoints = [];

  bool drawing = false;

  @override
  void initState() {
    _places = GoogleMapsPlaces(apiKey: widget.googlePlacesApiKey);
    selectedLatLng = LatLng(
      widget.initialPosition.latitude,
      widget.initialPosition.longitude,
    );
    centerCamera = LatLng(
      widget.initialPosition.latitude,
      widget.initialPosition.longitude,
    );

    zoomCamera = 20;
    radiusInMeters = widget.distanceSteps[widget.initialStepIndex];
    polygonPoints = widget.initialPolygon;

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(30, 30),
            ),
            widget.markerAsset)
        .then((onValue) {
      iconSelectedLocation = onValue;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///BASIC
  _moveCamera(LatLng latLng, double? zoom) async {
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          // zoom: zoom,
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    var location = location_service.Location();
    location_service.LocationData? locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      locationData = null;
    }
    if (locationData != null &&
        locationData.latitude != null &&
        locationData.longitude != null) {
      myLocation = LatLng(locationData.latitude!, locationData.longitude!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ///MAP ELEMENTS
    _getMarkers() {
      Set<Marker> markers = {};

      if (drawing || polygonPoints.isNotEmpty) return markers;

      markers.add(Marker(
        markerId: const MarkerId("selected_position"),
        position: LatLng(selectedLatLng.latitude, selectedLatLng.longitude),
        icon: iconSelectedLocation ?? BitmapDescriptor.defaultMarker,
      ));

      return markers;
    }

    _getCircles() {
      Set<Circle> circles = {};
      if (drawing || polygonPoints.isNotEmpty) return circles;

      circles.add(Circle(
        circleId: const CircleId('circle_radius'),
        fillColor: widget.mainColor.withOpacity(0.2),
        strokeWidth: 0,
        center: selectedLatLng,
        radius: radiusInMeters,
      ));
      return circles;
    }

    _getPolygons() {
      Set<Polygon> polygons = {};
      if (polygonPoints.isNotEmpty) {
        polygons.add(Polygon(
          polygonId: const PolygonId("polygon_area"),
          visible: true,
          points: polygonPoints,
          fillColor: widget.mainColor.withOpacity(0.1),
          strokeWidth: 3,
        ));
      }
      return polygons;
    }

    ///MAP DRAW
    _removeCustomArea() {
      setState(() {
        polygonPoints = [];
      });
    }

    List<LatLng> _simplify(List<LatLng> coordinates) {
      List<Point> points = coordinates
          .map((latLng) => Point(latLng.latitude, latLng.longitude))
          .toList();
      List<Point> simplifiedPoints = PolyUtils.simplify(points, 100); //todo
      return simplifiedPoints
          .map((p) => LatLng(p.x.toDouble(), p.y.toDouble()))
          .toList();
    }

    _onDrawPolygon(List<DrawingPoints> points) async {
      final devicePixelRatio =
          Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;

      Future<LatLng> _getLatLngFromScreenCoordinate(double x, double y) async {
        ScreenCoordinate screenCoordinate = ScreenCoordinate(
            x: (x * devicePixelRatio).round(),
            y: (y * devicePixelRatio).round());
        return await googleMapController!.getLatLng(screenCoordinate);
      }

      List<LatLng> latLngPoints = [];
      for (var p in points) {
        var currentLatLng =
            await _getLatLngFromScreenCoordinate(p.points.dx, p.points.dy);
        latLngPoints.add(currentLatLng);
      }

      setState(() {
        polygonPoints = _simplify(latLngPoints);
        drawing = false;
      });
    }

    _initFreeDraw() {
      _removeCustomArea();
      setState(() {
        drawing = true;
      });
    }

    Widget _circleRadiusWidget() {
      return SizedBox(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider(
              min: 0,
              max: (widget.distanceSteps.length - 1).toDouble(),
              divisions: widget.distanceSteps.length - 1,
              onChanged: (value) {
                setState(() {
                  radiusInMeters = widget.distanceSteps[value.floor()];
                  // _moveCamera(selectedLatLng, widget.zoomSteps[value.floor()]);
                  _moveCamera(selectedLatLng, null);
                });
              },
              value: widget.distanceSteps.indexOf(radiusInMeters).toDouble(),
              activeColor: widget.mainColor,
              inactiveColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 16),
              child: Text(widget.mapStrings.distanceInKmFromYou
                  .replaceAll("\$", "${radiusInMeters ~/ 1000}")),
            )
          ],
        ),
      );
    }

    Widget _polygonEditorWidget() {
      if (drawing) {
        return Container(
          height: 90,
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: widget.mainColor, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ListTile(
              leading: const Icon(Icons.mode_edit),
              title: Text(widget.mapStrings.drawAreaOnMap),
            ),
          ),
        );
      }

      return Container(
        height: 90,
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: widget.mainColor, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(widget.mapStrings.customArea),
            trailing: TextButton(
              child: Text(widget.mapStrings.delete),
              onPressed: () {
                _removeCustomArea();
              },
            ),
          ),
        ),
      );
    }

    _selectCenterCircle(LatLng latLng) {
      setState(() {
        selectedLatLng = latLng;
        _moveCamera(latLng, zoomCamera);
      });
    }

    ///GO TO
    _goToPlace() async {
      await _getLocation();

      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: widget.googlePlacesApiKey,
        mode: Mode.fullscreen,
        hint: "Pesquisar",
        language: widget.placeAutoCompleteLanguage,
        location: myLocation != null
            ? Location(lat: myLocation!.latitude, lng: myLocation!.longitude)
            : null,
        offset: 0,
        radius: 1000,
        region: "br",
        types: [],
        components: [Component(Component.country, "br")],
        strictbounds: true,
        startText: '',
      );

      if (p != null && p.placeId != null) {
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry?.location.lat;
        final lng = detail.result.geometry?.location.lng;

        if (lat != null && lng != null) {
          _moveCamera(LatLng(lat, lng), null);
          _selectCenterCircle(LatLng(lat, lng));
        }
      }
    }

    _goToMyLocation() async {
      await _getLocation();
      if (myLocation != null) {
        _moveCamera(myLocation!, zoomCamera);
        _selectCenterCircle(myLocation!);
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
              onPressed: () {
                _goToPlace();
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
                onPressed: () {
                  _goToMyLocation();
                },
              ),
            ),
            if (widget.enableFreeDraw)
              FloatingActionButton(
                heroTag: "FAB_DRAW",
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.mode_edit,
                  color: Colors.black,
                ),
                onPressed: () {
                  _initFreeDraw();
                },
              ),
          ],
        ),
      );
    }

    Future<bool> _onBackPressed() async {
      if (drawing) {
        drawing = false;
        _removeCustomArea();
        return false;
      }
      return true;
    }

    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
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
                      _selectCenterCircle(latLng);
                    },
                    onCameraMove: (position) {
                      centerCamera = position.target;
                    },
                    circles: _getCircles(),
                    markers: _getMarkers(),
                    polygons: _getPolygons(),
                  ),
                  if (!drawing) _mapButtons(),
                  if (drawing)
                    Draw(
                      onDrawEnd: _onDrawPolygon,
                    ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                drawing || polygonPoints.isNotEmpty
                    ? _polygonEditorWidget()
                    : _circleRadiusWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 160,
                        padding: const EdgeInsets.only(right: 16),
                        child: TextButton(
                          onPressed: !drawing
                              ? () {
                                  Navigator.pop(context);
                                }
                              : null,
                          child: Text(widget.mapStrings.cancel),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: !drawing
                                      ? widget.mainColor
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: !drawing
                              ? () {
                                  AreaPickerResult result = AreaPickerResult(
                                      selectedLatLng,
                                      radiusInMeters,
                                      polygonPoints);

                                  Navigator.pop(context, result);
                                }
                              : null,
                          child: Text(
                            widget.mapStrings.saveArea,
                            // style: const TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            primary: widget.mainColor,
                            // disabledColor: Colors.grey[350],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: !drawing
                                      ? widget.mainColor
                                      : Colors.black),
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
        resizeToAvoidBottomInset: true,
      ),
      onWillPop: _onBackPressed,
    );
  }
}

class Draw extends StatefulWidget {
  const Draw({Key? key, required this.onDrawEnd}) : super(key: key);

  final Function(List<DrawingPoints>) onDrawEnd;

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  Color selectedColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = [];
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  RenderBox? renderBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      renderBox = context.findRenderObject() as RenderBox?;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (renderBox != null) {
            points.add(
              DrawingPoints(
                points: renderBox!.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth,
              ),
            );
          }
        });
      },
      onPanStart: (details) {
        if (renderBox != null) {
          setState(() {
            points.add(
              DrawingPoints(
                points: renderBox!.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth,
              ),
            );
          });
        }
      },
      onPanEnd: (details) {
        widget.onDrawEnd(points);
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: DrawingPainter(
          pointsList: points,
        ),
      ),
    );
  }
}

///DRAW
class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.pointsList});

  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({required this.points, required this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }
