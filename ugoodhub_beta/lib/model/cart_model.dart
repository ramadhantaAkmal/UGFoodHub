import 'package:flutter/cupertino.dart';

class CartModel {
  String nama;
  String desc;
  int harga;
  int quantity;
  String image;

  CartModel(this.nama, this.desc, this.harga, this.quantity, this.image);

  get totalHargaProduk => harga * quantity;
}
