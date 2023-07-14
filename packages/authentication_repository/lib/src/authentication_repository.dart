

import 'dart:async';

enum AuthenticationStatus{unKnown,unAuthenticated,authenticated}


class AuthenticationRepository{
  final _authenticationController = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async*{
    await Future.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unAuthenticated;
    yield* _authenticationController.stream;
  }


  Future<void> logIn({required String username,required String password})async{
    await Future.delayed(const Duration(milliseconds: 300),()=> _authenticationController.add(AuthenticationStatus.authenticated));
  }

  void logOut()=> _authenticationController.add(AuthenticationStatus.unAuthenticated);

  void dispose () => _authenticationController.close();

}