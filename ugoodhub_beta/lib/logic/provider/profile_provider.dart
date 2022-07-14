import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String _nama = '';
  String _email = '';
  String _noWa = '';
  String _image = '';

  String get nama => _nama;
  String get email => _email;
  String get noWa => _noWa;
  String get image => _image;

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

  void setProfile(String? nam, String? eml, String? img, String? no) {
    _nama = nam ?? "default";
    _email = eml ?? "default";
    _image = img ?? "assets/images/emptyAvatar.png";
    _noWa = no ?? "default";
    saveData();
    notifyListeners();
    return;
  }

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('nama', _nama);
    await pref.setString('email', _email);
    await pref.setString('noWa', _noWa);
    await pref.setString('image', _image);
  }
  // loadData() async {
  //   Future<List<AccountModel>> akun = AccountApi.getUsers();
  //   list = await akun;
  //   notifyListeners();
  // }
}
