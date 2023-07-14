import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../Authentication/authentication.dart";


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route(){
    return MaterialPageRoute(builder: (_)=> const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final name = context.select((AuthenticationBloc bloc) => bloc.state.user.id);
    return Scaffold(
      appBar: AppBar(title: Text('Home'),centerTitle: true,),
      body:Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('user:$name'),
          const SizedBox(height:25),
          ElevatedButton(onPressed: (){
            context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
          },
          child: const Text('Logout'),
          )

        ],
      ),)
    );
  }
}