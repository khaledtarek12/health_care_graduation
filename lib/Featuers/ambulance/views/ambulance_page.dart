import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/widgets/circle_loading.dart';
import 'package:intl/intl.dart';
import 'package:health_care/core/helper/show_snackbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:health_care/Featuers/patient_pages/bloc/get_patient_location_cubit/get_patient_location_cubit.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({super.key});

  static const id = 'AmbulancePage';

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  late GoogleMapController _mapController;
  bool isLoading = false;
  double zoom = 16;
  int currentIndex = 0;
  List<Marker> markersList = [];

  @override
  void initState() {
    super.initState();
    fetchAllPatientsLocations();
  }

  void fetchAllPatientsLocations() {
    BlocProvider.of<GetPatientLocationCubit>(context)
        .fetchAllPatientsLatestLocations();
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
          showErrorDialog(
              context: context, message: 'Oops , there was an error');
        } else if (state is GetAllPatientsLocationsSuccess) {
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        if (state is GetAllPatientsLocationsSuccess) {
          final Map<String, Map<String, dynamic>> latestLocations =
              state.latestLocations;
          Set<Marker> markers = latestLocations.entries.map((entry) {
            String email = entry.key;
            Map<String, dynamic> data = entry.value;
            String formattedTimestamp = _formatTimestamp(data['timestamp']);
            return Marker(
              markerId: MarkerId(email),
              position: LatLng(data['latitude'], data['longitude']),
              infoWindow: InfoWindow(
                title: email,
                snippet: 'Last updated: $formattedTimestamp',
              ),
            );
          }).toSet();

          markersList = markers.toList();

          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: markers.isNotEmpty
                          ? markers.first.position
                          : const LatLng(0, 0),
                      zoom: zoom,
                    ),
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController.complete(controller);
                      _mapController = controller;
                    },
                    markers: markers,
                  ),
                  Positioned(
                    bottom: 50,
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
                        const SizedBox(height: 8.0),
                        FloatingActionButton(
                          key: UniqueKey(),
                          heroTag: 'btn 3',
                          onPressed: _nextLocation,
                          child: const Icon(Icons.navigation),
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
              child: CircleLoading(),
            ),
          );
        }
      },
    );
  }

  String _formatTimestamp(String timestamp) {
    final DateTime dateTime = DateTime.parse(timestamp);
    final DateFormat formatter = DateFormat('yyyy-MM-dd h:mm a');
    return formatter.format(dateTime);
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void _nextLocation() {
    if (markersList.isEmpty) return;
    currentIndex = (currentIndex + 1) % markersList.length;
    _mapController.animateCamera(
      CameraUpdate.newLatLng(markersList[currentIndex].position),
    );
  }
}
