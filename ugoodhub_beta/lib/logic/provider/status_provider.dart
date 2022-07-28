import 'package:flutter/material.dart';

import '../../model/rate_model.dart';
import '../../model/status_model.dart';
import '../../utility/rate_api.dart';
import '../../utility/status_api.dart';

class StatusProvider extends ChangeNotifier {
  //status: konfirmasi, disiapkan, diantarkan, selesai
  List<StatusModel> _listworking = [];
  List<StatusModel> _listdone = [];
  List<RateModel> _restorate = [];
  List<RateModel> _foodrate = [];

  List<StatusModel> get listworking => _listworking;
  List<StatusModel> get listdone => _listdone;
  List<RateModel> get restorate => _restorate;
  List<RateModel> get foodrate => _foodrate;

  set restorate(List<RateModel> value) {
    _restorate = value;
  }

  set foodrate(List<RateModel> value) {
    _foodrate = value;
  }

  void loadData() async {
    Future<List<StatusModel>> stat = StatusApi.getStatus();
    List<StatusModel> _list = await stat;
    _listdone = [];
    _listworking = [];
    for (var list in _list) {
      if (list.status == "Selesai") {
        _listdone.add(list);
      } else {
        _listworking.add(list);
      }
    }
    notifyListeners();
    return;
  }

  void loadDataRate() async {
    Future<List<RateModel>> rate = RateApi.getRate();
    List<RateModel> _listrate = await rate;
    for (var list in _listrate) {
      if (list.ratetype == "resto") {
        _restorate.add(list);
      } else {
        _foodrate.add(list);
      }
    }
    notifyListeners();
    return;
  }

  void restoRateChange(double rate) {
    _restorate[0] = RateModel(
        idrate: _restorate[0].idrate,
        restaurantid: _restorate[0].restaurantid,
        nama: _restorate[0].nama,
        ratetype: _restorate[0].ratetype,
        rate: rate);
    notifyListeners();
  }

  void foodRateChange(double rate, int index) {
    _restorate[index] = RateModel(
        idrate: _restorate[index].idrate,
        restaurantid: _restorate[index].restaurantid,
        nama: _restorate[index].nama,
        ratetype: _restorate[index].ratetype,
        rate: rate);
    notifyListeners();
  }
}
