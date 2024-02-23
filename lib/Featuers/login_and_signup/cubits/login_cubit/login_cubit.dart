import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
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
}
