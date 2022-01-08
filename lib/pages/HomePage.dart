import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_demo_project/news.dart';
import 'package:http/http.dart' as http;

/* void main() {
  runApp(HomePage());
} */

class HomePage extends StatefulWidget {
  @override
  _MyHomePageAppState createState() => _MyHomePageAppState();
}

class _MyHomePageAppState extends State<HomePage> {
  var data;
  var langSelectLength;
  var index = 0;

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
    //getAllNewsData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: new Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: getHomePageBody(context))),
    );
  }

  Future getAllNewsData() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/allnews/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        langSelectLength =
            jsonDecode(data)['news']; //get all the data from json string

        print(langSelectLength.length); // just printed length of data
      });

      /* print("${jsonDecode(data)['news'][index]['NewsID']}");
        print("${jsonDecode(data)['news'][index]['NewsHeadline']}");
        print("${jsonDecode(data)['news'][index]['NewsDetail']}");
        print("${jsonDecode(data)['news'][index]['NewsLink']}");
        print("${jsonDecode(data)['news'][index]['NewsVideo']}");
        print("${jsonDecode(data)['news'][index]['NewsProfile']}");
        print("${jsonDecode(data)['news'][index]['CreatedAt']}");
        print("${jsonDecode(data)['news'][index]['Date']}");
        print("${jsonDecode(data)['news'][index]['images']}"); */

      for (index = 0; index < 3; index++) {
        //if(values[i]!=null){
        //Map<String,dynamic> map=values[i];
        //_postList .add(Post.fromJson(map));
        //debugPrint('Id-------${map['id']}');
        //}

        /* print("${jsonDecode(data)['news'][index]['NewsID']}");
        print("${jsonDecode(data)['news'][index]['NewsHeadline']}"); */

        newsDescription = jsonDecode(data)['news'][index]['NewsDetail'];
        print("${jsonDecode(data)['news'][index]['NewsDetail']}");
        /* print("${jsonDecode(data)['news'][index]['NewsLink']}");
        print("${jsonDecode(data)['news'][index]['NewsVideo']}");
        print("${jsonDecode(data)['news'][index]['NewsProfile']}");
        print("${jsonDecode(data)['news'][index]['CreatedAt']}");
        print("${jsonDecode(data)['news'][index]['Date']}");
        print("${jsonDecode(data)['news'][index]['images']}"); */

        print("newsDescription = $newsDescription");
      }
      //var venam = jsonDecode(data)['subcaste'][4]['url'];

      //print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllNewsData();
  }

  getHomePageBody(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
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
                      "News",
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
          /* new FutureBuilder<List>(
            future: getAllNewsData(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Waiting to start');
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  if (snapshot.hasError) {
                    return new Text('Error: ${snapshot.error}');
                  } else {
                    return new ListView.builder(
                        itemBuilder: (context, index) =>
                            new Text("${jsonDecode(data)['news'][index]['NewsHeadline']}"),
                        itemCount: snapshot.data.length);
                  }
              }
            },
          ), */
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _allNews.length,
            itemBuilder: _getItemUI,
            padding: EdgeInsets.all(0.0),
          )
        ],
      ),
    );

    /*  return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(), // new
      controller: _controller,
      shrinkWrap: true,
      itemCount: _allNews.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
    ); */
  }

  // First Attempt
  Widget _getItemUI(BuildContext context, int index) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 0.0),
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
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  "Akhil Bhartiya Nagar",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Metropolis-Medium',
                                    color: Color(0xff0B4328),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  _allNews[index].time,
                                  style: TextStyle(
                                    color: Color(0xffB6B7B7),
                                    fontFamily: 'Metropolis-Regular',
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                              /* Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Image.asset(Images.ImgNavigationHeader),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  Strings.news1,
                                  softWrap: true,
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: Color(0xffB6B7B7),
                                    fontSize: 13.0,
                                  ),
                                ),
                              ), */
                            ],
                          ),
                          SizedBox(width: 10),
                          /* Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 12.0, 6.0, 0.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                Images.ImgNavigationHeader,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 2.0, 10.0),
                        child: Text(
                          _allNews[index].newsDescription,
                          style: TextStyle(
                            color: Color(0xffB6B7B7),
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /* Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  ),
                ), */
              ],
            ),
          )
        ],
      ),
    );

    /* return new Card(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ListBody(children: [
          Container(
            height: 400,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          Images.ImgNagarTreeLogo,
                          height: 28,
                          width: 28,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Akhil Bhartiya Nagar",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Metropolis-Medium',
                                color: Color(0xff0B4328),
                              ),
                            ),
                            Text(
                              _allNews[index].time,
                              style: TextStyle(
                                color: Color(0xffB6B7B7),
                                fontFamily: 'Metropolis-Regular',
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(width: 100.0),
                        Container(
                          color: Colors.green,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_outline)),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(Images.ImgNavigationHeader),
                  Text(
                    Strings.news1,
                    softWrap: true,
                    maxLines: 5,
                    style: TextStyle(
                      color: Color(0xffB6B7B7),
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        new ListTile(

            /* leading: new Image.asset(
            Images.ImgNagarTreeLogo,
            height: 28,
            width: 28,
          ), */

            /* title: new Text(
            "Akhil Bhartiya Nagar",
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'Metropolis-Medium',
              color: Color(0xff0B4328),
            ),
          ), */

            ),

        /* new ListTile(
          leading: new Image.asset(
            _allCities[index].image,
            fit: BoxFit.cover,
            width: 50.0,
          ),

          title: new Text(
            _allCities[index].name,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_allCities[index].country,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                new Text('Population: ${_allCities[index].population}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
              ]),
          //trailing: ,
          onTap: () {
            _showSnackBar(context, _allCities[index]);
          },
        ), */
      ],
    ));

 */
  }

  /* _showSnackBar(BuildContext context, News item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.name} is a News in ${item.country}"),
      backgroundColor: Colors.amber,
    );
    Scaffold.of(context).showSnackBar(objSnackbar);
  } */

}
