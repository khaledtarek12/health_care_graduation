import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  late SharedPreferences prefs;
  String email = '';
  Future<void> loginUser(
      {required String email,
      required String password,
      required String type}) async {
    emit(LoginLoading());
    try {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('type', type);

      await prefs.setString('email', email);
      var auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSucessful());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailuer(errorMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailuer(errorMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailuer(errorMessage: 'There was an error'));
    }
  }

  getEmail() async {
    try {
      prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email')!;
    } catch (e) {
      log(e.toString());
    }
  }

  deleteEmail() async {
    try {
      prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
    } catch (e) {
      log(e.toString());
    }
  }
}
