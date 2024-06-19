import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/const.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String doctorName = '';
  String doctorEmail = '';

  Future<void> patientRegister({required PatientModel patientModel}) async {
    emit(RegisterLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: patientModel.email, password: patientModel.password);
      await firestore.collection('patients').add({
        kFristName: patientModel.fristName,
        kLastName: patientModel.lastName,
        kEmail: patientModel.email,
        kPhoneNumber: patientModel.phoneNumber,
        kPassword: patientModel.password,
        kDcotorName: patientModel.doctorName,
        kDcotorEmail: patientModel.doctorEmail,
      });

      emit(RegisterSucessful());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailuer(errorMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailuer(errorMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailuer(
          errorMessage: 'There was an error + ${e.toString()}'));
    }
  }
}
