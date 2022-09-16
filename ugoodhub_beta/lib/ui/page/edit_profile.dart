// ignore_for_file: file_names, prefer_const_declarations, prefer_const_constructors

import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ug_foodhub/ui/page/dummy_home_page.dart';

import '../../logic/provider/profile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _noWaController;

  @override
  void initState() {
    super.initState();
    ProfileProvider _prof =
        Provider.of<ProfileProvider>(context, listen: false);
    _namaController = TextEditingController(text: _prof.nama);
    _emailController = TextEditingController(text: _prof.email);
    _noWaController = TextEditingController(text: _prof.noWa);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _noWaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider _prof = Provider.of<ProfileProvider>(context, listen: true);

    double picsize = 90;

    ImageProvider image;
    if (_prof.imageFileTemp == null) {
      image = AssetImage('assets/images/emptyAvatar.png');
    } else {
      image = FileImage(File(_prof.imageFileTemp!.path));
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
                  offset: const Offset(6, 4), // changes position of shadow
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
        /**
         * 
         * 
         * 
         * Bagian Body
         * 
         * 
         * 
         */
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: image,
                            height: picsize,
                            width: picsize,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    //backgroundColor: Colors.transparent,
                                    context: context,
                                    // isScrollControlled: false,
                                    // isDismissible: false,
                                    builder: (BuildContext context) {
                                      return showImageSource(_prof);
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.white,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.grey,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    _prof.nama,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Edit Profil",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Nama Lengkap :',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepOrange, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusColor: Colors.deepOrange,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'E-mail',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'No Whatsapp',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  controller: _noWaController,
                  decoration: InputDecoration(
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
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Profil Berhasil Diubah",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          margin: EdgeInsets.only(
                            bottom: 50.0,
                            left: 20,
                            right: 20,
                          ),
                          duration: Duration(milliseconds: 2000),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.deepOrange,
                          elevation: 10,
                        ),
                      );
                      _prof.setProfile(_namaController.text,
                          _emailController.text, null, _noWaController.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: const Text(
                      'SIMPAN',
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

  Widget showImageSource(ProfileProvider prof) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                prof.takePhoto(ImageSource.camera);
              }),
          ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () {
                prof.takePhoto(ImageSource.gallery);
              })
        ],
      ),
    );
  }
}
