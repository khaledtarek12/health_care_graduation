import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Featuers/login_and_signup/data/models/patient_model.module.dart';
import 'package:health_care/const.dart';
import 'package:meta/meta.dart';

part 'get_patient_state.dart';

class GetPatientsCubit extends Cubit<GetPatientsState> {
  GetPatientsCubit() : super(GetPatientsInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<PatientModel> allPatient = [];

  Future<void> getAllPatients({required Object email}) async {
    emit(GetPatientsLoading());
    try {
      final querySnapshot = await firestore
          .collection('patients')
          .where(email, isEqualTo: kDcotorEmail)
          .get();

      allPatient.clear();
      allPatient = querySnapshot.docs
          .map((doc) => PatientModel.fromSnapshot(doc))
          .toList();
      allPatient.sort((a, b) => a.fristName.compareTo(b.fristName));
      emit(GetPatientsSuccess());
    } catch (e) {
      emit(GetPatientsFailure(errorMessage: "There was an error: $e"));
    }
  }
}
