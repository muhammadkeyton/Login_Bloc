import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

part './authentication_event.dart';
part './authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription _authenticationSubscription;

  AuthenticationBloc({required AuthenticationRepository authenticationRepository,required UserRepository userRepository})
  :_userRepository=userRepository,_authenticationRepository=authenticationRepository,
  super(const AuthenticationState.unKnown()){
    _authenticationSubscription = _authenticationRepository.status.listen((status) {
      add(_AuthenticationStatusChanged(status));
      });

    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }


  @override
  Future<void> close() {
    _authenticationSubscription.cancel();
    return super.close();
  }


  Future<void> _onAuthenticationStatusChanged(_AuthenticationStatusChanged event,Emitter<AuthenticationState>emit)async{
    switch (event.status) {
      case AuthenticationStatus.unKnown:
       emit(const AuthenticationState.unKnown());
        
      case AuthenticationStatus.authenticated:
       final user = await _getUser();
       emit(AuthenticationState.authenticated(user));

      case AuthenticationStatus.unAuthenticated:
      emit(const AuthenticationState.unAuthenticated());
      
    }
  }

  void _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event,Emitter<AuthenticationState>emit){
    _authenticationRepository.logOut();
    emit(const AuthenticationState.unAuthenticated());
  }


  Future _getUser() async{
    try{
      return await _userRepository.getUser();
    }catch(_){
      return null;
    }
  }



}