import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductDetailCard extends StatelessWidget {
  final Product product;

  ProductDetailCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            width: double.infinity,
            height: 250,
            margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 2))
                ]),
            child: Column(
              children: [
                Flexible(
                  flex: 7,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            image: DecorationImage(
                                image: NetworkImage(product.imageURL),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: 40,
                        height: 25,
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        child: Center(
                            child: Text(
                          product.rating,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10, top: 8, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 3),
                          Flexible(
                            flex: 3,
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF5B5B5E),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ))
      ],
    );
  }
}
