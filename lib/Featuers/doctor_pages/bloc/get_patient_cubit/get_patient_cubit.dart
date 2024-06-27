import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:meta/meta.dart';

part 'get_patient_state.dart';

class GetPatientsCubit extends Cubit<GetPatientsState> {
  GetPatientsCubit() : super(GetPatientsInitial());

  List<PatientModel> allPatients = [];
  final Dio dio = Dio();

  Future<void> getAllPatients({required String doctorId}) async {
    emit(GetPatientsLoading());
    try {
      final responsePatients =
          await dio.get('http://som3a.somee.com/api/Patient/GetAllPatient');
      final responseDoctors =
          await dio.get('http://som3a.somee.com/api/Doctor/GetAllDoctors');

      if (responsePatients.statusCode == 200 &&
          responseDoctors.statusCode == 200) {
        final List patients = responsePatients.data;
        final List doctors = responseDoctors.data;

        allPatients.clear();
        // allPatients = patients
        //     .map((patient) => PatientModel.fromJson(patient))
        //     .where((patient) => doctors.any((doctor) =>
        //         doctor['id'] == doctorId && doctor['id'] == patient.doctorId))
        //     .toList();

        // allPatients.sort((a, b) => a.fristName.compareTo(b.fristName));
        emit(GetPatientsSuccess());
      } else {
        emit(GetPatientsFailure(
            errorMessage: "Failed to load patients or doctors"));
      }
    } catch (e) {
      emit(GetPatientsFailure(errorMessage: "There was an error: $e"));
    }
  }
}
