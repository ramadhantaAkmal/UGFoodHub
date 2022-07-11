// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../logic/bloc/product/product_bloc.dart';
import '../../logic/cubit/order_cubit.dart';
import '../../model/restaurant.dart';
import '../widget/product_detail_card.dart';
import 'food_page.dart';

class ProductPage extends StatelessWidget {
  final Restaurant restaurant;
  String? selectedSort;
  List<DropdownMenuItem> generateItems() {
    List<String> sortType = ["Populer"];

    List<DropdownMenuItem> items = [];
    for (var item in sortType) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }

    return items;
  }

  ProductPage({required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Material(
                elevation: 1,
                shadowColor: Color.fromARGB(36, 32, 32, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              restaurant.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(restaurant.imageURL),
                                      fit: BoxFit.fill)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 40,
                      height: 25,
                      margin: EdgeInsets.only(left: 20),
                      child: Center(
                          child: Text(
                        restaurant.rating,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(48, 253, 132, 99),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Urutkan",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          DropdownButton<dynamic>(
                              items: generateItems(),
                              isDense: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xFFFE724C),
                                  fontFamily: "Poppins"),
                              value: selectedSort,
                              hint: Text(
                                selectedSort ?? "Populer",
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xFFFE724C)),
                              ),
                              onChanged: (item) {
                                selectedSort = item.toString();
                              }),
                          Spacer(flex: 7),
                          Material(
                            clipBehavior: Clip.antiAlias,
                            shadowColor: Color.fromARGB(120, 0, 0, 0),
                            elevation: 3,
                            borderRadius: BorderRadius.circular(16),
                            child: IconButton(
                                iconSize: 25,
                                onPressed: () {
                                  //filter
                                },
                                icon: Icon(
                                  Icons.tune_rounded,
                                  color: Color(0xffFE724C),
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: ((context, state) {
                  if (state is ProductInitial) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    ProductLoaded productLoaded = state as ProductLoaded;
                    return Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: productLoaded.productList.length,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BlocProvider<OrderCubit>(
                                      create: (context) => OrderCubit()
                                        ..loadOrder(
                                            productLoaded.productList[index]),
                                      child: FoodPage(
                                        product:
                                            productLoaded.productList[index],
                                      ),
                                    );
                                  }));
                                },
                                child: ProductDetailCard(
                                  product: productLoaded.productList[index],
                                ),
                              ))),
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
