import 'package:uuid/uuid.dart';

import './model/model.dart';

class UserRepository{
  User? _user;

  Future<User?> getUser()async{
    if(_user != null) return _user;

    return await Future.delayed(const Duration(milliseconds: 300),(){
      return _user = User(const Uuid().v4());
    });
  }
}


