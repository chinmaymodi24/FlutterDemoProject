import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecordNotFoundPageScreen extends StatefulWidget {
  @override
  _MyStateRecordNotFoundPageScreen createState() =>
      _MyStateRecordNotFoundPageScreen();
}

class _MyStateRecordNotFoundPageScreen extends State<RecordNotFoundPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 130.0),
          Center(
            child: Container(
              height: 140,
              width: 180,
              child: SvgPicture.asset(
                Images.ImgResultNotFound,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                "No Records found",
                style: TextStyle(
                  letterSpacing: 0.1,
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontFamily: 'Metropolis-Regular',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
