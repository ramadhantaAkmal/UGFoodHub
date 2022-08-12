import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/rate_model.dart';

class RateApi {
  static Future<List<RateModel>> getRate() async {
    String url =
        'https://api.jsonbin.io/v3/b/62f5b5d2e13e6063dc76b591?meta=false';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<RateModel>(RateModel.fromJson).toList();
  }
}
