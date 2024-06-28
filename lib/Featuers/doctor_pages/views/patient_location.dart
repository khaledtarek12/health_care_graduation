import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:health_care/Featuers/patient_pages/bloc/get_patient_location_cubit/get_patient_location_cubit.dart';

class PatientLocationPage extends StatefulWidget {
  const PatientLocationPage({super.key, required this.patientEmail});

  final String patientEmail;

  @override
  State<PatientLocationPage> createState() => _PatientLocationPageState();
}

class _PatientLocationPageState extends State<PatientLocationPage> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  late GoogleMapController _mapController;
  bool isLoading = false;
  double zoom = 19;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    fetchPatientLocation();
  }

  void fetchPatientLocation() {
    BlocProvider.of<GetPatientLocationCubit>(context)
        .fetchPatientLocation(widget.patientEmail);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPatientLocationCubit, GetPatientLocationState>(
      listener: (context, state) {
        if (state is GetPatientLocationLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is GetPatientLocationFailure) {
          setState(() {
            isLoading = false;
          });
          showErrorDialog(context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is GetPatientLocationSuccess) {
          final double latitude = state.latitude;
          final double longitude = state.longitude;
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: zoom,
                    ),
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController.complete(controller);
                      _mapController = controller;
                    },
                    markers: {
                      Marker(
                        infoWindow: InfoWindow(
                          title: 'patient_location',
                          onTap: () {
                            zoom = 24;
                          },
                        ),
                        markerId: const MarkerId('patient_location'),
                        position: LatLng(latitude, longitude),
                      ),
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
                ],
              ),
            ),
          );
        } else {
          // Handle initial loading state or other states if needed
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }
}
