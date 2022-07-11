import 'package:flutter/material.dart';
import 'log_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BackgroundImage.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Daftar",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nama Lengkap :',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'E-mail',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'No Whatsapp',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Kata Sandi',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  obscureText: isHiddenPass,
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
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isHiddenPass = !isHiddenPass;
                        });
                      },
                      child: Icon(
                        isHiddenPass ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    onPressed: () {
                      //akan ditambahkan
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Text(
                      'DAFTAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    color: Colors.deepOrange,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Sudah memiliki akun ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                          //(Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
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
