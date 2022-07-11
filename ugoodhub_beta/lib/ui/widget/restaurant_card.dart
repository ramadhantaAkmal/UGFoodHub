import 'package:flutter/material.dart';

import '../../model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            width: 260,
            height: 230,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            image: DecorationImage(
                                image: NetworkImage(restaurant.imageURL),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: 40,
                        height: 25,
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.topLeft,
                        child: Center(
                            child: Text(
                          restaurant.rating,
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
                  flex: 3,
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: 0, top: 8, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(
                              restaurant.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 3),
                          Flexible(
                            flex: 3,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Color(0xffFE724C),
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  restaurant.estimatedTime,
                                  style: TextStyle(
                                    color: Color(0xFF7E8392),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          Flexible(
                            flex: 3,
                            child: Row(
                              children: [
                                if (restaurant.hasMakanan)
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        "Makanan",
                                        style: TextStyle(
                                          color: Color(0xFF7E8392),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                SizedBox(
                                  width: 10,
                                ),
                                if (restaurant.hasMinuman)
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        "Minuman",
                                        style: TextStyle(
                                          color: Color(0xFF7E8392),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            ))
      ],
    );
  }
}
