import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/cart_model.dart';

class ProductApi {
  static Future<List<CartModel>> getProduct() async {
    String url =
        'https://api.jsonbin.io/v3/b/62f5b62fe13e6063dc76b5f8?meta=false';
    Uri a = Uri.parse(url);
    final response = await http.get(a);
    final body = json.decode(response.body);

    return body.map<CartModel>(CartModel.fromJson).toList();
  }
}
