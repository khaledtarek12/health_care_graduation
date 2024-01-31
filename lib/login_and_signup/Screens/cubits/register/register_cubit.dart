import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> userRegister(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSucessful());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(Registerailuer(errorMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(Registerailuer(errorMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(Registerailuer(errorMessage: 'There was an error'));
    }
  }
}
