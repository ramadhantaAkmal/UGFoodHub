import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:ug_foodhub/logic/provider/login_provider.dart';
import 'package:ug_foodhub/ui/page/home_page.dart';

import 'logic/bloc/product/product_bloc.dart';
import 'logic/bloc/restaurant/restaurant_bloc.dart';
import 'logic/provider/cart_provider.dart';
import 'logic/provider/profile_provider.dart';
import 'logic/provider/status_provider.dart';
import 'ui/page/onboarding_page.dart';

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
            ChangeNotifierProvider(create: (_) => StatusProvider()),
          ],
          child: MaterialApp(
              theme: ThemeData(fontFamily: "Poppins"),
              home: (isLoggedIn)
                  ? MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              RestaurantBloc()..add(LoadRestaurant()),
                        ),
                        BlocProvider(
                          create: (context) =>
                              ProductBloc()..add(LoadProduct()),
                        ),
                      ],
                      child: HomePage(),
                    )
                  : OnboardingPage()),
        );
      },
    );
  }
}
