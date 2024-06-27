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
    // final querySnapshot = await FirebaseFirestore.instance
    //     .collection('doctors')
    //     .where(kEmail, isEqualTo: oldEmail)
    //     .get();

    // for (var doc in querySnapshot.docs) {
    //   firestore
    //       .collection('doctors')
    //       .doc(doc.id)
    //       .update({
    //         kFristName: newDoctor.fName,
    //         kLastName: newDoctor.lName,
    //         kEmail: newDoctor.email,
    //         kPhoneNumber: newDoctor.phoneNumber,
    //         kPassword: newDoctor.password,
    //       })
    //       .then((_) => emit(EditDoctorSucess()))
    //       .catchError(
    //         (error) => emit(EditDoctorFailure(
    //             errorMessage: 'Failed to update document: $error')),
    //       );
    // }
    // try {
    //   User? user = _auth.currentUser;

    //   if (user != null) {
    //     // Re-authenticate user
    //     AuthCredential credential =
    //         EmailAuthProvider.credential(email: email, password: password);
    //     await user.reauthenticateWithCredential(credential);

    //     // Update email address
    //     // ignore: deprecated_member_use
    //     await user.updateEmail(newDoctor.email);

    //     log('Email updated successfully');
    //   } else {
    //     log('No user currently signed in.');
    //     // Handle scenario where no user is signed in
    //   }
    // } catch (e) {
    //   log('Failed to update email: $e');
    //   // Handle error (e.g., display error to user)
    // }
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
      var response = await ApiService(Dio(), 'http://som3a.somee.com/Api/Admin')
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
