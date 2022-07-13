// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:ug_foodhub/ui/page/cart_page.dart';

import '../../logic/bloc/product/product_bloc.dart';
import '../../logic/bloc/restaurant/restaurant_bloc.dart';
import '../../logic/cubit/order_cubit.dart';
import '../widget/filter_drawer_widget.dart';
import '../widget/navigation_drawer_widget.dart';
import '../widget/restaurant_card.dart';
import '../widget/product_home_card.dart';
import 'product_page.dart';
import 'food_page.dart';

class HomePage extends StatelessWidget {
  final PageController restaurantController =
      PageController(initialPage: 0, viewportFraction: 0.75);
  final PageController productController =
      PageController(initialPage: 0, viewportFraction: 0.51);
  late RestaurantBloc restaurantBloc;
  late ProductBloc productBloc;

  HomePage({Key? key}) : super(key: key);

  /// `_key` variable is for drawer and enddrawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  String? selectedLocation;
  List<DropdownMenuItem> generateItems() {
    List<String> locations = ["Kampus E", "Kampus D"];

    List<DropdownMenuItem> items = [];
    for (var item in locations) {
      items.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawerScrimColor: Colors.transparent,
        drawer: Container(
          child: NavigationDrawerWidget(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orangeAccent.withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 20,
                offset: const Offset(0.5, 0),
              ),
            ],
          ),
        ),
        endDrawer: Container(
          child: FilterDrawerWidget(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orangeAccent.withOpacity(0.5),
                spreadRadius: 10,
                blurRadius: 20,
                offset: const Offset(0.5, 0),
              ),
            ],
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Color.fromARGB(120, 0, 0, 0),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(16),
                      child: IconButton(
                          iconSize: 25,
                          onPressed: () {
                            _key.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.short_text_rounded)),
                    ),
                    Container(
                      child: Column(
                        children: [
                          DropdownButton<dynamic>(
                              items: generateItems(),
                              value: selectedLocation,
                              underline: SizedBox(),
                              hint: Text(
                                "Lokasi",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 15.sp),
                              ),
                              onChanged: (item) {
                                selectedLocation = item.toString();
                                restaurantBloc.add(
                                    LoadRestaurant(location: item.toString()));
                              }),
                          BlocBuilder<RestaurantBloc, RestaurantState>(
                            builder: ((context, state) {
                              return Text(
                                (state is RestaurantInitial)
                                    ? (state).location
                                    : (state as RestaurantLoaded).location,
                                style: TextStyle(
                                    color: Color(0xffFE724C), fontSize: 15.sp),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                    Material(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Color.fromARGB(120, 0, 0, 0),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(16),
                      child: IconButton(
                          iconSize: 25,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                          icon: Icon(Icons.shopping_basket_rounded)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Mau pesan apa hari ini?",
                  style: TextStyle(
                      color: Color(0xFF323643),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              //SEARCH BAR
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: "Temukan produk favoritmu",
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
                          suffixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.primaries.first,
                          )),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Material(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Color.fromARGB(120, 0, 0, 0),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(16),
                      child: IconButton(
                          iconSize: 25,
                          onPressed: () {
                            _key.currentState?.openEndDrawer();
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
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Restaurant Terpopuler",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Color(0xFF323643),
                      fontWeight: FontWeight.w700),
                ),
              ),
              // Restaurant Populer
              Container(
                width: 260,
                height: 255,
                child: BlocBuilder<RestaurantBloc, RestaurantState>(
                  builder: (context, state) {
                    if (state is RestaurantInitial) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      RestaurantLoaded restaurantLoaded =
                          state as RestaurantLoaded;
                      return PageView.builder(
                          onPageChanged: (int index) {
                            if (index == restaurantLoaded.restaurantList.length)
                              restaurantBloc.add(LoadRestaurant());
                          },
                          padEnds: false,
                          controller: restaurantController,
                          itemCount: (restaurantLoaded.hasReachedMax)
                              ? restaurantLoaded.restaurantList.length
                              : restaurantLoaded.restaurantList.length + 1,
                          itemBuilder: ((context, index) => (index <
                                  restaurantLoaded.restaurantList.length)
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider<ProductBloc>(
                                            create: (context) => ProductBloc()
                                              ..add(LoadProduct(
                                                  restaurantId: restaurantLoaded
                                                      .restaurantList[index]
                                                      .id)),
                                            child: ProductPage(
                                              restaurant: restaurantLoaded
                                                  .restaurantList[index],
                                            ));
                                      },
                                    ));
                                  },
                                  child: RestaurantCard(
                                    restaurant:
                                        restaurantLoaded.restaurantList[index],
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )));
                    }
                  },
                ),
                //IKLAN
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Produk Terpopuler",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Color(0xFF323643),
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                width: 160,
                height: 280,
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductInitial) {
                      return Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      ProductLoaded productLoaded = state as ProductLoaded;
                      return PageView.builder(
                          padEnds: false,
                          onPageChanged: (int index) {
                            if (index == (productLoaded.productList.length) - 1)
                              productBloc.add(LoadProduct());
                          },
                          controller: productController,
                          itemCount: (productLoaded.hasReachedMax) ?? true
                              ? productLoaded.productList.length
                              : productLoaded.productList.length + 1,
                          itemBuilder: ((context, index) => (index <
                                  productLoaded.productList.length)
                              ? GestureDetector(
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
                                  child: ProductHomeCard(
                                    product: productLoaded.productList[index],
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )));
                    }
                  },
                ),
                //IKLAN
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
