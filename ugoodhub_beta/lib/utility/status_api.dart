import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/status_model.dart';

class StatusApi {
  static Future<List<StatusModel>> getStatus() async {
    String url =
        'https://api.jsonbin.io/v3/b/62f5b6055c146d63ca6a2e04?meta=false';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<StatusModel>(StatusModel.fromJson).toList();
  }
}
