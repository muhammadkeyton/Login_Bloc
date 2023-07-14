import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../view/login_view.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route(){
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to your account'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: BlocProvider(
          create: (_) => LoginBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const LoginView()
        ),
      ),
    );
  }
}