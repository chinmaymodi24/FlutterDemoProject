import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/GotraResultPageScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GotraDirectoryPageScreen extends StatefulWidget {
  @override
  _MyStateGotraDirectoryPageScreen createState() =>
      _MyStateGotraDirectoryPageScreen();
}

class _MyStateGotraDirectoryPageScreen extends State<GotraDirectoryPageScreen> {
  List<int> resource;
  var data;
  var langSelectLength;
  var profilePicture;

  void getSubcasteData() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/subcaste/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        langSelectLength =
            jsonDecode(data)['subcaste']; //get all the data from json string

        print(langSelectLength.length); // just printed length of data
      });

      var venam = jsonDecode(data)['subcaste'][0]['SubcasteName'];
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    height: 60,
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
                      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
                      child: Text(
                        "Gotra Directory",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Metropolis-Bold',
                          color: Color(0xff0B4328),
                        ),
                      ),
                    ),
                  ),
                ),
                getHomePageBody(context),
                SizedBox(height: 20.0)
              ],
            ),
          ],
        ),
      ),
    );
  }

  getHomePageBody(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          langSelectLength == null
              ? AwesomeLoader(
                  loaderType: AwesomeLoader.AwesomeLoader3,
                  color: Colors.orange,
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      langSelectLength == null ? 0 : langSelectLength.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      width: screenWidth,
                      height: 80,
                      child: TextButton(
                        onPressed: () async {
                          print(
                              "${jsonDecode(data)['subcaste'][index]['SubcasteName']}");
                          final pref = await SharedPreferences.getInstance();
                          pref.setInt(
                              "subcasteId",
                              jsonDecode(data)['subcaste'][index]
                                  ['SubcasteID']);
                          var string = pref.getInt("subcasteId");
                          print("get value = $string");

                          var string1 = jsonDecode(data)['subcaste'][index]
                                  ['SubcasteName']
                              .toString();

                          print("SubCasteName pass = $string1");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GotraResultPageScreen(string1)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 20.0),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${jsonDecode(data)['subcaste'][index]['SubcasteName']}',
                                style: TextStyle(
                                    color: Color(0XFF979797),
                                    fontSize: 16,
                                    fontFamily: 'Roboto-Regular'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 19,
                                color: Color(0xffB6B7B7),
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Color(0xff0B4328))),
                          ),
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.all(0.0),
                ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSubcasteData();
  }

  /* @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

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
                        "Gotra Directory",
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
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecordNotFoundPageScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Vadnagra Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecordPageScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Visnagra Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Sathodra Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Prashnora Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Krushnora Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Bandhara Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              width: screenWidth,
              height: containerHeight,
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Chandra Nagar Brahmin',
                        style: TextStyle(
                            color: Color(0XFF979797),
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios,
                            size: 19, color: Color(0xffB6B7B7))),
                    SizedBox(width: 10.0),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xff0B4328))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */

}
