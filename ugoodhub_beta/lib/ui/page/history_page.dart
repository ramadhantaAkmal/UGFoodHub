// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ug_foodhub/logic/provider/rate_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/provider/status_provider.dart';
import '../../model/status_model.dart';
import 'reviewresto_page.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    RateProvider _rate = Provider.of<RateProvider>(context, listen: false);
    _rate.loadDataRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Pesanan',
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
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              Container(
                // height: 50,
                // width: 20,
                margin: EdgeInsets.only(
                  right: 10,
                  top: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image(
                    height: 50,
                    width: 50,
                    image: AssetImage('assets/images/emptyAvatar.png'),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30)),
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: 'Berjalan',
                      ),
                      Tab(
                        text: 'Selesai',
                      ),
                    ],
                    indicator: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.deepOrange,
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 550,
                    child: TabBarView(
                      children: [
                        ///berjalan

                        StreamBuilder<List<StatusModel>>(
                          stream: StatusProvider().loadStream(),
                          builder: (context, statusModels) {
                            final filtered = statusModels.data!
                                .where((e) => e.status != "Selesai")
                                .toList();

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    statusModels.connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : buildWorking(
                                            filtered,
                                            index,
                                          ),
                                  ],
                                );
                              },
                              itemCount: filtered.length,
                              shrinkWrap: true,
                            );
                          },
                        ),

                        /// selesai
                        Consumer<List<StatusModel>>(
                          builder: (context, statusModels, _) {
                            final filtered = statusModels
                                .where((e) => e.status == "Selesai")
                                .toList();

                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    context.debugDoingBuild
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber[800],
                                            ),
                                          )
                                        : buildDone(
                                            filtered,
                                            index,
                                          ),
                                  ],
                                );
                              },
                              itemCount: filtered.length,
                              shrinkWrap: true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openWa(String num) async {
    String url = "whatsapp://send?phone=$num&text=hello";

    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  Widget buildDone(List<StatusModel> statlist, int index) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/sateAvatar.png'),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  statlist[index].restoname,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  statlist[index].status,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.15),
                          spreadRadius: 0,
                          blurRadius: 50,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: 0.1,
                      height: 30,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewResto(),
                          ),
                        );
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Review',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWorking(List<StatusModel> statlist, int index) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/sateAvatar.png'),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  statlist[index].restoname,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  statlist[index].status,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.15),
                          spreadRadius: 0,
                          blurRadius: 50,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: 0.1,
                      height: 30,
                      onPressed: () {
                        _openWa(statlist[index].restonum);
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
