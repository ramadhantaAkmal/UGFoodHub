// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/provider/cart_provider.dart';
import 'payment_2_page.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Pembayaran',
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
          backgroundColor: backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pilih salah satu metode pembayaran dibawah ini',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildImage(
                  'OVO',
                  Image(
                    image: AssetImage('assets/images/ovo.png'),
                    fit: BoxFit.contain,
                  ),
                  context),
              SizedBox(
                height: 10,
              ),
              buildImage(
                  'GOPAY',
                  Image(
                      image: AssetImage('assets/images/gopay.png'),
                      fit: BoxFit.cover),
                  context),
              SizedBox(
                height: 10,
              ),
              buildImage(
                  'SHOPEE',
                  Image(
                    image: AssetImage('assets/images/shopee.png'),
                    fit: BoxFit.scaleDown,
                  ),
                  context),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String pilihan, Image imagePath, BuildContext context) {
    CartProvider _order = Provider.of<CartProvider>(context, listen: false);
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      onTap: (() {
        _order.orderSet(pilihan);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => PaymentConfirmPage(
                  pilihan: pilihan,
                )),
          ),
        );
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        height: 80,
        width: 325,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: imagePath,
        ),
      ),
    );
  }
}
