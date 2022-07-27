class StatusModel {
  final String statusid;
  final int restaurantid;
  final int productid;
  final String restoname;
  String status;

  StatusModel({
    required this.statusid,
    required this.restaurantid,
    required this.productid,
    required this.restoname,
    required this.status,
  });

  static StatusModel fromJson(json) => StatusModel(
        statusid: json['statusid'],
        restaurantid: json['restaurantid'],
        productid: json['productid'],
        restoname: json['restoname'],
        status: json['status'],
      );
}
