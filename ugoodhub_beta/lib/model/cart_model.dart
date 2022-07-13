class CartModel {
  final String nama;
  final String desc;
  final int harga;
  int quantity;
  final String image;

  CartModel(
      {required this.nama,
      required this.desc,
      required this.harga,
      required this.quantity,
      required this.image});

  get totalHargaProduk => harga * quantity;

  static CartModel fromJson(json) => CartModel(
        nama: json['nama'],
        desc: json['desc'],
        harga: json['harga'],
        quantity: json['quantity'],
        image: json['image'],
      );
}
