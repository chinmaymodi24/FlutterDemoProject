import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/HomePageScreen1.dart';

void main() => runApp(new MyAnimateButtonApp());

class MyAnimateButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Progress Button',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyAnimateButtonHomePage(title: 'Progress Button'),
    );
  }
}

class MyAnimateButtonHomePage extends StatefulWidget {
  MyAnimateButtonHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAnimateButtonHomePageState createState() =>
      new _MyAnimateButtonHomePageState();
}

class _MyAnimateButtonHomePageState extends State<MyAnimateButtonHomePage>
    with TickerProviderStateMixin {
  int _state = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new MaterialButton(
                child: setUpButtonChild(),
                onPressed: () {
                  setState(() {
                    if (_state == 0) {
                      animateButton();
                    }
                  });
                },
                elevation: 4.0,
                minWidth: double.infinity,
                height: 48.0,
                color: Colors.lightGreen,
              ),
            ), */
            TextButton(
                child: setUpButtonChild(),
                onPressed: () {
                  if (_state == 0) {
                    animateButton();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new TextButton(
        onPressed: () {
          if (_state == 0) {
            animateButton();
          }
        },
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 110.0, vertical: 20.0),
          child: Text(
            'Save Profile',
            style: TextStyle(
                color: new Color(0xff0B4328),
                fontSize: 14,
                fontFamily: 'Metropolis-Medium'),
          ),
        ),
        style: TextButton.styleFrom(
          side: BorderSide(color: Color(0xff0B4328), width: 1),
        ),
      );
    } else if (_state == 1) {
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      );
      Route route = MaterialPageRoute(builder: (context) => HomePageScreen1());
      Navigator.pushReplacement(context, route);
    } 
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
