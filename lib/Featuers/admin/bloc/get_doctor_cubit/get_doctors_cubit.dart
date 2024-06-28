import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:health_care/Featuers/admin/data/model/doctor_model.module.dart';
import 'package:health_care/core/utils/api_service.dart';

import 'package:meta/meta.dart';

part 'get_doctors_state.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  GetDoctorsCubit() : super(GetDoctorsInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DoctorModel> allDoctors = [];

  Future<void> getAllDoctors() async {
    emit(GetDoctorsLoading());
    try {
      var response =
          await ApiService(Dio(), 'http://healthcaree.runasp.net/api/Doctor')
              .get(endPoint: '/GetAllDoctors');
      allDoctors.clear();
      if (response is List) {
        allDoctors.clear();
        allDoctors = response.map((item) {
          return DoctorModel.fromJson(item);
        }).toList();

        // Optionally sort the doctors by their first name
        allDoctors.sort((a, b) => a.fName.compareTo(b.fName));

        emit(GetDoctorsSuccess());
      } else {
        emit(GetDoctorsFailure(errorMessage: 'Invalid response format'));
      }
    } catch (e) {
      emit(GetDoctorsFailure(errorMessage: "There was an error: $e"));
    }
  }
}
