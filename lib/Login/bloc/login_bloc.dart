import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';


import '../models/models.dart';


part './login_event.dart';
part './login_state.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc({required AuthenticationRepository authenticationRepository})
  :_authenticationRepository = authenticationRepository,
  super(const LoginState()){
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;
 

  void _onLoginUsernameChanged(LoginUsernameChanged event,Emitter<LoginState>emit){
    final username = Username.dirty(value:event.username);
    emit(
      state.copyWith(
        username:username,
        isValid: Formz.validate([state.password,username])
      )
    );
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event,Emitter<LoginState>emit){
    final password = Password.dirty(value:event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.username,password])
      )
    );
  }


  Future<void> _onLoginSubmitted(LoginSubmitted event,Emitter<LoginState>emit)async{
  
    if(state.isValid){
      emit(state.copyWith(status:FormzSubmissionStatus.inProgress));
      try{
        await _authenticationRepository.logIn(username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }catch(_){
        emit(state.copyWith(status:FormzSubmissionStatus.failure));
      }
    }

  }




}

