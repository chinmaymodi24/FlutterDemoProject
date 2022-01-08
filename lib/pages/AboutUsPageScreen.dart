import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';

class AboutUsPageScreen extends StatefulWidget {
  @override
  _MyStateAboutUsPageScreen createState() => _MyStateAboutUsPageScreen();
}

class _MyStateAboutUsPageScreen extends State<AboutUsPageScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 18.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.navigate_before,
                          size: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "About Us",
                          style: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 24,
                              fontFamily: 'Metropolis-ExtraBold'),
                        ),
                      ),
                    ],
                  ),
                ),
            SizedBox(height: 30.0),
            Image.asset(
              Images.ImgNagarTreeLogo,
              width: 90,
              height: 90,
            ),
            SizedBox(height: 20.0),
            Text(
              "Akhil Bhartiya Nagar \nParishad Madhyasth",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: new Color(0xff4A4B4D),
                  fontSize: 22.0,
                  fontFamily: 'Metropolis-ExtraBold'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 43.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 40.0),
                width: screenWidth,
                color: Color(0xffF6F6F6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Metropolis-Bold',
                        color: Color(0xff4A4B4D),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Metropolis-Bold',
                        color: Color(0xff4A4B4D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 40.0),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Metropolis-Bold',
                        color: Color(0xff4A4B4D),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Metropolis-Bold',
                        color: Color(0xff4A4B4D),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
