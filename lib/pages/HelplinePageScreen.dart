import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';

class HelplinePageScreen extends StatefulWidget {
  @override
  _MyStateHelplineUsPageScreen createState() => _MyStateHelplineUsPageScreen();
}

class _MyStateHelplineUsPageScreen extends State<HelplinePageScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

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
                          "Helpline",
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
            SizedBox(height: 100.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Mobile Number",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'Metropolis-Regular',
                      color: Color(0xffB6B7B7),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "+123456789,  +245678935",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Metropolis-Medium',
                      color: Color(0xff4A4B4D),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider(
                    color: Color(0xff707070),
                    thickness: 0.1,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'Metropolis-Regular',
                      color: Color(0xffB6B7B7),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "abnpinfo01@gmail.com",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Metropolis-Medium',
                      color: Color(0xff4A4B4D),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider(
                    color: Color(0xff707070),
                    thickness: 0.1,
                  ),
                  Text(
                    "Office Address",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'Metropolis-Regular',
                      color: Color(0xffB6B7B7),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Chandkheda, Ahmedabad - 382424",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Metropolis-Medium',
                      color: Color(0xff4A4B4D),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider(
                    color: Color(0xff707070),
                    thickness: 0.1,
                  ),
                  Text(
                    "Follow Us",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'Metropolis-Regular',
                      color: Color(0xffB6B7B7),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      //Icon(Icons.facebook),
                      SizedBox(width: 10.0),
                      Image.asset(
                        Images.IcInstagramPng,
                        width: 19,
                        height: 19,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
