
part of './authentication_bloc.dart';

class AuthenticationState extends Equatable{

  final User user;
  final AuthenticationStatus status;

  const AuthenticationState._({
    this.user = User.empty,
    this.status = AuthenticationStatus.unKnown
  });

  const AuthenticationState.unKnown(): this._();

  const AuthenticationState.authenticated(User user): this._(status: AuthenticationStatus.authenticated,user: user);

  const AuthenticationState.unAuthenticated():this._(status: AuthenticationStatus.unAuthenticated,user: User.empty);
  
  @override
  List<Object> get props => [user,status];
}