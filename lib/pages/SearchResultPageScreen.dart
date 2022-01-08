import 'dart:convert';
import 'dart:developer';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultPageScreen extends StatefulWidget {
  final String searchString;
  SearchResultPageScreen(this.searchString, {Key key}) : super(key: key);
  @override
  _MySearchResultPageScreenAppState createState() =>
      _MySearchResultPageScreenAppState();
}

var langSelectLength;
var profilePicture;
var data;

class _MySearchResultPageScreenAppState extends State<SearchResultPageScreen> {
  List<int> resource;

  var userID;
  var index = 0;
  var toBase64Result;

  getSearchResult() async {
    final pref = await SharedPreferences.getInstance();
    var string = pref.getString("searchValue");
    print("getString valueIn getSearchResult = $string");

    http.Response response = await http.post(
      Uri.parse("https://helicoreraj.pythonanywhere.com/search/"),
      body: ({"search": string}),
    );

    if (response.statusCode == 200) {
      data = response.body; //store response as string
      //print("data = $data");
      setState(() {
        langSelectLength =
            jsonDecode(data)['info']; //get all the data from json string
        //print("langSelectLength = $langSelectLength");
        userID = jsonDecode(data)['info'][index]['UserID'];
        //print("userID = $userID");
      });
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //screenWidth < 280 ?
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios_rounded),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          screenWidth < 280
                              ? Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              "Search Result",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontFamily: 'Metropolis-Bold',
                                                color: Color(0xff0B4328),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Search Result",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Metropolis-Bold',
                                          color: Color(0xff0B4328),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Expanded(
                            flex: 1,
                            child: Text(""),
                          ),
                        ],
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
                    profilePicture =
                        jsonDecode(data)['info'][index]['ProfileImage'];
                    //log("profilePicture = $profilePicture");

                    var stringToBase64Url = utf8.fuse(base64Url);
                    toBase64Result = stringToBase64Url.encode(profilePicture);
                    resource = base64.decode(base64.normalize(profilePicture));

                    return Container(
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
                                  padding: const EdgeInsets.fromLTRB(
                                      8.8, 0.0, 8.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      toBase64Result == ""
                                          ? CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage: ExactAssetImage(
                                                  Images.ImgNoUserProfileJpg),
                                            )
                                          : Container(
                                              width: 57,
                                              height: 57,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(resource,
                                                        scale: 0.5)),
                                              ),
                                            ),
                                      /* Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(resource,
                                                  scale: 0.5)),
                                        ),
                                      ), */
                                    ],
                                  ),
                                ),
                              ),

                              /* Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      toBase64Result == ""
                                          ? CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage: ExactAssetImage(
                                                  Images.ImgNoUserProfileJpg),
                                            )
                                          : CircleAvatar(
                                              radius: 35.0,
                                              child: ClipRRect(
                                                child: Image.memory(resource),
                                                borderRadius:
                                                    BorderRadius.circular(70.0),
                                              ),
                                            ),
                                      /* Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(resource,
                                                  scale: 0.5)),
                                        ),
                                      ), */
                                    ],
                                  ),
                                ),
                              ),
                               */

                              SizedBox(
                                width: 7.0,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: ("Family ID :"),
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              "Login Clicked");
                                                        },
                                                  text:
                                                      " ${jsonDecode(data)['info'][index]['Family_id']}",
                                                  style: TextStyle(
                                                      color: Color(0xff0B4328),
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-SemiBold')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: ("Name :"),
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              "Login Clicked");
                                                        },
                                                  text:
                                                      " ${jsonDecode(data)['info'][index]['FirstName']}",
                                                  style: TextStyle(
                                                      color: Color(0xff0B4328),
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-SemiBold')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: ("Gotra :"),
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              "Login Clicked");
                                                        },
                                                  text:
                                                      " ${jsonDecode(data)['info'][index]['Gotra']}",
                                                  style: TextStyle(
                                                      color: Color(0xff0B4328),
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-SemiBold')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: ("Maritial :"),
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              "Login Clicked");
                                                        },
                                                  text:
                                                      " ${jsonDecode(data)['info'][index]['MaritialStatus']}",
                                                  style: TextStyle(
                                                      color: Color(0xff0B4328),
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-SemiBold')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            text: ("Activity :"),
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          print(
                                                              "Login Clicked");
                                                        },
                                                  text:
                                                      " ${jsonDecode(data)['info'][index]['Occupation']}",
                                                  style: TextStyle(
                                                      color: Color(0xff0B4328),
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-SemiBold')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
    getSearchResult();
  }

  @override
  void dispose() {
    super.dispose();
    langSelectLength = null;
  }
}
