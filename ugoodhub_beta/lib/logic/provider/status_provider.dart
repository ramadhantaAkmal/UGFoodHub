import 'package:flutter/material.dart';

import '../../model/status_model.dart';
import '../../utility/status_api.dart';

class StatusProvider extends ChangeNotifier {
  //status: konfirmasi, disiapkan, diantarkan, selesai
  List<StatusModel> _listworking = [];
  List<StatusModel> _listdone = [];

  List<StatusModel> get listworking => _listworking;
  List<StatusModel> get listdone => _listdone;

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
}
