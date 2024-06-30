import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location _location = Location();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double latitude = 0;
  double longitude = 0;
  LocationCubit() : super(LocationInitial());

  Future<void> storeLocation({required String email}) async {
    emit(LocationLoading());
  
    try {
      final bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final bool serviceEnabledResult = await _location.requestService();
        if (!serviceEnabledResult) {
          emit(LocationError("Location services are disabled."));
          return;
        }
      }

      final PermissionStatus permissionGranted =
          await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        final PermissionStatus permissionGrantedResult =
            await _location.requestPermission();
        if (permissionGrantedResult != PermissionStatus.granted) {
          emit(LocationError("Location permissions are denied."));
          return;
        }
      }

      final LocationData locationData = await _location.getLocation();
      latitude = locationData.latitude!;
      longitude = locationData.longitude!;
      final String timestamp = DateTime.now().toIso8601String();
      await _firestore.collection('locations').add({
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      });

      emit(LocationSuccess(latitude, longitude, timestamp));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
