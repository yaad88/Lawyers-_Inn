part of 'login_bloc_cubit.dart';

abstract class LoginBlocState  {
  const LoginBlocState();
}

class LoginBlocInitial extends LoginBlocState {
  @override
  List<Object> get props => [];
}

class LoginBlocFailed extends LoginBlocState{

}

class LoginBlocSuccess extends LoginBlocState{

}

class LoginBlocLoading extends LoginBlocState{}
