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
    // First, find and delete the doctor document in Firestore
    // final querySnapshot = await firestore
    //     .collection('doctors')
    //     .where(kEmail, isEqualTo: email)
    //     .get();

    // for (var doc in querySnapshot.docs) {
    //   firestore
    //       .collection('doctors')
    //       .doc(doc.id)
    //       .delete()
    //       .then((_) => emit(DeleteDoctorSuccess()))
    //       .catchError(
    //         (error) => emit(DeleteDoctorFailure(
    //             errorMessage: 'Failed to update document: $error')),
    //       );
    // }
    // User? user =
    //     // ignore: deprecated_member_use
    //     await _auth.fetchSignInMethodsForEmail(email).then((signInMethods) {
    //   if (signInMethods.isNotEmpty) {
    //     return _auth
    //         .signInWithEmailAndPassword(email: email, password: password)
    //         .then((userCredential) => userCredential.user);
    //   } else {
    //     throw FirebaseAuthException(
    //         code: 'user-not-found', message: 'User not found');
    //   }
    // });

    // if (user != null) {
    //   // Reauthenticate the user
    //   AuthCredential credential =
    //       EmailAuthProvider.credential(email: email, password: password);
    //   await user.reauthenticateWithCredential(credential);

    //   // Delete the user from Firebase Auth
    //   await user.delete();
    //   log('User deleted successfully from Firebase Auth');
    //   emit(DeleteDoctorSuccess());
    // } else {
    //   log('No user is currently signed in');
    //   emit(DeleteDoctorFailure(errorMessage: 'No user is currently signed in'));
    // }
    try {
      String endPoint = '/deleteDoctor/$userId';
      var response =
          await ApiService(Dio(), 'http://oldmate.runasp.net/api/Admin')
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
