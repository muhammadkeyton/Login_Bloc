import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../bloc/login_bloc.dart';



class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(
      listener: (context,state){
        if(state.status.isSuccess){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('successfully logged in!')));
        }
      },
      child: Column(
        children: [
          _UsernameInput(key: UniqueKey(),),
          const SizedBox(height: 5,),
          _PasswordInput(key:UniqueKey()),
          const SizedBox(height: 15,),
          _LoginButton(key: UniqueKey(),)
        ],
      )
      
    );
  }
}


class _UsernameInput extends StatelessWidget {
  const _UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      buildWhen: (prevState,currentState)=> prevState.username != currentState.username,
      builder: (context,state){
        return TextField(
          key: const Key('username-textfield'),
          onChanged: (username){
            context.read<LoginBloc>().add(LoginUsernameChanged(username));
          },
          decoration: InputDecoration(
            label: const Text('username'),
            errorText: state.username.displayError != null? 'username cannot be empty':null
          ),
        );
      }
    );
  }
}


class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      buildWhen: (prevState,currentState)=> prevState.password != currentState.password,
      builder: (context,state){
        return TextField(
          key: const Key('password-textfield'),
          onChanged: (password){
            context.read<LoginBloc>().add(LoginPasswordChanged(password));
          },
          decoration: InputDecoration(
            label: const Text('password'),
            errorText: state.password.displayError != null? 'password cannot be empty':null
          ),
        );
      }
    );
  }
}


class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      builder: (context,state){
        switch (state.status) {
          case FormzSubmissionStatus.inProgress:
           return const CircularProgressIndicator();

          default:
           return ElevatedButton(
            onPressed: state.isValid?(){context.read<LoginBloc>().add(LoginSubmitted());}:null,
            child: const Text('Login'),);
           
        }
      }
    );
  }
}



