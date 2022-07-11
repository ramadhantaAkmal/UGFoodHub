import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Restaurant {
  String id, imageURL, rating, name, estimatedTime;
  bool hasMakanan, hasMinuman;

  Restaurant(
      {required this.id,
      required this.imageURL,
      required this.rating,
      required this.name,
      required this.estimatedTime,
      required this.hasMakanan,
      required this.hasMinuman});

  factory Restaurant.createRestaurant(Map<String, dynamic> object) {
    return Restaurant(
        id: object["id"],
        imageURL: object["imageUrl"],
        rating: object["rating"].toString(),
        name: object["name"],
        estimatedTime: object["time"],
        hasMakanan: object["hasMakanan"],
        hasMinuman: object["hasMinuman"]);
  }

  static Future<List<Restaurant>> connectToAPI(
      String location, int page, int limit) async {
    String apiURL = "https://6280df817532b4920f750278.mockapi.io/restaurant" +
        "?location=" +
        location +
        "&page=" +
        page.toString() +
        "&limit=" +
        limit.toString();

    log("Connecting to Restaurant Endpoint " +
        location +
        " page : " +
        page.toString());
    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<Restaurant>((item) => Restaurant.createRestaurant(item))
        .toList();
  }
}
