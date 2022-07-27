import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/status_model.dart';

class StatusApi {
  static Future<List<StatusModel>> getStatus() async {
    String url =
        'https://raw.githubusercontent.com/ramadhantaAkmal/test/main/ugoodhub_beta/assets/dummy_status.json';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<StatusModel>(StatusModel.fromJson).toList();
  }
}
