// ignore_for_file: unnecessary_getters_setters

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/account_model.dart';
import '../../utility/account_api.dart';

class LoginProvider with ChangeNotifier {
  int _id = 0;
  String _nama = '';
  String _email = '';
  String _noWa = '';
  String _image = '';
  bool _isLoggedin = false;
  String _msg = "";
  List<AccountModel> _list = [];

  int get id => _id;
  String get nama => _nama;
  String get email => _email;
  String get noWa => _noWa;
  String get image => _image;
  bool get isLoggedin => _isLoggedin;
  String get msg => _msg;
  List<AccountModel> get list => _list;

  set id(int value) {
    _id = value;
  }

  set nama(String value) {
    _nama = value;
  }

  set email(String value) {
    _email = value;
  }

  set noWa(String value) {
    _noWa = value;
  }

  set image(String value) {
    _image = value;
  }

  set isLoggedin(bool value) {
    _isLoggedin = value;
  }

  set list(List<AccountModel> value) {
    _list = value;
  }

  Future<List<AccountModel>> loadData() async {
    Future<List<AccountModel>> akun = AccountApi.getUsers();
    list = await akun;
    notifyListeners();
    return akun;
  }

  loginAuth({
    required String username,
    required String password,
  }) {
    for (var user in _list) {
      //AccountModel user;

      try {
        user = _list.firstWhere((element) => element.username == username);
      } catch (e) {
        _msg = "User tidak ditemukan";
        print(e.toString());
        notifyListeners();
        return;
      }

      if (user.password != password) {
        _msg = "Password Salah";
        notifyListeners();
        return;
      }
      _msg = "default";
      notifyListeners();
      return;
    }
  }

  void setLogin() {
    isLoggedin = !isLoggedin;
  }

  //Fungsi saveData digunakan untuk menyimpan data pada shared preferences secara lokal
  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('id', id);
    await pref.setString('nama', nama);
    await pref.setString('email', email);
    await pref.setString('noWa', noWa);
    await pref.setString('image', image);
    await pref.setBool('isLoggedin', isLoggedin);
  }

// if (username.compareTo(user.username) != 0) {
//         _msg = "User tidak ditemukan";
//         notifyListeners();
//         return;
//       } else if (password.compareTo(user.password) != 0) {
//         _msg = "Password Salah";
//         notifyListeners();
//         return;
//       } else {
//         _msg = "default";
//         notifyListeners();
//         return;
//       }
}
