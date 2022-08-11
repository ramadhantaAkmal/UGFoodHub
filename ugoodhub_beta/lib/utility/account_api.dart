import 'dart:convert';
import 'package:ug_foodhub/model/account_model.dart';
import 'package:http/http.dart' as http;

class AccountApi {
  static Future<List<AccountModel>> getUsers() async {
    String url =
        'https://raw.githubusercontent.com/ramadhantaAkmal/SkripsiProject/main/ugoodhub_beta/assets/dummy_account.json';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<AccountModel>(AccountModel.fromJson).toList();
  }

  // static Future<List<AccountModel>> getUsersLocally(
  //     BuildContext context) async {
  //   final assetBundle = DefaultAssetBundle.of(context);
  //   final data = await assetBundle.loadString('assets/dummy_account.json');
  //   final body = json.decode(data);

  //   return body.map<AccountModel>(AccountModel.fromJson).toList();
  // }
}
