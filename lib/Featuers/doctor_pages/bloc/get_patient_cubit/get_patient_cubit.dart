import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:meta/meta.dart';

part 'get_patient_state.dart';

class GetPatientsCubit extends Cubit<GetPatientsState> {
  GetPatientsCubit() : super(GetPatientsInitial());

  List<PatientModel> allPatients = [];
  final Dio dio = Dio();

  Future<void> getAllPatients({required String doctorEmail}) async {
    emit(GetPatientsLoading());
    try {
      final response = await dio.get(
        'http://healthcaree.runasp.net/api/Patient/GetAllPatient',
      );

      if (response.statusCode == 200) {
        final List patients = response.data;

        // Filter patients based on the doctor's email
        final filteredPatients =
            patients.where((pat) => pat['email'] == doctorEmail).toList();

        if (filteredPatients.isEmpty) {
          return;
        }

        if (filteredPatients.isNotEmpty) {
          allPatients = filteredPatients.map((item) {
            return PatientModel.fromJson(item);
          }).toList();

          // Optionally sort the patients by their first name
          allPatients.sort((a, b) => a.firstName.compareTo(b.firstName));
          emit(GetPatientsSuccess());
        } else {
          emit(GetPatientsFailure(
              errorMessage: 'No patients found for this doctor'));
        }
      } else {
        emit(GetPatientsFailure(errorMessage: 'Failed to fetch patients'));
      }
    } catch (e) {
      emit(GetPatientsFailure(errorMessage: "There was an error: $e"));
    }
  }
}
