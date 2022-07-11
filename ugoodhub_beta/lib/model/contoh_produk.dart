import 'package:flutter/cupertino.dart';

class ContohProduk {
  String nama;
  String desc;
  int harga;
  int quantity;
  ImageProvider image;

  ContohProduk(this.nama, this.desc, this.harga, this.quantity, this.image);

  get totalHargaProduk => harga * quantity;
}
