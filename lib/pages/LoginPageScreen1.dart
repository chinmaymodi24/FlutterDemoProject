import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/HomePageScreen1.dart';
import 'package:flutter_demo_project/pages/ResetPasswordScreen.dart';
import 'package:flutter_demo_project/pages/SignUpPageScreen2.dart';
import 'package:flutter_demo_project/strings.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../user_model1.dart';

class LoginPageScreen1 extends StatefulWidget {
  @override
  _MyStateLoginPageScreen createState() => _MyStateLoginPageScreen();
}

var createdLoginUserToken;
var createdLoginUserToken1;

class _MyStateLoginPageScreen extends State<LoginPageScreen1> {
  var errorMsg;
  var result;

  Future<UserModel1> loginUser(String mobileNo, String password) async {
    final String apiUrl = "https://helicoreraj.pythonanywhere.com/login/";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({"MobileNo": mobileNo, "password": password}),
    );

    //print("response.body = ${response.body}");
    print("response.headers = ${response.headers}");

    if (response.statusCode == 200) {
      result = 200;
      final String responseString = response.body;

      var decodedJson = json.decode(responseString);
      //print("decodedJson = $decodedJson");
      errorMsg = decodedJson['error'];
      print("Msg from response 200 = $errorMsg");

      _displaySnackBar(context);

      var split = responseString.split(',');
      var token = split[1].split(':');
      createdLoginUserToken = token[1].split('"');
      print("finalToken[1] = ${createdLoginUserToken[1]}");
      createdLoginUserToken1 = createdLoginUserToken[1];

      return userModelFromJson1(responseString);
    } else {
      return null;
    }
  }

  UserModel1 _user;
  String mobileNo;

  final _formLoginKey = new GlobalKey<FormState>();

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: Scaffold(
        key: _scaffoldKey,
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
                    "Login",
                    style: TextStyle(
                        color: new Color(0xff4A4B4D),
                        fontSize: 30,
                        fontFamily: 'Metropolis-ExtraBold'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 18.0, 10.0, 0.0),
                  child: Text(
                    "Add your details to login",
                    style: TextStyle(
                        color: new Color(0xff7C7D7E),
                        fontSize: 14,
                        fontFamily: 'Metropolis-Medium'),
                  ),
                ),
                Form(
                  key: _formLoginKey,
                  child: Column(
                    children: [
                      /* //TextField with Email Validation
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 20.0),
                        child: TextFormField(
                          controller: emailController,
                          onSaved: (val) => email = val,
                          autocorrect: false,
                          autofocus: false,
                          maxLength: 30,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          //validator: RequiredValidator(errorText: "*Required"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            EmailValidator(
                                errorText: "Please enter valid email")
                          ]),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                       */
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 20.0),
                        child: TextFormField(
                          controller: mobileNoController,
                          onSaved: (val) => mobileNo = val,
                          autocorrect: false,
                          autofocus: false,
                          maxLength: 10,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          //validator: RequiredValidator(errorText: "*Required"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            MinLengthValidator(10,
                                errorText: "Mobile Number must have 10 digits")
                          ]),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: 'Mobile Number',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
                        child: TextFormField(
                          obscureText: true,
                          //old validation
                          autocorrect: false,
                          autofocus: false,
                          maxLength: 10,
                          maxLines: 1,
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          validator: MultiValidator([
                            RequiredValidator(errorText: " *Required"),
                          ]),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                                color: new Color(0xff4A4B4D),
                                fontSize: 14,
                                fontFamily: 'Roboto-Regular'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResetPasswordPageScreen()));
                      },
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                            color: new Color(0xff7C7D7E),
                            fontSize: 14,
                            fontFamily: 'Metropolis-Medium'),
                      ),
                    ),
                  ),
                ),
                screenWidth < 322
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 20.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: new Color(0xff0B4328),
                                    fontSize: 14,
                                    fontFamily: 'Metropolis-Medium'),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: Color(0xff0B4328), width: 1),
                            ),
                            onPressed: () async {
                              final String mobileNo = mobileNoController.text;
                              final String password = passwordController.text;

                              if (_formLoginKey.currentState.validate()) {
                                final UserModel1 user =
                                    await loginUser(mobileNo, password);

                                setState(() {
                                  _user = user;
                                });

                                final pref =
                                    await SharedPreferences.getInstance();
                                pref.setString(
                                    "loginUserId", createdLoginUserToken1);
                                pref.setString("loginUserMobileNo",
                                    mobileNoController.text);
                                pref.setString("loginUserPassword",
                                    passwordController.text);

                                final getUserData =
                                    await SharedPreferences.getInstance();

                                var userId =
                                    getUserData.getString("loginUserId");
                                var userMobileNo =
                                    getUserData.getString("loginUserMobileNo");
                                var userPassword =
                                    pref.getString("loginUserPassword");

                                print("loginUserId = $userId");
                                print("loginuserMobileNo = $userMobileNo");
                                print("loginuserPassword = $userPassword");

                                mobileNoController.text = "";
                                passwordController.text = "";

                                print("Msg from else = $errorMsg");

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePageScreen1()),
                                    (route) => false);
                              } else {
                                print("not valid");
                                print("Msg from else = $errorMsg");
                              }
                            }
                            /* onPressed: () async {
                            if (formKey.currentState.validate()) {
                              loginUser(mobileNoController.text,
                                  passwordController.text);

                              print(
                                  "createdUserToken === $createdLoginUserToken1");

                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                  "loginUserMobileNo", mobileNoController.text);
                              pref.setString(
                                  "loginUserPassword", passwordController.text);

                              final getUserData =
                                  await SharedPreferences.getInstance();

                              var loginuserMobileNo =
                                  getUserData.getString("loginUserMobileNo");
                              var loginUserPassword =
                                  pref.getString("loginUserPassword");

                              print("SavedUserId = $createdLoginUserToken1");
                              print("SaveduserMobileNo = $loginuserMobileNo");
                              print("SaveduserPassword = $loginUserPassword");

                              mobileNoController.text = "";
                              passwordController.text = "";

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageScreen1()),
                                  (route) => false);
                            } else {
                              print("not valid");
                            }
                          }, */
                            ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100.0, vertical: 20.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: new Color(0xff0B4328),
                                    fontSize: 14,
                                    fontFamily: 'Metropolis-Medium'),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: Color(0xff0B4328), width: 1),
                            ),
                            onPressed: () async {
                              final String mobileNo = mobileNoController.text;
                              final String password = passwordController.text;

                              if (_formLoginKey.currentState.validate()) {
                                final UserModel1 user =
                                    await loginUser(mobileNo, password);

                                setState(() {
                                  _user = user;
                                });

                                final pref =
                                    await SharedPreferences.getInstance();

                                pref.setString(
                                    "savedUserId", createdLoginUserToken1);
                                pref.setString("loginUserMobileNo",
                                    mobileNoController.text);
                                pref.setString("loginUserPassword",
                                    passwordController.text);

                                final getUserData =
                                    await SharedPreferences.getInstance();

                                var userId =
                                    getUserData.getString("loginUserId");
                                var userMobileNo =
                                    getUserData.getString("loginUserMobileNo");
                                var userPassword =
                                    pref.getString("loginUserPassword");

                                print("loginUserId = $userId");
                                print("loginuserMobileNo = $userMobileNo");
                                print("loginuserPassword = $userPassword");

                                mobileNoController.text = "";
                                passwordController.text = "";

                                print("Msg from else = $errorMsg");

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePageScreen1()),
                                    (route) => false);
                              } else {}
                            }),
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Text(
                    "or Login With",
                    style: TextStyle(
                        color: new Color(0xff7C7D7E),
                        fontSize: 14,
                        fontFamily: 'Metropolis-Medium'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 53.0),
                  child: RichText(
                    text: TextSpan(
                      text: Strings.createAccountLabel,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Sign Up Clicked");
                                Route route = MaterialPageRoute(
                                    builder: (context) => SignUpPageScreen2());
                                Navigator.pushReplacement(context, route);
                              },
                            text: " Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0B4328),
                                fontSize: 14.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$errorMsg"),
                            backgroundColor: Colors.amber,
                          )); */
    final snackBar = SnackBar(
        content: Text("$errorMsg", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
