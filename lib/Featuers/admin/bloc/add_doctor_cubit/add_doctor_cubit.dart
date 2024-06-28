import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit() : super(AddDoctorInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> doctorRegister({required DoctorModel doctorModel}) async {
    emit(AddDoctorLoading());
    try {
      Map<String, dynamic> data = {
        "firstName": doctorModel.fName,
        "lastName": doctorModel.lName,
        "email": doctorModel.email,
        "userName":
            "${doctorModel.fName.toLowerCase()}${doctorModel.lName.toLowerCase()}",
        "phoneNumber": doctorModel.phoneNumber,
        "password": doctorModel.password,
        "confirmPassword": doctorModel.password,
      };

      // Log the request data
      log('Request Data: $data');

      // Make API call
      Map<String, dynamic> response =
          await ApiService(Dio(), 'http://healthcaree.runasp.net/api/Admin')
              .add(endPoint: '/AddDoctor', data: data);

      // Log the response data
      log('Response Data: $response');

      emit(AddDoctorSuccess());
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
          emit(AddDoctorFailuer(errorMessage: errorMessage));
        } else {
          log('Dio error: ${e.message}');
          emit(AddDoctorFailuer(errorMessage: 'Dio error: ${e.message}'));
        }
      } else {
        log('Other error: ${e.toString()}');
        emit(AddDoctorFailuer(
            errorMessage: 'There was an error: ${e.toString()}'));
      }
    }
  }
}
