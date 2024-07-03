import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String doctorName = '';
  String doctorEmail = '';
  int doctorId = 0;

  Future<void> patientRegister({required PatientModel patientModel}) async {
    emit(RegisterLoading());

    try {
      Map<String, dynamic> data = {
        "userName": '${patientModel.firstName}${patientModel.lastName}',
        "email": patientModel.patientEmail,
        "doctorId": patientModel.doctorId,
        "phoneNumber": patientModel.phoneNumber,
        "password": patientModel.password,
        "confirmPassword": patientModel.password,
        "firstName": patientModel.firstName,
        "lastName": patientModel.lastName,
      };

      // Ensure userName meets minimum length requirement
      if (data["userName"].length < 8) {
        data["userName"] = data["userName"]
            .padRight(8, '0'); // Padding to meet length requirement
      }

      // Log the request data
      log('Request Data: $data');

      // Make API call
      Map<String, dynamic> response = await ApiService(
              Dio(), 'http://healthcaree.runasp.net/api/AccountService')
          .add(endPoint: '/Register', data: data);

      // Log the response data
      log('Response Data: $response');

      emit(RegisterSucessful());
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          log('Dio error: ${e.response?.data}');
          // Parse the error response
          Map<String, dynamic> errorData = e.response?.data;
          String errorMessage = 'Validation errors occurred: ';
          if (errorData.containsKey('errors')) {
            Map<String, dynamic> errors = errorData['errors'];
            errors.forEach((key, value) {
              errorMessage += '\n$key: ${value.join(', ')}';
            });
          }
          emit(RegisterFailuer(errorMessage: errorMessage));
        } else {
          log('Dio error: ${e.message}');
          emit(RegisterFailuer(errorMessage: 'Dio error: ${e.message}'));
        }
      } else {
        log('Other error: ${e.toString()}');
        emit(RegisterFailuer(
            errorMessage: 'There was an error: ${e.toString()}'));
      }
    }
  }
}
