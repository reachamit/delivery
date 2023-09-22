import 'package:delivery/models/cls_order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMap_CustomerLocations extends StatefulWidget {
  final OrderDetail order;

  const GoogleMap_CustomerLocations({Key? key, required this.order})
      : super(key: key);
  @override
  State<GoogleMap_CustomerLocations> createState() =>
      _GoogleMap_CustomerLocationsState();
}

class _GoogleMap_CustomerLocationsState
    extends State<GoogleMap_CustomerLocations> {
  late GoogleMapController _mapController;
  late LatLng _center;
  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  LatLng _startLocation = LatLng(37.7749, -122.4194);
  LatLng _endLocation  = LatLng(34.0522, -118.2437);


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addMarkers();
    _getPolylines();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _center = LatLng(widget.order.delivery_latitude ?? 30.7333, widget.order.delivery_longitude ?? 76.7794);
  }

  Future<void> _getCurrentLocation() async {
    try {
      final status = await Permission.location.request();
      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _center = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double calculateDistance(LatLng start, LatLng end) {
      final double distance = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );
      return distance;
    }

    bool isWithin100Meters(LatLng start, LatLng end) {
      return calculateDistance(start, end) <= 100;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.red,
          title: const Text('Location Map Details '),
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // This will pop the current screen and go back
            },
          ),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: _startLocation,
            zoom: 7.0,
          ),
          markers: _markers,
          polylines: _polylines,
        ),
        floatingActionButton:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
          alignment: Alignment.bottomCenter,
    child:Padding(
    padding: const EdgeInsets.all(8.0), // Adjust the padding to change the size
    child:FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _determinePosition();

            _mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14)));

            _markers.clear();

            _markers.add(Marker(
                markerId: const MarkerId('currentLocation'),
                position: LatLng(position.latitude, position.longitude)));

            setState(() {});
          },
          label: const Text("Current Location"),
          icon: const Icon(Icons.location_history),
    ),

    ),
        ),
        SizedBox(height: 16),
   if (isWithin100Meters(_startLocation, _endLocation))
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Code for the "Delivered" button
                  // ...
                },
                label: const Text("Delivered"),
                icon: const Icon(Icons.check),
              ),
            ),
        ),
          ]
    ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void _addMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('start_marker'),
        position: _startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: 'Start Location'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('end_marker'),
        position: _endLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: 'End Location'),
      ),
    );
  }

  Future<void> _getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB67Kt2uIgh-zC8TKA_QivaAcIa9mmm9B8',
        PointLatLng(_startLocation.latitude, _startLocation.longitude),
        PointLatLng(_endLocation.latitude, _endLocation.longitude)
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId('path'),
            color: Colors.blue,
            points: _polylineCoordinates,
            width: 5,
          ),
        );
      });
      // Calculate camera bounds to encompass both endpoints
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _startLocation.latitude < _endLocation.latitude ? _startLocation.latitude : _endLocation.latitude,
          _startLocation.longitude < _endLocation.longitude ? _startLocation.longitude : _endLocation.longitude,
        ),
        northeast: LatLng(
          _startLocation.latitude > _endLocation.latitude ? _startLocation.latitude : _endLocation.latitude,
          _startLocation.longitude > _endLocation.longitude ? _startLocation.longitude : _endLocation.longitude,
        ),
      );

      // Move the camera to fit both endpoints
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }
}


