import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key key}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _boxWithLable(context),
        ),
        _bottomButton(context)
      ],
    );
  }

  Widget _boxWithLable(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text("Enter OTP:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange))),
        _boxBuilder()
      ],
    );
  }

  Widget _boxBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _box(),
        _box(),
        _box(),
        _box(),
      ],
    );
  }

  Widget _box() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width / 8,
      child: TextField(
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff4A4B4D), width: 1.0),
            ),
            border: InputBorder.none,
            counterText: '',
            contentPadding: const EdgeInsets.all(20)),
      ),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 2)),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 15,
              color: Colors.orangeAccent,
              child: Text("Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
            ),
            onTap: () {
              print("Clicked On Submit");
              //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));
            },
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
