import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:health_care/const.dart';
import 'package:health_care/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'delete_doctor_state.dart';

class DeleteDoctorCubit extends Cubit<DeleteDoctorState> {
  DeleteDoctorCubit() : super(DeleteDoctorInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void deleteDoctor(
      {required String userId,
      required String email,
      required String password}) async {
    emit(DeleteDoctorLoading());
    try {
      String endPoint = '/DeleteDoctor/$userId';
      var response =
          await ApiService(Dio(), 'http://som3a.somee.com/Api/Admin')
              .delete(endPoint: endPoint);

      // Log the response to understand its structure
      log('API Response: $response and id: $userId');

      if (response is Map<String, dynamic> && response['status'] == 'success') {
        log('Doctor deleted successfully from API');
        // Proceed to delete the user from Firebase Auth
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        emit(DeleteDoctorFailure(errorMessage: 'Doctor not found'));
      } else {
        emit(DeleteDoctorFailure(errorMessage: e.toString()));
      }
    }
  }
}
