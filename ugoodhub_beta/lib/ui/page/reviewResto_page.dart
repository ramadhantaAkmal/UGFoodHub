// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../logic/provider/status_provider.dart';
import 'reviewfood_page.dart';

class ReviewResto extends StatefulWidget {
  const ReviewResto({Key? key}) : super(key: key);
  @override
  State<ReviewResto> createState() => _ReviewRestoState();
}

class _ReviewRestoState extends State<ReviewResto> {
  @override
  Widget build(BuildContext context) {
    StatusProvider _rate = Provider.of<StatusProvider>(context, listen: true);
    int rating = 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
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
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/sateAvatar.png'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _rate.restorate[0].nama,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RatingBar(
                  initialRating: 1.0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: Icon(
                      Icons.star_half_outlined,
                      color: Colors.amber,
                    ),
                    empty: Icon(
                      Icons.star_border_outlined,
                      color: Colors.amber,
                    ),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    _rate.restoRateChange(rating.toInt());
                    print(_rate.restorate[0].nama +
                        " rate = " +
                        _rate.restorate[0].rate.toString());
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 46),
                  child: MaterialButton(
                    minWidth: 250,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewFood()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: const Text(
                      'KIRIM',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
