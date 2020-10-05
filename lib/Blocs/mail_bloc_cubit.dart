import 'package:bloc/bloc.dart';
//import 'package:equatable/equatable.dart';

part 'mail_bloc_state.dart';

class MailBlocCubit extends Cubit<MailBlocState> {
  MailBlocCubit() : super(MailBlocInitial());

  MailBlocState checkMail(String e){
    //print(e);
    if(e.length<3){
      emit(MailBlocInvalid());
    }
    else{
      emit(MailBlocValid());
    }
  }
}
