import 'package:flutter/cupertino.dart';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ug_foodhub/model/order_model.dart';

import '../../model/cart_model.dart';
import '../../utility/product_api.dart';

class CartProvider extends ChangeNotifier {
  int _subsum = 0;
  int _jasa = 3000;
  int _sum = 0;

  List<CartModel>? _products = [];
  List<OrderModel> _orders = [];
  List<int> _restoid = [];
  List<int> _productid = [];
  List<String> _desc = [];

  int get subsum => _subsum;
  int get jasa => _jasa;
  int get sum => _sum;
  List<CartModel> get products => _products!;
  List<OrderModel> get orders => _orders;

  set subsum(int value) {
    _subsum = value;
  }

  set sum(int value) {
    _sum = value;
  }

  set products(List<CartModel> value) {
    _products = value;
  }

  void loadData() async {
    _products = await ProductApi.getProduct();
    initSum(_products!);
    notifyListeners();
  }

  void orderSet(String metode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _orders = [];
    _restoid = [];
    _productid = [];
    _desc = [];

    for (var cart in _products!) {
      _restoid.add(cart.restaurantid);
      _productid.add(cart.productid);
      _desc.add(cart.desc);
    }

    _orders.add(OrderModel('ORDR1234', pref.getInt('id'), _restoid, _productid,
        _desc, _sum, metode));

    notifyListeners();
  }

  void initSum(List<CartModel> products) {
    subsum = products.map((e) => e.harga).reduce((n1, n2) => n1 + n2);
    sum = subsum + jasa;
  }

  void removeItem(int index) {
    try {
      products.removeAt(index);
      subsum = products
          .map((e) => e.totalHargaProduk)
          .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);
      sum = subsum + jasa;
      notifyListeners();
    } catch (e) {
      subsum = 0;
      sum = 0;
      notifyListeners();
    }
  }

  void addItem(int index) {
    try {
      // tambahin 1 item ke produk[index]
      products[index].quantity++;

      // trus update subsum
      subsum = products
          .map((e) => e.totalHargaProduk)
          .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);
      sum = subsum + jasa;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void reduceItem(int index) {
    // abaikan jika quantity 1
    if (products[index].quantity == 1) {
      return;
    }

    // kurangin 1 item ke produk[index]
    products[index].quantity--;

    // trus update subsum
    subsum = products
        .map((e) => e.totalHargaProduk)
        .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);

    sum = subsum + jasa;
    notifyListeners();
  }
}
