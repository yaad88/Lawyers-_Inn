import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_bloc_state.dart';

class PasswordBlocCubit extends Cubit<PasswordBlocState> {
  PasswordBlocCubit() : super(PasswordBlocInitial());

  PasswordBlocState checkPass(String p){
    if(p.length<3){
      emit(PasswordBlocInvalid());
    }
    else{
      emit(PasswordBlocValid());
    }
  }
}
