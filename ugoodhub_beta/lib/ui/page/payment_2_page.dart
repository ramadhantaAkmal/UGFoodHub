// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_declarations, prefer_const_constructors

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PaymentConfirmPage extends StatelessWidget {
  final String pilihan;
  final int total;

  PaymentConfirmPage({required this.pilihan, required this.total, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.white;

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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                pilihan,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'UG Foodcourt',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '089761272',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Jumlah : ${NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(total)}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (() {}),
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Text(
                    'Upload bukti bayar disini',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                height: 50,
                minWidth: 300,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                child: const Text(
                  'KONFIRMASI',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
