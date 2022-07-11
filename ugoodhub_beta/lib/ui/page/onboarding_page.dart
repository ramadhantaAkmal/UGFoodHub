import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'log_in.dart';
import 'sign_up.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/onboarding_bg.png"),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.sp),
            child: Column(
              children: <Widget>[
                Spacer(flex: 1),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 37.sp,
                        ),
                      ),
                      Text("UG FoodHub",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 37.sp,
                              height: 1.sp,
                              color: Color.fromRGBO(254, 114, 76, 1))),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Text(
                        "Pesan makanan favoritmu disini!",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Color.fromRGBO(48, 56, 79, 1)),
                      )
                    ],
                  ),
                ),
                Spacer(flex: 10),
                Padding(
                  padding: EdgeInsets.only(
                      left: 25.sp, right: 25.sp, top: 10.sp, bottom: 5.sp),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // navigate to register page
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp();
                            //return register page
                          }));
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size.fromHeight(50)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.21)),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0.sp),
                                    side: BorderSide(color: Colors.white)))),
                        child: Text(
                          "DAFTAR",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(flex: 3),
                          Text(
                            "Sudah memiliki akun?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                          Spacer(flex: 1),
                          GestureDetector(
                            onTap: () {
                              //navigate to login page
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LogIn();
                                //return login page
                              }));
                            },
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                  // fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colors.white),
                            ),
                          ),
                          Spacer(flex: 3)
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
