// ignore_for_file: unnecessary_getters_setters

import "package:flutter/material.dart";
import '../../model/account_model.dart';
import '../../utility/account_api.dart';

class LoginProvider with ChangeNotifier {
  String _msg = "";
  List<AccountModel> _list = [];

  String get msg => _msg;

  List<AccountModel> get list => _list;

  set list(List<AccountModel> value) {
    _list = value;
  }

  Future<List<AccountModel>> loadData() async {
    Future<List<AccountModel>> akun = AccountApi.getUsers();
    list = await akun;
    notifyListeners();
    return akun;
  }

  String loginAuth({
    required String username,
    required String password,
  }) {
    for (var user in _list) {
      if (username.compareTo(user.username) == 0) {
        _msg = "Email tidak terdaftar";
        notifyListeners();
        //buat nge test
        print(list);
        break;
      } else if (password.compareTo(user.password) == 0) {
        _msg = "password salah";
        notifyListeners();
        //buat ngetest
        print('password salah');
        break;
      } else {
        _msg = "success";
        notifyListeners();
        //buat ngetest
        print('success');
        break;
      }
    }
    return _msg;
  }
}
