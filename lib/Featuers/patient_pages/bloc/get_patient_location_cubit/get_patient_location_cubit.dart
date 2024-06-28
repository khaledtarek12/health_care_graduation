import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'get_patient_location_state.dart';

class GetPatientLocationCubit extends Cubit<GetPatientLocationState> {
  final _firestore = FirebaseFirestore.instance;

  double latitude = 0;
  double longitude = 0;
  String timestamp = '';

  GetPatientLocationCubit() : super(GetPatientLocationInitial());

  Future<void> fetchPatientLocation(String patientEmail) async {
    try {
      emit(GetPatientLocationLoading());

      // Fetch the last known location for the patient from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('locations')
          .where('email', isEqualTo: patientEmail)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract the location data from Firestore
        var locationData = querySnapshot.docs.first.data();

        if (locationData is Map<String, dynamic>) {
          // Ensure the data is of the expected type
          latitude = locationData['latitude'];
          longitude = locationData['longitude'];
          timestamp = locationData['timestamp'];

          emit(GetPatientLocationSuccess(latitude, longitude, timestamp));
        } else {
          emit(
              GetPatientLocationFailure('Invalid data format from Firestore.'));
        }
      } else {
        emit(GetPatientLocationFailure('No location found for the patient.'));
      }
    } catch (e) {
      emit(GetPatientLocationFailure('Failed to fetch location: $e'));
    }
  }
}