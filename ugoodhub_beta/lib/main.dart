import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:ug_foodhub/logic/provider/login_provider.dart';
import 'package:ug_foodhub/ui/page/dummy_home_page.dart';
import 'package:ug_foodhub/ui/page/log_in.dart';

import 'logic/provider/cart_provider.dart';
import 'logic/provider/profile_provider.dart';
import 'logic/provider/rate_provider.dart';
import 'logic/provider/status_provider.dart';
import 'model/status_model.dart';

Future<void> main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  //

  SharedPreferences pref = await SharedPreferences.getInstance();
  bool? isLoggedIn = pref.getBool("isLoggedin");

  runApp(UGFoodHub(
    isLoggedIn: isLoggedIn ?? false,
  ));
}

class UGFoodHub extends StatelessWidget {
  final bool isLoggedIn;
  UGFoodHub({
    required this.isLoggedIn,
  });
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => RateProvider()),
            StreamProvider<List<StatusModel>>(
              create: (context) => StatusProvider().loadStream(),
              initialData: [],
              catchError: (_, error) => [],
            ),
          ],
          child: MaterialApp(
              theme: ThemeData(fontFamily: "Poppins"),
              home: (isLoggedIn) ? HomePage() : LogIn()),
        );
      },
    );
  }
}
