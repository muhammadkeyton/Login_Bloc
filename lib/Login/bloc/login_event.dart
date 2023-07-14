

part of './login_bloc.dart';

sealed class LoginEvent extends Equatable{
  const LoginEvent();


  @override
  List<Object> get props => [];
}


final class LoginUsernameChanged extends LoginEvent{
  const LoginUsernameChanged(this.username);
  final String username;
}

final class LoginPasswordChanged extends LoginEvent{
  const LoginPasswordChanged(this.password);
  final String password;
}

final class LoginSubmitted extends LoginEvent{}