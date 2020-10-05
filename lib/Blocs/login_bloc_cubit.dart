import 'package:bloc/bloc.dart';
//import 'package:equatable/equatable.dart';
import 'package:new_new_bloc/Apis/login_api.dart';

part 'login_bloc_state.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {
  LoginBlocCubit() : super(LoginBlocInitial());

  Future<LoginBlocState> getToken(String e, String p) async{
    emit(LoginBlocLoading());
    String t = await userLogin(e, p);
    print(t);
    if(t==null){
      emit(LoginBlocFailed()) ;
    }
    else{
      emit(LoginBlocSuccess()) ;
    }

  }

}
