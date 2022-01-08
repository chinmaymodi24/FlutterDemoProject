import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/HomePageScreen1.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_demo_project/pages/LoginPageScreen1.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../images.dart';
import '../user_model.dart';

class SignUpPageScreen2 extends StatefulWidget {
  @override
  _MyStateSignUpPageScreen2 createState() => _MyStateSignUpPageScreen2();
}

var createdUserToken;
var createdUserToken1;

enum SakhaChoice {
  VadnagraNagarBrahmin,
  VisnagraNagarBrahmin,
  SathodraNagarBrahmin,
  PrashnoraNagarBrahmin,
  KrushnoraNagarBrahmin,
  BandharaNagarBrahmin,
  ChandraNagarBrahmin,
}

class _MyStateSignUpPageScreen2 extends State<SignUpPageScreen2> {
  var errorMsg;
  String sakha;

  String selectedSakhaValue = 'Sakha';
  List<String> spinnerItems = [
    'Sakha',
    'Vadnagra Nagar Brahmin',
    'Visnagra Nagar Brahmin',
    'Sathodra Nagar Brahmin',
    'Prashnora Nagar Brahmin',
    'Krushnora Nagar Brahmin',
    'Bandhara Nagar Brahmin',
    'Chandra Nagar Brahmin',
  ];

  Future<UserModel> createUser(
      String birthDate,
      String bloodGroup,
      String currentHome,
      String degree,
      String education,
      String familySurname,
      String fathername,
      String firstName,
      String gender,
      String gotra,
      String imageType,
      String maritialStatus,
      String mobileNo,
      String mothername,
      String occupation,
      String officialSurname,
      String otherInfo,
      String profileImage,
      String sakha,
      String village,
      String college,
      String passyear,
      String email,
      String password) async {
    final String apiUrl = "https://helicoreraj.pythonanywhere.com/register/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "BirthDate": birthDate,
        "BloodGroup": bloodGroup,
        "CurrentHome": currentHome,
        "Degree": degree,
        "Education": education,
        "FamilySurname": familySurname,
        "Fathername": fathername,
        "FirstName": firstName,
        "Gender": gender,
        "Gotra": gotra,
        "ImageType": imageType,
        "MaritialStatus": maritialStatus,
        "MobileNo": mobileNo,
        "Mothername": mothername,
        "Occupation": occupation,
        "OfficialSurname": officialSurname,
        "OtherInfo": otherInfo,
        "ProfileImage": profileImage,
        "Sakha": sakha,
        "Village": village,
        "college": college,
        "passyear": passyear,
        "email": email,
        "password": password,
      }),
      headers: {
        'Content-type': 'application/json',
        //'Accept': 'application/json',
      },
    );

    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("responseString = $responseString");

      //to access error field
      var decodedJson = json.decode(responseString);
      //print("decodedJson = $decodedJson");
      errorMsg = decodedJson['error'];

      //print("Msg = $errorMsg");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$errorMsg"),
        backgroundColor: Colors.amber,
      ));

      var splitToken = responseString.split(',');
      var token = splitToken[1].split(':');
      createdUserToken = token[1].split('"');

      //print("finalToken[0] = ${createdUserToken[0]}");
      print("finalToken[1] = ${createdUserToken[1]}");
      createdUserToken1 = createdUserToken[1];

      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  UserModel _user;

  var data;
  var langSelectLength;

  Future<SakhaChoice> _sakhaDialog(BuildContext context) async {
    return await showDialog<SakhaChoice>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Martial Status '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.VadnagraNagarBrahmin);
                  sakhaController.text = "Vadnagra Nagar Brahmin";
                  sakha = "1";
                },
                child: const Text('Vadnagra Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.VisnagraNagarBrahmin);
                  sakhaController.text = "Visnagra Nagar Brahmin";
                  sakha = "2";
                },
                child: const Text('Visnagra Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.KrushnoraNagarBrahmin);
                  sakhaController.text = "Krushnora Nagar Brahmin";
                  sakha = "3";
                },
                child: const Text('Krushnora Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.SathodraNagarBrahmin);
                  sakhaController.text = "Sathodra Nagar Brahmin";
                  sakha = "4";
                },
                child: const Text('Sathodra Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.PrashnoraNagarBrahmin);
                  sakhaController.text = "Prashnora Nagar Brahmin";
                  sakha = "5";
                },
                child: const Text('Prashnora Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.BandharaNagarBrahmin);
                  sakhaController.text = "Bandhara Nagar Brahmin";
                  sakha = "6";
                },
                child: const Text('Bandhara Nagar Brahmin'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, SakhaChoice.ChandraNagarBrahmin);
                  sakhaController.text = "Chandra Nagar Brahmin";
                  sakha = "7";
                },
                child: const Text('Chandra Nagar Brahmin'),
              ),
            ],
          );
        });
  }

  /* Future _sakhaDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Sakha '),
            children: <Widget>[
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    langSelectLength == null ? 0 : langSelectLength.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: SimpleDialog(
                      title: const Text('Select Martial Status '),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(
                                context, AddFamilyMaritalStatus.Married);
                            maritalStatusController.text = "Married";
                          },
                          child: const Text('Married'),
                        ),
                      ],
                    ),

                    /* child: SimpleDialogOption(
                      onPressed: () {
                        print(
                            "${jsonDecode(data)['subcaste'][index]['SubcasteID']}");
                        print(
                            "${jsonDecode(data)['subcaste'][index]['SubcasteName']}");
                        userchoiceString =
                            jsonDecode(data)['subcaste'][index]['SubcasteName'];
                        userchoiceInt = jsonDecode(data)['subcaste'][index]
                                ['SubcasteID']
                            .toString();

                        print("userchoiceString = $userchoiceString");

                        sakhaController.text = userchoiceString.toString();
                        Navigator.pop(context);
                      },
                      child: Text(
                          jsonDecode(data)['subcaste'][index]['SubcasteName']),
                    ), */

                    /* child: InkWell(
                      onTap: () {
                        /* userchoiceInt =
                            jsonDecode(data)['subcaste'][index]['SubcasteID']; */
                        print(
                            "${jsonDecode(data)['subcaste'][index]['SubcasteID']}");
                        print(
                            "${jsonDecode(data)['subcaste'][index]['SubcasteName']}");
                        userchoiceString =
                            jsonDecode(data)['subcaste'][index]['SubcasteName'];
                        userchoiceInt = jsonDecode(data)['subcaste'][index]
                                ['SubcasteID']
                            .toString();

                        print("userchoiceString = $userchoiceString");

                        sakhaController.text = userchoiceString.toString();
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        /* title: Text(jsonDecode(data)['subcaste'][index]
                                ['SubcasteID']
                            .toString()),  */
                        subtitle: Text(jsonDecode(data)['subcaste'][index]
                            ['SubcasteName']),
                      ),
                    ),
                   */
                  );
                },
              ),
              /* SimpleDialogOption(  
              onPressed: () {  
              },  
              child: const Text('Apple'),  
            ),   */
            ],
          );
        });
  }

 */

  void getSubcasteData() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/subcaste/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        langSelectLength =
            jsonDecode(data)['subcaste']; //get all the data from json string

        print(langSelectLength.length); // just printed length of data
      });

      //var venam = jsonDecode(data)['subcaste'][4]['url'];

      //print(venam);
    } else {
      print(response.statusCode);
    }
  }

  /* old working code
  getSubCaste() async {
    http.Response response = await http
        .get(Uri.parse("https://helicoreraj.pythonanywhere.com/subcaste/"));

    if (response.statusCode == 200) {
      data = json.decode(response.body); //store response as string
      //var data = json.decode(utf8.decode(response.bodyBytes));

      //print("data = $data");

      setState(() {
        langSelectLength =
            (data)['subcaste']; //get all the data from json string data

        //print(langSelectLength); // just printed length of data
      });

      subcasteID = (data)['subcaste'][1]['SubcasteID'];
      subcasteName = (data)['subcaste'][1]['SubcasteName'];

      print("subcasteID = $subcasteID");
      print("subcasteName = $subcasteName");
    }
    return [
      subcasteID,
      subcasteName,
    ];
  }*/

  @override
  void initState() {
    super.initState();
    getSubcasteData();
    //getSubCaste();
  }

  DateTime _date = DateTime(17, 11, 2020);
  String _date1;

  final _formKeySignUp = new GlobalKey<FormState>();

  String name;
  String email;
  String mobileNo;
  String gotra;
  String password;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController gotraController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController sakhaController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
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
                  "Sign Up",
                  style: TextStyle(
                      color: new Color(0xff4A4B4D),
                      fontSize: 30,
                      fontFamily: 'Metropolis-ExtraBold'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 18.0, 10.0, 0.0),
                child: Text(
                  "Add your details to sign up",
                  style: TextStyle(
                      color: new Color(0xff7C7D7E),
                      fontSize: 14,
                      fontFamily: 'Metropolis-Medium'),
                ),
              ),
              Form(
                key: _formKeySignUp,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 20.0),
                      child: TextFormField(
                        controller: firstNameController,
                        onSaved: (val) => name = val,
                        autocorrect: false,
                        maxLength: 20,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(errorText: "*Required"),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4A4B4D), width: 1.0),
                          ),
                          labelText: 'FirstName',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
                      child: TextFormField(
                        controller: emailSignUpController,
                        onSaved: (val) => email = val,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "*Required"),
                          EmailValidator(errorText: "Please enter valid email")
                        ]),
                        maxLength: 25,
                        maxLines: 1,
                        cursorColor: Colors.black,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
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
                              errorText: "Phone number should be 10 digits")
                        ]),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4A4B4D), width: 1.0),
                          ),
                          labelText: 'Mobile No',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
                      child: TextFormField(
                        controller: gotraController,
                        onSaved: (val) => name = val,
                        autocorrect: false,
                        maxLength: 10,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(errorText: "*Required"),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4A4B4D), width: 1.0),
                          ),
                          labelText: 'Gotra',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 20.0),
                      child: TextFormField(
                        controller: birthDateController,
                        enableInteractiveSelection: false,
                        readOnly: true,
                        validator: RequiredValidator(errorText: "Required"),
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(1945, 1, 1),
                              maxTime: DateTime(2022, 12, 31),
                              onConfirm: (date) {
                            print('confirm $date');
                            _date1 =
                                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                            setState(
                              () {
                                birthDateController.text = _date1;

                                print("date = $date");

                                print(
                                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                                        .toString()
                                        .padLeft(2, '0'));
                              },
                            );
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        autocorrect: false,
                        maxLength: 10,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText:
                              _date1 != "$_date1" ? "Birth Date" : "$_date1",
                          suffixIcon: Image.asset(
                            Images.IcCalendarPng,
                            height: 14,
                            width: 14,
                          ),
                          counterText: '',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4A4B4D), width: 1.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: TextFormField(
                        controller: sakhaController,
                        enableInteractiveSelection: false,
                        readOnly: true,
                        onTap: () {
                          _sakhaDialog(context);
                        },
                        autocorrect: false,
                        maxLength: 10,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(errorText: "*Required"),
                        decoration: InputDecoration(
                          hintText: "Sakha",
                          counterText: '',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4A4B4D), width: 1.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular'),
                        ),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            _asyncSimpleDialog(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedSakhaValue,
                                icon: Icon(Icons.expand_more),
                                iconSize: 30,
                                style: TextStyle(
                                    color: new Color(0xff4A4B4D),
                                    fontSize: 14,
                                    fontFamily: 'Roboto-Regular'),
                                onChanged: (String data) {
                                  setState(() {
                                    selectedSakhaValue = data;
                                    print("$selectedSakhaValue");
                                  });
                                },
                                items: spinnerItems.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                     */
                    /* Text(
                        'Selected Item = ' + '$dropdownValue',
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ), */
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
                      child: TextFormField(
                        obscureText: true,
                        onSaved: (val) => password = val,
                        autocorrect: false,
                        controller: passwordSignUpController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "*Required"),
                          MinLengthValidator(5,
                              errorText: "Password must have 5 characters"),
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
              /* ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    langSelectLength == null ? 0 : langSelectLength.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        print(
                            "${jsonDecode(data)['subcaste'][index]['SubcasteID']}");
                      },
                      child: ListTile(
                        /* title: Text(jsonDecode(data)['subcaste'][index]
                                ['SubcasteID']
                            .toString()),  */
                        subtitle: Text(jsonDecode(data)['subcaste'][index]
                            ['SubcasteName']),
                      ),
                    ),
                  );
                },
              ), */
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 20.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: new Color(0xff0B4328),
                            fontSize: 14,
                            fontFamily: 'Metropolis-Medium'),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Color(0xff0B4328), width: 1),
                    ),
                    onPressed: () async {
                      //log("birthDateController = $_date1");

                      final String birthDate = _date1;
                      //final String birthDate = "2021-08-02";
                      final String bloodGroup = "";
                      final String currentHome = "";
                      final String degree = "";
                      final String education = "";
                      final String familySurname = "";
                      final String fathername = "";
                      final String firstName = firstNameController.text;
                      final String gender = "";
                      final String gotra = gotraController.text;
                      final String imageType = "";
                      final String maritialStatus = "";
                      final String mobileNo = mobileNoController.text;
                      final String mothername = "";
                      final String occupation = "";
                      final String officialSurname = "";
                      final String otherInfo = "";
                      final String profileImage = "";
                      final String village = "";
                      final String college = "";
                      final String passyear = "";
                      final String email = emailSignUpController.text;
                      final String password = passwordSignUpController.text;

                      if (_formKeySignUp.currentState.validate()) {
                        final UserModel user = await createUser(
                            birthDate,
                            bloodGroup,
                            currentHome,
                            degree,
                            education,
                            familySurname,
                            fathername,
                            firstName,
                            gender,
                            gotra,
                            imageType,
                            maritialStatus,
                            mobileNo,
                            mothername,
                            occupation,
                            officialSurname,
                            otherInfo,
                            profileImage,
                            sakha,
                            village,
                            college,
                            passyear,
                            email,
                            password);

                        setState(() {
                          _user = user;
                        });

                        print("createdUserToken1 = $createdUserToken1");

                        final pref = await SharedPreferences.getInstance();
                        pref.setString(
                            "savedUserId", createdUserToken1.toString());
                        pref.setString(
                            "savedUserName", firstNameController.text);
                        pref.setString(
                            "savedUserEmail", emailSignUpController.text);
                        pref.setString(
                            "savedUserMobileNo", mobileNoController.text);
                        pref.setString("savedUserGotra", gotraController.text);
                        pref.setString("savedUserBirthDate", _date1.toString());
                        pref.setString("savedUserSakha", sakhaController.text);
                        pref.setString(
                            "savedUserPassword", passwordSignUpController.text);

                        final getUserData =
                            await SharedPreferences.getInstance();

                        var userId = getUserData.getString("savedUserId");
                        var userName = getUserData.getString("savedUserName");
                        var useremail = getUserData.getString("savedUserEmail");
                        var userMobileNo =
                            getUserData.getString("savedUserMobileNo");
                        var userGotra = getUserData.getString("savedUserGotra");
                        var userBirthdate =
                            getUserData.getString("savedUserBirthDate");
                        var userSakha = getUserData.getString("savedUserSakha");
                        var userPassword = pref.getString("savedUserPassword");

                        print("SavedUserId = $userId");
                        print("SavedUserName = $userName");
                        print("Saveduseremail = $useremail");
                        print("SaveduserMobileNo = $userMobileNo");
                        print("SaveduserGotra = $userGotra");
                        print("SaveduserBirthdate = $userBirthdate");
                        print("SaveduserSakha = $userSakha");
                        print("SaveduserPassword = $userPassword");

                        birthDateController.text = "";
                        gotraController.text = "";
                        mobileNoController.text = "";
                        firstNameController.text = "";
                        emailSignUpController.text = "";
                        passwordSignUpController.text = "";

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$errorMsg"),
                          backgroundColor: Colors.amber,
                        ));

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageScreen1()),
                            (route) => false);
                      } else {
                        print("not valid");
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 53.0),
                child: RichText(
                  text: TextSpan(
                    text: ("Already have an Account?"),
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Login Clicked");
                              Route route = MaterialPageRoute(
                                  builder: (context) => LoginPageScreen1());
                              Navigator.pushReplacement(context, route);
                            },
                          text: " Login",
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
    );
  }
}
