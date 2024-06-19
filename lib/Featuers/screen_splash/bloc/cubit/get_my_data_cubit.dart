import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:meta/meta.dart';

part 'get_my_data_state.dart';

class GetMyDataCubit extends Cubit<GetMyDataState> {
  GetMyDataCubit() : super(GetMyDataInitial());

  DoctorModel doctorData = DoctorModel(
      fristName: '', lastName: '', email: '', phoneNumber: '', password: '');
  PatientModel patientData = PatientModel(
      fristName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      password: '',
      doctorName: '',
      doctorEmail: '');

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getMyData({required String email, required String type}) async {
    emit(GetMyDataLoading());
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (type == 'Patient') {
        querySnapshot = await firestore
            .collection('patients')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          patientData = PatientModel.fromSnapshot(querySnapshot.docs.first);
          print(patientData.toString());
          print('khaled1');
          emit(GetMyDataSuccess());
        } else {
          emit(GetMyDataFailure(
              errorMessage: "No patient found with email $email"));
        }
      } else if (type == 'Doctor') {
        querySnapshot = await firestore
            .collection('doctors')
            .where('email', isEqualTo: email)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          doctorData = DoctorModel.fromSnapshot(querySnapshot.docs.first);
          print(doctorData.toString());
          print('khaled');
          emit(GetMyDataSuccess());
        } else {
          emit(GetMyDataFailure(
              errorMessage: "No doctor found with email $email"));
        }
      }
    } catch (e) {
      emit(GetMyDataFailure(errorMessage: "There was an error: $e"));
    }
  }
}
