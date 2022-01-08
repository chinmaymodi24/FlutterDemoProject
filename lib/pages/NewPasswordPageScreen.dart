import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/HomePageScreen1.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordPageScreen extends StatefulWidget {
  @override
  _MyStateNewPasswordPageScreen createState() =>
      _MyStateNewPasswordPageScreen();
}

class _MyStateNewPasswordPageScreen extends State<NewPasswordPageScreen> {
  String password;
  String confirmPassword;
  var phoneNumber;

  final _formKeyNewPassword = new GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_before,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    "New Password",
                    style: TextStyle(
                        color: new Color(0xff4A4B4D),
                        fontSize: 30,
                        fontFamily: 'Metropolis-ExtraBold'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
                  child: Text(
                    "Please enter your email to receive a link to  create a new password via email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: new Color(0xff7C7D7E),
                        fontSize: 14,
                        fontFamily: 'Metropolis-Medium'),
                  ),
                ),
                Form(
                  key: _formKeyNewPassword,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (val) => password = val,
                          autocorrect: false,
                          controller: passwordController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            MinLengthValidator(5,
                                errorText: "Password must have 5 characters")
                          ]),
                          maxLength: 5,
                          maxLines: 1,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: 'New Password',
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
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (val) => confirmPassword = val,
                          autocorrect: false,
                          controller: confirmPasswordController,
                          validator: (_value) {
                            if (_value.isEmpty) {
                              return '*required';
                            }
                            if (_value.length < 5) {
                              return 'Password must have 5 characters';
                            }
                            if (_value != passwordController.text) {
                              return 'password does not match';
                            }
                            return null;
                          },
                          /* validator: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            MinLengthValidator(5,
                                errorText: "Password must have 5 characters"),
                          ]), */
                          maxLength: 5,
                          maxLines: 1,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4A4B4D), width: 1.0),
                            ),
                            labelText: 'Confirm Password',
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
                Padding(
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
                      side: BorderSide(color: Color(0xff0B4328), width: 1),
                    ),
                    onPressed: () {
                      if (_formKeyNewPassword.currentState.validate()) {
                        /* if (ConfirmPasswordController !=
                            passwordController.text) {
                          return 'password does not match';
                        } else { */

                        updatePassword(phoneNumber, passwordController.text,
                            confirmPasswordController.text);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageScreen1()));
                        //}
                      } else {
                        print("Invalid value");
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

  Future updatePassword(
      String mobileNumber, String newPassword, String confirmPassword) async {
    final pref = await SharedPreferences.getInstance();
    phoneNumber = pref.getString("phoneNumber");

    print("passwordController = ${passwordController.text}");
    print("confirmPasswordController = ${confirmPasswordController.text}");

    final String apiUrl = "https://helicoreraj.pythonanywhere.com/changepass/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "phone": phoneNumber,
        "NewPassword": passwordController.text,
        "ReEnter": confirmPasswordController.text
      }),
      headers: {
        'Content-type': 'application/json',
      },
    );

    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("responseString = $responseString");

      return responseString;
    } else {
      return null;
    }
  }
}
