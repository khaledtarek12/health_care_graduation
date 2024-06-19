import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/const.dart';
import 'package:meta/meta.dart';

part 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit() : super(AddDoctorInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> doctorRegister({required DoctorModel doctorModel}) async {
    emit(AddDoctorLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: doctorModel.email, password: doctorModel.password);
      await firestore.collection('doctors').add({
        kFristName: doctorModel.fristName,
        kLastName: doctorModel.lastName,
        kEmail: doctorModel.email,
        kPhoneNumber: doctorModel.phoneNumber,
        kPassword: doctorModel.password,
      });
      emit(AddDoctorSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AddDoctorFailuer(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(AddDoctorFailuer(errorMessage: 'Email already in use'));
      }
    } catch (e) {
      emit(AddDoctorFailuer(
          errorMessage: 'There was an error + ${e.toString()}'));
    }
  }
}
