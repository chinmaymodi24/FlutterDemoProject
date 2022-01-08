import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/WelcomePageScreen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../images.dart';

class IntroSlider1 extends StatefulWidget {
  @override
  _MyIntroSlider1ScreenPageState createState() =>
      _MyIntroSlider1ScreenPageState();
}

class _MyIntroSlider1ScreenPageState extends State<IntroSlider1> {
  PageController controller1;

  GlobalKey<PageContainerState> key1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller1 = PageController();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeWidth = MediaQuery.of(context).size.width;
    final screenSizeheight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () async {
                        print("Skip Button Pressed");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePageScreen()),
                            (route) => false);
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString("Introkey", "Introkey");
                        var string = preferences.getString("Introkey");
                        print("key = $string");
                        /* Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePageScreen())); */
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Metropolis-Medium',
                            color: Color(0xff7C7D7E)),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: screenSizeheight,
                width: screenSizeWidth,
                child: PageIndicatorContainer(
                    padding: EdgeInsets.all(100.0),
                    indicatorColor: Colors.grey,
                    indicatorSelectorColor: Colors.black,
                    key: key1,
                    child: PageView(
                      children: <Widget>[
                        Container(
                          height: screenSizeheight,
                          width: screenSizeWidth,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: AspectRatio(
                                    aspectRatio: 2 / 2,
                                    child: Image.asset(
                                      Images.ImgIntroSlider1,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      "Your Family Details",
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontFamily: 'Metropolis-ExtraBold',
                                        color: Color(0xff4A4B4D),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      "All India Nagar Parishad-Central \nmembership form",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Metropolis-Medium',
                                        color: Color(0xff7C7D7E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenSizeheight,
                          width: screenSizeWidth,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: AspectRatio(
                                    aspectRatio: 2 / 2,
                                    child: Image.asset(
                                      Images.ImgIntroSlider2,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      "New Family Add",
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontFamily: 'Metropolis-ExtraBold',
                                        color: Color(0xff4A4B4D),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      "All India Nagar Parishad-Central \nmembership form",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Metropolis-Medium',
                                        color: Color(0xff7C7D7E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: screenSizeheight,
                          width: screenSizeWidth,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: AspectRatio(
                                    aspectRatio: 2 / 2,
                                    child: Image.asset(
                                      Images.ImgIntroSlider3,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text(
                                      "Directory",
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        fontFamily: 'Metropolis-ExtraBold',
                                        color: Color(0xff4A4B4D),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      "All India Nagar Parishad-Central \nmembership form",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Metropolis-Medium',
                                        color: Color(0xff7C7D7E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      controller: controller1,
                    ),
                    align: IndicatorAlign.center,
                    length: 3,
                    indicatorSpace: 4.0,
                    shape: IndicatorShape.circle(size: 6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
