// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/contoh_produk.dart';
import 'payment_page.dart';

class Cart extends StatefulWidget {
  final List<ContohProduk> products;

  Cart({required this.products, Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState(products);
}

class _CartState extends State<Cart> {
  final color = Colors.deepOrange;
  // sum sebelum ongtip
  int subsum = 0;
  int ongtip = 3000;
  // sum total
  int sum = 0;

  List<ContohProduk> products;

  _CartState(this.products) {
    subsum = products.map((e) => e.harga).reduce((n1, n2) => n1 + n2);
    sum = subsum + ongtip;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Keranjang',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          //icon tombol back
          leading: Container(
            margin:
                const EdgeInsets.only(left: 7, top: 4, right: 10, bottom: 10),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 11,
                  offset: const Offset(6, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 50, bottom: 50),
          child: Column(
            children: [
              /*
              *
              *
              *
              */
              //Card product
              ListView.separated(
                itemBuilder: (context, index) {
                  return buildCart(index);
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemCount: products.length,
                shrinkWrap: true,
              ),
              /*
              *
              *
              *
              */
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(subsum),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Jasa Aplikasi',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Rp 3.000',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ' (${products.length} items)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(sum),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Divider(),
              Spacer(),
              MaterialButton(
                height: 50,
                minWidth: 300,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentPage(
                                total: sum,
                              )));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                child: const Text(
                  'BAYAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeItem(int index) {
    products.removeAt(index);
    subsum = products
        .map((e) => e.totalHargaProduk)
        .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);
    sum = subsum + ongtip;

    setState(() {});
  }

  void addItem(int index) {
    // tambahin 1 item ke produk[index]
    products[index].quantity++;

    // trus update subsum
    setState(() {
      subsum = products
          .map((e) => e.totalHargaProduk)
          .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);
      sum = subsum + ongtip;
    });
  }

  void reduceItem(int index) {
    // abaikan jika quantity 1
    if (products[index].quantity == 1) {
      return;
    }

    // kurangin 1 item ke produk[index]
    products[index].quantity--;

    // trus update subsum
    setState(() {
      subsum = products
          .map((e) => e.totalHargaProduk)
          .reduce((nilaiTotal, nilaiSekarang) => nilaiTotal + nilaiSekarang);

      sum = subsum + ongtip;
    });
  }

  Widget buildCart(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: products[index].image,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    products[index].nama,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                products[index].desc,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(products[index].harga),
                style: TextStyle(
                  color: color,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    removeItem(index);
                  },
                  icon: Icon(
                    Icons.close,
                    color: color,
                    size: 15,
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => reduceItem(index),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.orange,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.remove,
                          color: color,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${products[index].quantity}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => addItem(index),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: color,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
