import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/VerifyOTPPageScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPageScreen extends StatefulWidget {
  @override
  _MyStateResetPasswordPageScreen createState() =>
      _MyStateResetPasswordPageScreen();
}

class _MyStateResetPasswordPageScreen extends State<ResetPasswordPageScreen> {
  String mobileNo;
  
  final _formKeyResetPassword = new GlobalKey<FormState>();
  TextEditingController mobileNoController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(right: 36.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.navigate_before,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                        color: new Color(0xff4A4B4D),
                        fontSize: 30,
                        fontFamily: 'Metropolis-ExtraBold'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
                  child: Text(
                    "Please enter your email to receive a link to  create a password via Phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: new Color(0xff7C7D7E),
                        fontSize: 14,
                        fontFamily: 'Metropolis-Medium'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  child: Form(
                    key: _formKeyResetPassword,
                    child: TextFormField(
                      controller: mobileNoController,
                      autocorrect: false,
                      onSaved: (val) => mobileNo = val,
                      maxLength: 10,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.black,
                      validator: MultiValidator([
                        RequiredValidator(errorText: " *Required"),
                        MinLengthValidator(10,
                            errorText: "Phone should be 10 digits")
                      ]),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4A4B4D), width: 1.0),
                        ),
                        labelText: 'Phone',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                            color: new Color(0xff4A4B4D),
                            fontSize: 14,
                            fontFamily: 'Roboto-Regular'),
                      ),
                    ),
                  ),
                ),
                screenWidth < 285
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 20.0),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  color: new Color(0xff0B4328),
                                  fontSize: 14,
                                  fontFamily: 'Metropolis-Medium'),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            side:
                                BorderSide(color: Color(0xff0B4328), width: 1),
                          ),
                          onPressed: () async {
                            if (_formKeyResetPassword.currentState.validate()) {
                              print("mobile No = ${mobileNoController.text}");
                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                  "phoneNumber", mobileNoController.text);
                              //sendOtp(mobileNoController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerifyOTPPageScreen()));
                            } else {
                              print("invalid data");
                            }
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110.0, vertical: 20.0),
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  color: new Color(0xff0B4328),
                                  fontSize: 14,
                                  fontFamily: 'Metropolis-Medium'),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            side:
                                BorderSide(color: Color(0xff0B4328), width: 1),
                          ),
                          onPressed: () async {
                            if (_formKeyResetPassword.currentState.validate()) {
                              print("mobile No = ${mobileNoController.text}");
                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                  "phoneNumber", mobileNoController.text);
                              //sendOtp(mobileNoController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerifyOTPPageScreen()));
                            } else {
                              print("invalid data");
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Future sendOtp(String phoneNumber) async {
    mobileNo = mobileNoController.text;

    print("mobileNoInSendOtp = $mobileNo");

    final response = await http.post(
      Uri.parse("https://helicoreraj.pythonanywhere.com/otp_gen/"),
      body: jsonEncode({"phone": mobileNo}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
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
  } */
}
