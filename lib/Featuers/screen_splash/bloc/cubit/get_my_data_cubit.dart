import 'dart:developer';

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
    lastName: '',
    patientEmail: '',
    phoneNumber: '',
    password: '',
    userName: '',
    doctorId: 0,
    userId: '',
    firstName: '',
  );

  final Dio dio = Dio();
  Future<void> getMyData(
      {required String email, required List<String> types}) async {
    emit(GetMyDataLoading());
    try {
      for (String type in types) {
        final Response response;
        if (type == 'Patient') {
          response = await dio
              .get('http://healthcaree.runasp.net/api/Patient/GetAllPatient');
          if (response.statusCode == 200) {
            log(response.data.toString());
            final List patients = response.data;
            final patient = patients.firstWhere(
              (pat) => pat['patientEmail'] == email,
              orElse: () => null,
            );
            if (patient != null) {
              patientData = PatientModel.fromJson(patient);
              emit(GetMyDataSuccess());
            } else {
              emit(GetMyDataFailure(errorMessage: 'Patient not found'));
            }
          } else {
            emit(GetMyDataFailure(errorMessage: 'Failed to fetch patients'));
          }
        } else if (type == 'Doctor') {
          response = await dio
              .get('http://healthcaree.runasp.net/api/Doctor/GetAllDoctors');

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
      emit(GetMyDataFailure(errorMessage: "No user found with userId "));
    } catch (e) {
      emit(GetMyDataFailure(errorMessage: "There was an error: $e"));
    }
  }
}
