// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations

import 'dart:io';

import 'package:flutter/Material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ug_foodhub/logic/provider/profile_provider.dart';
import 'package:ug_foodhub/ui/page/log_in.dart';

import '../page/edit_profile.dart';
import '../page/history_page.dart';

import 'package:url_launcher/url_launcher.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.only(left: 10, right: 20);

  final Uri _url = Uri.parse('mailto:Sektor@gunadarma.ac.id?subject= &body= ');

  @override
  void initState() {
    try {
      ProfileProvider _prof =
          Provider.of<ProfileProvider>(context, listen: false);
      SharedPreferences.getInstance().then((prefs) {
        _prof.setProfile(prefs.getString("nama")!, prefs.getString("email")!,
            prefs.getString("image")!, prefs.getString("noWa")!);
        super.initState();
      });
    } catch (e) {
      print(e);
    }
  }

  removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLoggedin", false);
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider _prof = Provider.of<ProfileProvider>(context, listen: true);
    ImageProvider _image;
    if (_prof.imageFile == null) {
      _image = AssetImage('assets/images/emptyAvatar.png');
    } else {
      _image = FileImage(File(_prof.imageFile!.path));
    }

    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
      child: SizedBox(
        width: 270,
        child: Drawer(
          child: Material(
            color: Colors.white70,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: padding,
              children: <Widget>[
                buildHeader(
                  image: _image,
                  nama: _prof.nama,
                  email: _prof.email,
                  context: context,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    buildMenuItem(
                      text: 'Pesanan',
                      icon: Icons.receipt,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    buildMenuItem(
                      text: 'Profil',
                      icon: Icons.person,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    buildMenuItem(
                      text: 'Kontak',
                      icon: Icons.mail_rounded,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    buildLogOut(
                      onPressed: () {
                        _prof.imageFile = null;
                        removeAll();
                        saveData();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    final color = Colors.black;

    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[500],
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      //pesanan
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => History(),
        ));
        break;
      //edit profil
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfile(),
        ));
        break;
      //send email
      case 2:
        _launchUrl();
        break;
    }
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  Widget buildHeader({
    required ImageProvider image,
    required String nama,
    required String email,
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
                CircleAvatar(radius: 40, backgroundImage: image),
                Spacer(),
                Container(
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
                        offset: const Offset(3, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Center(
                      child: IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.short_text_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildLogOut({required final Function() onPressed}) => InkWell(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 105, top: 230),
          child: MaterialButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21.0),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.power_settings_new, color: Colors.deepOrange),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Keluar',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            color: Colors.deepOrange,
          ),
        ),
      );
}
