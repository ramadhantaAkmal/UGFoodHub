class RateModel {
  final String idrate;
  final int restaurantid;
  final String nama;
  final String ratetype;
  double rate;

  RateModel({
    required this.idrate,
    required this.restaurantid,
    required this.nama,
    required this.ratetype,
    required this.rate,
  });

  static RateModel fromJson(json) => RateModel(
        idrate: json['idrate'],
        restaurantid: json['restoid'],
        nama: json['nama'],
        ratetype: json['ratetype'],
        rate: json['rate'],
      );
}
