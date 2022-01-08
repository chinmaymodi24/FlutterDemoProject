import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyGetApiDemoApp());

class MyGetApiDemoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyGetApiHomePage(),
    );
  }
}

class MyGetApiHomePage extends StatefulWidget {
  @override
  _MyGetApiHomePageState createState() => _MyGetApiHomePageState();
}

class _MyGetApiHomePageState extends State<MyGetApiHomePage> {
  String data;
  var _length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/subcaste/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        _length =
            jsonDecode(data)['subcaste']; //get all the data from json string

        print(_length.length); // just printed length of data
      });

      //var venam = jsonDecode(data)['subcaste'][4]['url'];

      //print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Http Example"),
      ),
      body: ListView.builder(
        itemCount: _length == null ? 0 : _length.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                  jsonDecode(data)['subcaste'][index]['SubcasteID'].toString()),
              subtitle:
                  Text(jsonDecode(data)['subcaste'][index]['SubcasteName']),
            ),
          );
        },
      ),
    );
  }
}
