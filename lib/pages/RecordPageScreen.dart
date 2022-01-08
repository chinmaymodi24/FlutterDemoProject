import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';

class RecordPageScreen extends StatefulWidget {
  @override
  _MyStateRecordPageScreen createState() => _MyStateRecordPageScreen();
}

class _MyStateRecordPageScreen extends State<RecordPageScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var containerHeight = 80.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 38,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Family List",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Metropolis-Bold',
                          color: Color(0xff0B4328),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.ImgNoUserProfile,
                                width: 57,
                                height: 57,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Family ID",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Text(
                                  ": ABNP01",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-SemiBold'),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            screenWidth < 358
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Name",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.0,
                                      ),
                                      Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Chinmay Nautam Kumar",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                      ),
                                    ],
                                  )
                                : FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                        SizedBox(
                                          width: 32.0,
                                        ),
                                        Text(
                                          ": ",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                        Text(
                                          "Chinmay Nautam Kumar",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(height: 6.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Gotra",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 32.0,
                                ),
                                Text(
                                  ": Visnagra",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-SemiBold'),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Marital",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 26.0,
                                ),
                                Text(
                                  ": Married",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-SemiBold'),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Activity",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  ": Job",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-SemiBold'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
