import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Product {
  String id, imageURL, restaurantId, rating, name, description;
  int price;

  Product(
      {required this.id,
      required this.imageURL,
      required this.rating,
      required this.name,
      required this.description,
      required this.restaurantId,
      required this.price});

  factory Product.createProduct(Map<String, dynamic> object) {
    return Product(
        id: object["id"],
        imageURL: object["imageUrl"],
        rating: object["rating"].toString(),
        name: object["name"],
        price: object["price"],
        description: object["description"],
        restaurantId: object["restaurantId"]);
  }

  static Future<List<Product>> connectToAPI(
      String? restaurantId, int page, int limit) async {
    var jsonObject;
    if (restaurantId == null) {
      String apiURL =
          "https://6280df817532b4920f750278.mockapi.io/product?page=" +
              page.toString() +
              "&limit=" +
              limit.toString();
      log("Connecting to Product Endpoint");
      var apiResult = await http.get(Uri.parse(apiURL));
      jsonObject = json.decode(apiResult.body) as List;
    } else {
      String apiURL =
          "https://6280df817532b4920f750278.mockapi.io/restaurant/" +
              restaurantId +
              "/product";

      log("Connecting to Product Endpoint");
      var apiResult = await http.get(Uri.parse(apiURL));
      jsonObject = json.decode(apiResult.body) as List;
    }
    return jsonObject
        .map<Product>((item) => Product.createProduct(item))
        .toList();
  }
}
