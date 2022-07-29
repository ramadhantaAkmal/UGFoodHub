import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String _nama = '';
  String _email = '';
  String _noWa = '';
  String _image = '';
  XFile? _ImageFileTemp;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String get nama => _nama;
  String get email => _email;
  String get noWa => _noWa;
  String get image => _image;
  XFile? get imageFile => _imageFile;
  XFile? get imageFileTemp => _ImageFileTemp;

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

  set imageFile(XFile? value) {
    _imageFile = value;
  }

  set imageFileTemp(XFile? value) {
    _ImageFileTemp = value;
  }

  void setProfile(String? nam, String? eml, String? img, String? no) {
    _nama = nam ?? "default";
    _email = eml ?? "default";
    _image = img ?? "assets/images/emptyAvatar.png";
    _noWa = no ?? "default";
    _imageFile = _ImageFileTemp;
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

  void takePhoto(ImageSource source) async {
    _ImageFileTemp = await _picker.pickImage(source: source);
    notifyListeners();
  }
}
