import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_demo_project/news.dart';
import 'package:http/http.dart' as http;
import 'package:page_indicator/page_indicator.dart';

class NewsPageScreen1 extends StatefulWidget {
  @override
  _MyTestNewsPageScreen1AppState createState() =>
      _MyTestNewsPageScreen1AppState();
}

class _MyTestNewsPageScreen1AppState extends State<NewsPageScreen1> {
  PageController controller1;

  GlobalKey<PageContainerState> key1 = GlobalKey();

  var imagePath;

  var data;
  var langSelectLength;

  int length;

  Uint8List bytes1;
  Uint8List bytes2;
  Uint8List bytes3;

  List<int> resource;

  String newsDescription;

  final List<News> _allNews = allNews();

  static List<News> allNews() {
    var lstOfNews = new List<News>();

    lstOfNews.add(
      new News(
        date: "01/07/2021",
        newsDescription:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
        newsImg: Images.ImgNavigationHeader,
        time: "Now",
      ),
    );
    lstOfNews.add(
      new News(
        date: "01/07/2021",
        newsDescription:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
        newsImg: Images.ImgNavigationHeader,
        time: "Now",
      ),
    );
    lstOfNews.add(
      new News(
        date: "01/07/2021",
        newsDescription:
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
        newsImg: Images.ImgNavigationHeader,
        time: "Now",
      ),
    );
    return lstOfNews;
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
                        "News",
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
                  itemCount: length,
                  itemBuilder: (BuildContext context, int index) {
                    imagePath = (data)['news'][index]['images'].toString();
                    //print("imagePath = $imagePath");

                    try {
                      var neww1 = imagePath.split(',');
                      //print("neww1[0] = ${neww1[0]}");
                      //print("image1 = ${neww1[1]}");
                      //print("neww1[2] = ${neww1[2]}");
                      //print("image2 = ${neww1[3]}");
                      //print("neww1[4] = ${neww1[4]}");
                      //print("neww1[5] = ${neww1[5]}");

                      var image1 = neww1[1];
                      //print("index = $index image1 = $image1");
                      var image2 = neww1[3];
                      //print("index = $index image2 = $image2");
                      String tempImage3 = neww1[5];

                      var image3 = tempImage3.split(']');
                      //print("image3[0] = ${image3[0]}");
                      //print("image3[1] = ${image3[1]}");
                      //var finalimage3 = image3[0];
                      var finalimage3 = image3[0];
                      //print("index = $index finalimage3 = $finalimage3");
                      // print("finalimage3[0] = ${image3[0]}");
                      // print("finalimage3[1] = ${image3[1]}");

                      image1.contains('png');
                      {
                        bytes1 = null;
                      }

                      if (image1 == "") {
                        //print("image1 is null");
                        bytes1 = null;
                      } else if (image1 != "") {
                        //print("image1 is not null");
                        bytes1 =
                            base64.decode(base64.normalize(image1.toString()));
                      }

                      if (image2 == "") {
                        //print("image2 is null");
                        bytes2 = null;
                      } else if (image2 != "") {
                        //print("image2 is not null");
                        bytes2 =
                            base64.decode(base64.normalize(image2.toString()));
                        //print("index = $index bytes = $bytes2");
                      }

                      if (finalimage3 == "") {
                        //print("finalimage3 is null");
                        bytes3 = null;
                      } else if (finalimage3 != "") {
                        //print("finalimage3 is not null");
                        bytes3 = base64
                            .decode(base64.normalize(finalimage3.toString()));
                      }

                      /* bytes1 =
                          base64.decode(base64.normalize(image1.toString()));
                      bytes2 =
                          base64.decode(base64.normalize(image2.toString())); */
                      //print("bytes3 = $bytes3");

                    } catch (e) {
                      FormatException();
                    }

                    return new Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Image.asset(
                                      Images.ImgNagarTreeLogo,
                                      height: 42,
                                      width: 42,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 1.0),
                                                  width: screenWidth / 1.5100,
                                                  child: Text(
                                                    (data)['news'][index]
                                                        ['NewsHeadline'],
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Metropolis-Medium',
                                                      color: Color(0xff0B4328),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 6.0, 0.0, 0.0),
                                                child: Text(
                                                  (data)['news'][index]['Date'],
                                                  style: TextStyle(
                                                    color: Color(0xffB6B7B7),
                                                    fontFamily:
                                                        'Metropolis-Regular',
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          //SizedBox(width: 26),
                                          /* Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 0.0),
                                    child: IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_outline,
                                      ),
                                    ),
                                  ), */
                                        ],
                                      ),
                                      Container(
                                        height: 200,
                                        width: screenWidth,
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 12.0, 6.0, 0.0),
                                        child: PageIndicatorContainer(
                                            child: PageView(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 24.0),
                                                  child: bytes1 == null
                                                      ? Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                              "not found",
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                        ],
                                                      )
                                                      : Image.memory(
                                                          bytes1,
                                                          fit: BoxFit.fill,
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 24.0),
                                                  child: bytes2 == null
                                                      ? Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                              "not found",
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                        ],
                                                      )
                                                      : Image.memory(
                                                          bytes2,
                                                          fit: BoxFit.fill,
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 24.0),
                                                  child: bytes3 == null
                                                      ? Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                              "not found",
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                        ],
                                                      )
                                                      : Image.memory(
                                                          bytes3,
                                                          fit: BoxFit.fill,
                                                        ),
                                                ),
                                              ],
                                              controller: controller1,
                                            ),
                                            length: 3,
                                            shape:
                                                IndicatorShape.circle(size: 0)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 8.0, 2.0, 20.0),
                                        child: Text(
                                          (data)['news'][index]['NewsDetail'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color(0xffB6B7B7),
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
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

  Future getAllNewsData() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/allnews/"));

    if (response.statusCode == 200) {
      //data = response.body; //store response as string

      data = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        langSelectLength = (data)['news']; //get all the data from json string

        /* print(
            "langSelectLength ${langSelectLength.length}"); // just printed length of data */

        length = langSelectLength.length;
        //print("length = $length");
      });

      var split;
      //print("index = $index");

      /* imagePath = (data)['news'][4]['images'].toString();
      //print("imagePath = $imagePath");

      try {
        var neww1 = imagePath.split(',');
        //print("neww1[0] = ${neww1[0]}");
        //print("image1 = ${neww1[1]}");
        //print("neww1[2] = ${neww1[2]}");
        //print("image2 = ${neww1[3]}");
        //print("neww1[4] = ${neww1[4]}");
        //print("neww1[5] = ${neww1[5]}");

        var image1 = neww1[1];
        print("image1 = $image1");
        var image2 = neww1[3];
        print("image2 = $image2");
        String tempImage3 = neww1[5];

        var image3 = tempImage3.split(']');
        print("finalimage3[0] = ${image3[0]}");
      } catch (e) {
        FormatException(e.toString());
      } */

      /* for (int index = 0; index < length; index++) {
        imagePath = (data)['news'][0]['images'].toString();

        try {
          var neww1 = imagePath.split(',');
          //print("neww1[0] = ${neww1[0]}");
          //print("image1 = ${neww1[1]}");
          //print("neww1[2] = ${neww1[2]}");
          //print("image2 = ${neww1[3]}");
          //print("neww1[4] = ${neww1[4]}");
          //print("neww1[5] = ${neww1[5]}");

          var image1 = neww1[1];
          print("image1 = $image1");
          var image2 = neww1[3];
          print("image2 = $image2");
          String tempImage3 = neww1[5];

          var image3 = tempImage3.split(']');
          print("image3[0] = ${image3[0]}");
          print("image3[1] = ${image3[1]}");
          //var finalimage3 = image3[0];
          var finalimage3 = image3[0];
          print("finalimage3 = $finalimage3");
          // print("finalimage3[0] = ${image3[0]}");
          // print("finalimage3[1] = ${image3[1]}");

          bytes1 = base64.decode(base64.normalize(image1.toString()));
          bytes2 = base64.decode(base64.normalize(image2.toString()));
          bytes3 = base64.decode(base64.normalize(finalimage3.toString()));
        } catch (e) {
          FormatException(e.toString());
        }
      } */

      /* imagePath = (data)['news'][0]['images'].toString();
      //print("imagePath = $imagePath");

      try {
        var neww1 = imagePath.split(',');
        //print("neww1[0] = ${neww1[0]}");
        //print("image1 = ${neww1[1]}");
        //print("neww1[2] = ${neww1[2]}");
        //print("image2 = ${neww1[3]}");
        //print("neww1[4] = ${neww1[4]}");
        //print("neww1[5] = ${neww1[5]}");

        var image1 = neww1[1];
        print("image1 = $image1");
        var image2 = neww1[3];
        print("image2 = $image2");
        String tempImage3 = neww1[5];

        var image3 = tempImage3.split(']');
        print("image3[0] = ${image3[0]}");
        print("image3[1] = ${image3[1]}");
        //var finalimage3 = image3[0];
        var finalimage3 = image3[0];
        print("finalimage3 = $finalimage3");
        // print("finalimage3[0] = ${image3[0]}");
        // print("finalimage3[1] = ${image3[1]}");

        if (finalimage3 == "") {
          print("finalimage3 is null");
          bytes3 = null;
        } else if (finalimage3 != "") {
          print("finalimage3 is not null");
          bytes3 = base64.decode(base64.normalize(finalimage3.toString()));
        }

        bytes1 = base64.decode(base64.normalize(image1.toString()));
        bytes2 = base64.decode(base64.normalize(image2.toString()));

        print("bytes3 = $bytes3");
      } catch (e) {
        FormatException();
      } */
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllNewsData();
  }
}
