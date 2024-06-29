import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailInitial());

  Future<void> sendEmail(
      {required String message, required String email}) async {
    emit(EmailLoading());
    try {
      Dio dio = Dio();
      final response = await dio.post(
        'http://healthcaree.runasp.net/api/Warning',
        data: {
          'message': message,
          'email': email,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        emit(EmailSuccess());
      } else {
        emit(EmailFailure(errorMessage: 'Failed to send email.'));
      }
    } on DioException catch (e) {
      emit(EmailFailure(errorMessage: e.toString()));
    } catch (e) {
      emit(EmailFailure(errorMessage: e.toString()));
    }
  }
}
