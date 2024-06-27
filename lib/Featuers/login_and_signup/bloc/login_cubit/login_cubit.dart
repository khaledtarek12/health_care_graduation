import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  late SharedPreferences prefs;
  String email = '';

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      prefs = await SharedPreferences.getInstance();

      // Attempt to login using the HTTP API with Dio
      Dio dio = Dio();
      final response = await dio.post(
        'http://som3a.somee.com/api/AccountService/Login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        final responseBody = response.data;
        final roles = List<String>.from(responseBody['roles']);
        await prefs.setString('email', email);
        await prefs.setStringList('roles', roles);
        emit(LoginSucessful());
      } else if (response.statusCode == 400) {
        final responseBody = response.data;
        emit(LoginFailuer(
            errorMessage: responseBody['errors'] ?? 'Invalid request data'));
      } else {
        emit(LoginFailuer(
            errorMessage:
                'Login failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}, Headers: ${e.response?.headers}');
        try {
          emit(LoginFailuer(
              errorMessage: e.response?.data['errors'] ?? 'Login failed'));
        } catch (parsingError) {
          log('Error parsing response data: $parsingError');
          emit(LoginFailuer(errorMessage: 'Login failed'));
        }
      } else {
        log('Dio error! Message: ${e.message}, Error: ${e.error}');
        emit(LoginFailuer(errorMessage: 'There was an error'));
      }
    } catch (e) {
      log('Unexpected error: $e $ResponseBody');
      emit(LoginFailuer(errorMessage: 'There was an error'));
    }
  }

  getEmail() async {
    try {
      prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email') ?? '';
    } catch (e) {
      log(e.toString());
    }
    return email;
  }

  Future<void> deleteEmail() async {
    try {
      prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
    } catch (e) {
      log(e.toString());
    }
  }
}
