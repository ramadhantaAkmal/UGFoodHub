// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:ug_foodhub/ui/page/cart_page.dart';

import '../widget/navigation_drawer_widget.dart';

class HomePage extends StatelessWidget {
  final PageController restaurantController =
      PageController(initialPage: 0, viewportFraction: 0.75);
  final PageController productController =
      PageController(initialPage: 0, viewportFraction: 0.51);

  HomePage({Key? key}) : super(key: key);

  /// `_key` variable is for drawer and enddrawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
