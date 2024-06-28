import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      Dio dio = Dio();
      final response = await dio.post(
        'http://healthcaree.runasp.net/api/AccountService/ForgetPassword',
        data: {'email': email},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        emit(ForgetPasswordSuccess());
      } else if (response.statusCode == 400) {
        final responseBody = response.data;
        emit(ForgetPasswordFailure(
            errorMessage: responseBody['errors'] ?? 'Invalid request data'));
      } else {
        emit(ForgetPasswordFailure(
            errorMessage:
                'Request failed with status code: ${response.statusCode}'));
      }
    } catch (e) {
      log('Error: $e');
      emit(ForgetPasswordFailure(errorMessage: 'There was an error'));
    }
  }
}
