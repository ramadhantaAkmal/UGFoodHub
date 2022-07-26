class OrderModel {
  String orderid;
  int? userid;
  List<int> restaurantid;
  List<int> productid;
  List<String> desc;
  int total;
  String metode;

  OrderModel(this.orderid, this.userid, this.restaurantid, this.productid,
      this.desc, this.total, this.metode);
}
