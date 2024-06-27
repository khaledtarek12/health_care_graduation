import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
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
      // ignore: unused_local_variable
      // UserCredential user = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: doctorModel.email, password: doctorModel.password);
      // await firestore.collection('doctors').add({
      //   kFristName: doctorModel.fName,
      //   kLastName: doctorModel.lName,
      //   kEmail: doctorModel.email,
      //   kPhoneNumber: doctorModel.phoneNumber,
      //   kPassword: doctorModel.password,
      // });
      try {
        Map<String, dynamic> response =
            await ApiService(Dio(), 'http://som3a.somee.com/Api/Admin')
                .add(endPoint: '/AddDoctor', data: {
          "firstName": doctorModel.fName,
          "lastName": doctorModel.lName,
          "email": doctorModel.email,
          "userName":
              "${doctorModel.fName.toLowerCase()}${doctorModel.lName.toLowerCase()}",
          "phoneNumber": doctorModel.phoneNumber,
          "password": doctorModel.password,
          "confirmPassword": doctorModel.password,
        });
        log(response.toString());
        emit(AddDoctorSuccess());
      } catch (e) {
        emit(AddDoctorFailuer(errorMessage: e.toString()));
      }
      emit(AddDoctorSuccess());
    } catch (e) {
      emit(AddDoctorFailuer(
          errorMessage: 'There was an error + ${e.toString()}'));
    }
  }
}
