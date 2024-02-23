import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  final Location _location = Location();
  LocationData? _currentLocation;
  late GoogleMapController _mapController;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _locationSubscription = _location.onLocationChanged.listen((newLocation) {
      setState(() {
        _currentLocation = newLocation;
        _moveCamera(
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!));
      });
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel(); // Cancel location updates subscription
    super.dispose();
  }

  _moveCamera(LatLng latLng) async {
    _mapController = await _googleMapController.future;
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 18));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 19,
            ),
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              if (!_googleMapController.isCompleted) {
                _googleMapController.complete(controller);
              }
              _mapController = controller;
            },
          ),
          Positioned(
            top: 50,
            right: 16.0,
            child: Column(
              children: [
                FloatingActionButton(
                  key: UniqueKey(),
                  heroTag: 'btn 1',
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8.0),
                FloatingActionButton(
                  key: UniqueKey(),
                  heroTag: 'btn 2',
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Align(
            child: getMarker(),
          )
        ],
      ),
    );
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }
}

Widget getMarker() {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      image: const DecorationImage(
        image: AssetImage('assets/images/images.jfif'),
        fit: BoxFit.cover,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 3),
          spreadRadius: 6,
          blurRadius: 6,
        ),
      ],
    ),
  );
}
