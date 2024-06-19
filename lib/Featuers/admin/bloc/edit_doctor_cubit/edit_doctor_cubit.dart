import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/const.dart';
import 'package:meta/meta.dart';

part 'edit_doctor_state.dart';

class EditDoctorCubit extends Cubit<EditDoctorState> {
  EditDoctorCubit() : super(EditDoctorInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void editDoctor(
      {required String oldEmail, required DoctorModel newDoctor}) async {
    emit(EditDoctorLoading());
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where(kEmail, isEqualTo: oldEmail)
          .get();

      for (var doc in querySnapshot.docs) {
        firestore
            .collection('doctors')
            .doc(doc.id)
            .update({
              kFristName: newDoctor.fristName,
              kLastName: newDoctor.lastName,
              kEmail: newDoctor.email,
              kPhoneNumber: newDoctor.phoneNumber,
              kPassword: newDoctor.password,
            })
            .then((_) => emit(EditDoctorSucess()))
            .catchError(
              (error) => emit(EditDoctorFailure(
                  errorMessage: 'Failed to update document: $error')),
            );
      }
    } catch (e) {
      emit(EditDoctorFailure(errorMessage: e.toString()));
    }
  }
}
