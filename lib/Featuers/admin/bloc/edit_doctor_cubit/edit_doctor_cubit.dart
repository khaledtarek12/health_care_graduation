import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/core/utils/api_service.dart';
import 'package:meta/meta.dart';

part 'edit_doctor_state.dart';

class EditDoctorCubit extends Cubit<EditDoctorState> {
  EditDoctorCubit() : super(EditDoctorInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void editDoctor(
      {required String userId,
      required DoctorModel newDoctor,
      required String password,
      required String email}) async {
    emit(EditDoctorLoading());
    try {
      Map<String, dynamic> data = {
        'firstName': newDoctor.fName,
        'lastName': newDoctor.lName,
        'userName': newDoctor.userName,
        'email': newDoctor.email,
        'phoneNumber': newDoctor.phoneNumber,
        'password': newDoctor.password,
        'confirmPassword': newDoctor.password,
      };
      String endPoint = '/EditDoctor/$userId';
      var response =
          await ApiService(Dio(), 'http://healthcaree.runasp.net/api/Admin')
              .edit(endPoint: endPoint, data: data);
      log("response: $response and userid: $userId and id: ${newDoctor.id}");

      if (response is Map<String, dynamic>) {
        emit(EditDoctorSucess());
      } else {
        emit(EditDoctorFailure(errorMessage: response['errors']));
      }
    } catch (e) {
      emit(EditDoctorFailure(errorMessage: e.toString()));
      log(e.toString());
    }
  }
}
