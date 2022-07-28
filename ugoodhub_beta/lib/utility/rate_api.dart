import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/rate_model.dart';

class RateApi {
  static Future<List<RateModel>> getRate() async {
    String url =
        'https://raw.githubusercontent.com/ramadhantaAkmal/test/main/ugoodhub_beta/assets/dummy_rate.json';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<RateModel>(RateModel.fromJson).toList();
  }
}
