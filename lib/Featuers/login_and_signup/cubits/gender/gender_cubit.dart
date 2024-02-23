import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderInitial());

  selectDoctor(){
    
  }
}
