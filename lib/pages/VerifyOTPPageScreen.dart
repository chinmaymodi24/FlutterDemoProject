import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo_project/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NewPasswordPageScreen.dart';

class VerifyOTPPageScreen extends StatefulWidget {
  @override
  _MyStateVerifyOTPPageScreen createState() => _MyStateVerifyOTPPageScreen();
}

var getMobileNumber;
String finalNumber;

class _MyStateVerifyOTPPageScreen extends State<VerifyOTPPageScreen> {

  String finalOtpNumber;
  String digit1;
  String digit2;
  String digit3;
  String digit4;
  final _formKeyVerifyOtp = new GlobalKey<FormState>();
  TextEditingController digit1Controller = TextEditingController();
  TextEditingController digit2Controller = TextEditingController();
  TextEditingController digit3Controller = TextEditingController();
  TextEditingController digit4Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("get mobile No In Widget build = $getMobileNumber");

    //var setHiddenPhoneNumber = setHiddenPhoneNumber();
    //var callingsetHiddenPhoneNumber = new setHiddenPhoneNumber();
    /* final myString = getMobileNumber;
    final startIndex = 2;
    final replaced = myString.replaceFirst(RegExp(getMobileNumber[3]), '*', startIndex);
    final replaced1 =replaced.replaceFirst(RegExp(getMobileNumber[4]), '*', startIndex);
    final replaced2 =replaced1.replaceFirst(RegExp(getMobileNumber[5]), '*', startIndex);
    final replaced3 =replaced2.replaceFirst(RegExp(getMobileNumber[6]), '*', startIndex);
    finalNumber =replaced3.replaceFirst(RegExp(getMobileNumber[7]), '*', startIndex);
    print("replaced = $finalNumber"); */

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  //padding: EdgeInsets.only(right: 56.0),
                  //alignment: Alignment.topLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.navigate_before,
                    size: 34,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 0.0),
              child: Text(
                "We have sent an OTP to your Mobile",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: new Color(0xff4A4B4D),
                    fontSize: 25,
                    fontFamily: 'Metropolis-ExtraBold'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 0.0),
              child: Text(
                "Please check your mobile number continue to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: new Color(0xff7C7D7E),
                    fontSize: 14,
                    fontFamily: 'Metropolis-Medium'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Form(
                key: _formKeyVerifyOtp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 60,
                        height: 55,
                        child: TextFormField(
                          controller: digit1Controller,
                          textAlign: TextAlign.center,
                          minLines: 1,
                          maxLength: 1,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 60,
                        height: 55,
                        child: TextFormField(
                          controller: digit2Controller,
                          textAlign: TextAlign.center,
                          minLines: 1,
                          maxLength: 1,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 60,
                        height: 55,
                        child: TextFormField(
                          controller: digit3Controller,
                          textAlign: TextAlign.center,
                          minLines: 1,
                          maxLength: 1,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 60,
                        height: 55,
                        child: TextFormField(
                          controller: digit4Controller,
                          textAlign: TextAlign.center,
                          minLines: 1,
                          maxLength: 1,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 12.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: new Color(0xff0B4328),
                        fontSize: 14,
                        fontFamily: 'Metropolis-Medium'),
                  ),
                ),
                style: TextButton.styleFrom(
                  side: BorderSide(color: Color(0xff0B4328), width: 1),
                ),
                onPressed: () {
                  if (digit1Controller.text.isEmpty ||
                      digit2Controller.text.isEmpty ||
                      digit3Controller.text.isEmpty ||
                      digit4Controller.text.isEmpty) {
                    print("not valid");
                  } else {
                    digit1 = digit1Controller.text;
                    digit2 = digit2Controller.text;
                    digit3 = digit3Controller.text;
                    digit4 = digit4Controller.text;

                    finalOtpNumber = digit1 + digit2 + digit3 + digit4;

                    print("finalOtpNumber = $finalOtpNumber");

                    verifyOtp();

                    digit1Controller.text = "";
                    digit2Controller.text = "";
                    digit3Controller.text = "";
                    digit4Controller.text = "";

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPasswordPageScreen()));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: RichText(
                text: TextSpan(
                  text: Strings.didntReceiveLabel,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Click Here Clicked");
                            /* Route route = MaterialPageRoute(
                                  builder: (context) => LoginPageScreen());
                              Navigator.pushReplacement(context, route); */
                          },
                        text: " Click Here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0B4328),
                            fontSize: 14.0)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setHiddenPhoneNumber();
  }

  Future<String> setHiddenPhoneNumber() async {
    final pref = await SharedPreferences.getInstance();
    getMobileNumber = pref.getString("phoneNumber");
    print("get mobile No = $getMobileNumber");

    final myString = getMobileNumber;
    final startIndex = 2;
    final replaced =
        myString.replaceFirst(RegExp(getMobileNumber[3]), '*', startIndex);
    final replaced1 =
        replaced.replaceFirst(RegExp(getMobileNumber[4]), '*', startIndex);
    final replaced2 =
        replaced1.replaceFirst(RegExp(getMobileNumber[5]), '*', startIndex);
    final replaced3 =
        replaced2.replaceFirst(RegExp(getMobileNumber[6]), '*', startIndex);
    finalNumber =
        replaced3.replaceFirst(RegExp(getMobileNumber[7]), '*', startIndex);

    getMobileNumber = pref.getString("phoneNumber");
    print("getMobileNumber = $getMobileNumber");
    print("replaced = $finalNumber");

    return finalNumber;
  }

  Future verifyOtp() async {
    final response = await http.post(
      Uri.parse("https://helicoreraj.pythonanywhere.com/otp_ver/"),
      body: jsonEncode({"phone": getMobileNumber, "otp": finalOtpNumber}),
      headers: {
        'Content-type': 'application/json',
      },
    );

    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("Response = $responseString");

      /* var split = responseString.split(',');
      var token = split[1].split(':');
      createdUserToken = token[1].split('"');
      //print("finalToken[0] = ${createdUserToken[0]}");
      print("finalToken[1] = ${createdUserToken[1]}");
      createdUserToken1 = createdUserToken[1]; */

      return (responseString);
    } else {
      return null;
    }
  }
}
