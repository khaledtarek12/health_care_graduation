import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final Dio dio = Dio();
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    try {
      final response = await dio.post(
        'http://som3a.somee.com/api/AccountService/reset-password',
        data: {
          'email': email,
          'token': token,
          'password': newPassword,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        emit(ResetPasswordSuccess());
      } else {
        log(response.data['errors']);
        emit(ResetPasswordFailure(
          errorMessage: 'Failed to reset password. Please try again.',
        ));
      }
    } catch (e) {
      emit(ResetPasswordFailure(
        errorMessage: 'Error: $e',
      ));
    }
  }
}
