import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/core/widgets/custom_container.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition? cameraPosition;

  @override
  void initState() {
    cameraPosition = const CameraPosition(
      target: LatLng(11.576262, 104.92222),
      zoom: 14,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: GoogleMap(
          initialCameraPosition: cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!googleMapController.isCompleted) {
              googleMapController.complete(controller);
            }
          },
        ));
  }
}
