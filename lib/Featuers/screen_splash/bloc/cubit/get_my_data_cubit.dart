import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:meta/meta.dart';

part 'get_my_data_state.dart';

class GetMyDataCubit extends Cubit<GetMyDataState> {
  GetMyDataCubit() : super(GetMyDataInitial());

  DoctorModel doctorData = DoctorModel(
    fName: '',
    lName: '',
    email: '',
    phoneNumber: '',
    password: '',
    userName: '',
    id: -1,
    userId: '',
  );

  PatientModel patientData = PatientModel(
    fristName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    password: '',
    userName: '',
    doctorId: 0,
  );

  final Dio dio = Dio();

  Future<void> getMyData(
      {required String email, required List<String> types}) async {
    emit(GetMyDataLoading());
    try {
      for (String type in types) {
        final Response response;
        if (type == 'Patient') {
          response =
              await dio.get('http://yourapi.com/api/patients?email=$email');
          if (response.statusCode == 200 && response.data.isNotEmpty) {
            patientData = PatientModel.fromJson(response.data);
            emit(GetMyDataSuccess());
            return;
          }
        } else if (type == 'Doctor') {
          response = await dio
              .get('http://oldmate.runasp.net/api/Doctor/GetAllDoctors');
          if (response.statusCode == 200) {
            final List doctors = response.data;
            final doctor = doctors.firstWhere(
              (doc) => doc['email'] == email,
              orElse: () => null,
            );
            if (doctor != null) {
              doctorData = DoctorModel.fromJson(doctor);
              emit(GetMyDataSuccess());
              return;
            }
          }
        } else {
          emit(GetMyDataFailure(errorMessage: "Invalid user type"));
          return;
        }
      }
      emit(GetMyDataFailure(errorMessage: "No user found with email $email"));
    } catch (e) {
      emit(GetMyDataFailure(errorMessage: "There was an error: $e"));
    }
  }
}
