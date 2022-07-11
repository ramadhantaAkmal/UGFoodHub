import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../logic/cubit/order_cubit.dart';

import '../../model/product.dart';

class FoodPage extends StatelessWidget {
  final Product product;

  FoodPage({required this.product});

  @override
  Widget build(BuildContext context) {
    // klik kanan remove widget aja safe areanya kalo mau dihapus
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(product.imageURL),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shadowColor: Color.fromARGB(61, 0, 0, 0),
                          elevation: 3,
                          borderRadius: BorderRadius.circular(16),
                          child: IconButton(
                              iconSize: 25,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF323643),
                            fontSize: 28.sp),
                      ),
                      Container(
                        width: 40,
                        height: 25,
                        child: Center(
                            child: Text(
                          product.rating,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(48, 253, 132, 99),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: Offset(0, 0))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (BuildContext context, state) {
                          OrderDetail orderDetail = state as OrderDetail;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(orderDetail.price),
                                  //"Rp " + orderDetail.price.toString(),
                                  style: TextStyle(
                                      color: Color(0xFFFE724C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.sp),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //decrement
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<OrderCubit>()
                                          .decrement(product);
                                    },
                                    child: Icon(Icons.remove,
                                        color: Color(0xFFFE724C)),
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFFE724C)),
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(6),
                                      primary: Colors.white, // <-- Button color
                                      onPrimary:
                                          Color(0xFFFE724C), // <-- Splash color
                                    ),
                                  ),
                                  //Quantity
                                  Text(
                                    orderDetail.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  //increment
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<OrderCubit>()
                                          .increment(product);
                                    },
                                    child: Icon(Icons.add, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(6),
                                      primary:
                                          Color(0xFFFE724C), // <-- Button color
                                      onPrimary:
                                          Colors.white, // <-- Splash color
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        product.description,
                        // maxLines: 5,
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Tulis catatan disini",
                          hintStyle: TextStyle(),
                          isDense: true,
                          fillColor: Colors.amber,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepOrange, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusColor: Colors.deepOrange,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton.icon(
                  onPressed: () {
                    // add to cart
                  },
                  icon: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFFE724C)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0.sp),
                      ))),
                  label: Text(
                    "TAMBAH",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
