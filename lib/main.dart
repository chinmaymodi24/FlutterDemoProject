import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/HomePageScreen1.dart';
import 'package:flutter_demo_project/pages/WelcomePageScreen.dart';
import 'package:flutter_demo_project/pages/intro_slider1.dart';
import 'package:flutter_demo_project/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginkey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var introkey = preferences.getString("Introkey");

  print("introkey1 = $introkey");

  SharedPreferences pref = await SharedPreferences.getInstance();
  loginkey = pref.getString("savedUserId");
  print("loginkey = $loginkey");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: introkey == null ? IntroSlider1() : MyNagarTreeApp1(),
  ));
}

class MyNagarTreeApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Nagar Tree App',
              home: loginkey == null ? WelcomePageScreen() : HomePageScreen1(),
            );
          },
        );
      },
    );
  }
}

/* void main() async {
  runApp(MyNagarTreeApp());
}

class MyNagarTreeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Nagar Tree App',
              theme: AppTheme.lightTheme,
              home: SignUpPageScreen2(),
            );
          },
        );
      },
    );
  }
} */
