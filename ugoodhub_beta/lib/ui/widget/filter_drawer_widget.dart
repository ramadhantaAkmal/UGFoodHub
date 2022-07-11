// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

class FilterDrawerWidget extends StatefulWidget {
  const FilterDrawerWidget({Key? key}) : super(key: key);

  @override
  State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
}

class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
  final padding = EdgeInsets.only(left: 20, right: 10);
  int selectedValue = 0;
  String filter = '';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
      child: SizedBox(
          width: 270,
          child: Drawer(
              child: Material(
            child: Column(
              children: [
                buildHeader(context: context),
                RadioListTile<int>(
                  value: 1,
                  title: Text(
                    'Makanan',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  groupValue: selectedValue,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) => setState(() {
                    selectedValue = 1;
                  }),
                ),
                RadioListTile<int>(
                  value: 2,
                  title: Text(
                    'Minuman',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  groupValue: selectedValue,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) => setState(() {
                    selectedValue = 2;
                  }),
                ),
                SizedBox(
                  height: 47,
                ),
                buildSave(
                  onPressed: () {
                    if (selectedValue < 1) {
                      filter = 'Campur';
                    } else if (selectedValue == 1) {
                      filter = 'Makanan';
                    } else {
                      filter = 'Minuman';
                    }
                    print(filter); //sementara
                  },
                ),
              ],
            ),
          ))),
    );
  }

  Widget buildHeader({
    required BuildContext context,
  }) =>
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //margin: const EdgeInsets.only(left: 3.5, top: 2, right: 5, bottom: 5),
                  padding: const EdgeInsets.all(1),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.5,
                        blurRadius: 5.5,
                        offset:
                            const Offset(3, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Center(
                      child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildSave({required final Function() onPressed}) => InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: MaterialButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.0),
            ),
            child: Center(
              child: Text(
                'Simpan',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            color: Colors.deepOrange,
          ),
        ),
      );
}
