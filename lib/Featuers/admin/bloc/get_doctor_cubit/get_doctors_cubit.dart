import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';

import 'package:meta/meta.dart';

part 'get_doctors_state.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  GetDoctorsCubit() : super(GetDoctorsInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DoctorModel> allDoctors = [];

  Future<void> getAllDoctors() async {
    emit(GetDoctorsLoading());
    try {
      QuerySnapshot querySnapshot = await firestore.collection("doctors").get();
      allDoctors.clear();
      allDoctors = querySnapshot.docs
          .map((doc) => DoctorModel.fromSnapshot(doc))
          .toList();
      allDoctors.sort((a, b) => a.fristName.compareTo(b.fristName));

      emit(GetDoctorsSuccess());
    } catch (e) {
      emit(GetDoctorsFailure(errorMessage: "There was an error: $e"));
    }
  }


}
