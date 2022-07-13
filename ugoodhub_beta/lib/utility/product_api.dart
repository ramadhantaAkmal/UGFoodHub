import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/cart_model.dart';

class ProductApi {
  static Future<List<CartModel>> getProduct() async {
    String url =
        'https://raw.githubusercontent.com/ramadhantaAkmal/test/main/ugoodhub_beta/assets/dummy_product.json';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<CartModel>(CartModel.fromJson).toList();
  }
}
