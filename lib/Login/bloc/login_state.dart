

part of './login_bloc.dart';

final class LoginState extends Equatable{
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.password = const Password.pure(),
    this.username = const Username.pure()
  });

  final FormzSubmissionStatus status;
  final bool isValid;
  final Password password;
  final Username username;


  LoginState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    Password? password,
    Username? username
  }){
    return LoginState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      password: password ?? this.password,
      username: username ?? this.username
    );
  }


  @override
  List<Object> get props => [status,password,username];
}