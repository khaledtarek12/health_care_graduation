import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/const.dart';
import 'package:meta/meta.dart';

part 'delete_doctor_state.dart';

class DeleteDoctorCubit extends Cubit<DeleteDoctorState> {
  DeleteDoctorCubit() : super(DeleteDoctorInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void deleteDoctor(
      {required String email}) async {
    emit(DeleteDoctorLoading());
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where(kEmail, isEqualTo: email)
          .get();

      for (var doc in querySnapshot.docs) {
        firestore
            .collection('doctors')
            .doc(doc.id)
            .delete()
            .then((_) => emit(DeleteDoctorSuccess()))
            .catchError(
              (error) => emit(DeleteDoctorFailure(
                  errorMessage: 'Failed to update document: $error')),
            );
      }
    } catch (e) {
      emit(DeleteDoctorFailure(errorMessage: e.toString()));
    }
  }
}
