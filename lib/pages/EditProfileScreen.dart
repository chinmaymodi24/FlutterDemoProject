import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_demo_project/pages/AddFamilyPageScreen.dart';
import 'package:flutter_demo_project/user_edit_profile_model.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class EditProfilePageScreen extends StatefulWidget {
  @override
  _MyStateEditProfilePageScreen createState() =>
      _MyStateEditProfilePageScreen();
}

var userId;
// var userName;
// var useremail;
// var userMobileNo;
// var userGotra;
// var userBirthdate;
// var userSakha;
// var userPassword;

var createdUserToken;
var createdUserToken1;

class _MyStateEditProfilePageScreen extends State<EditProfilePageScreen> {
  List<int> resource;
  var profileName;
  var profileSurname;
  var profileFatherName;
  var profileMotherName;
  var profileBirthDate;
  var profileMartialStatus;
  var profileBloodGroup;
  var profileEmail;
  var profileAddress;
  var profileDegree;
  var profileClg;
  var profilePassingYear;
  var profileGotra;
  var profileSakha;
  var profileJob;
  int profileMobileNumber;

  var toBase64EditProfile;

  var result;
  var familyid;
  var getTokenId;
  var data1;

  var userEditProfileImage1;

  var lengthOfUserDetails;
  var birthdate;

  Future<UserEditProfileModel> editProfileUser(
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
  ) async {
    print("in UpdateProfile");

    final String apiUrl = "https://helicoreraj.pythonanywhere.com/update/";

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
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $userId',
      },
    );

    print("token = $userId");
    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      result = 200;
      final String responseString = response.body;
      var split = responseString.split(',');
      var token = split[1].split(':');
      createdUserToken = token[1].split('"');
      //print("finalToken[0] = ${createdUserToken[0]}");
      print("finalToken[1] = ${createdUserToken[1]}");
      createdUserToken1 = createdUserToken[1];

      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future getProfileDetails() async {
    final getUserData = await SharedPreferences.getInstance();

    getTokenId = getUserData.getString("savedUserId");
    print("GET TOKEN = $getTokenId");

    //final pref = await SharedPreferences.getInstance();
    // userProfileImage1 = pref.getString(" userProfileImage1");
    //print(" userProfileImage1 in ProfilePageScreen = $ userProfileImage1");

    http.Response response = await http.get(
        Uri.parse("https://helicoreraj.pythonanywhere.com/familyview/"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $getTokenId',
        });

    if (response.statusCode == 200) {
      data1 = response.body; //store response as string

      setState(() {
        lengthOfUserDetails =
            jsonDecode(data1)['userdetail']; //get all the data from json string

        print("lengthOfUserDetails = $lengthOfUserDetails EditProfileScreen");

        profileName = jsonDecode(data1)['userdetail']['FirstName'];
        profileSurname = jsonDecode(data1)['userdetail']['FamilySurname'];
        profileFatherName = jsonDecode(data1)['userdetail']['Fathername'];
        profileMotherName = jsonDecode(data1)['userdetail']['Mothername'];
        profileBirthDate = jsonDecode(data1)['userdetail']['BirthDate'];
        profileMartialStatus =
            jsonDecode(data1)['userdetail']['MaritialStatus'];
        profileBloodGroup = jsonDecode(data1)['userdetail']['BloodGroup'];
        profileMobileNumber = jsonDecode(data1)['userdetail']['MobileNo'];
        profileEmail = jsonDecode(data1)['userdetail']['email'];
        profileAddress = jsonDecode(data1)['userdetail']['CurrentHome'];
        profileDegree = jsonDecode(data1)['userdetail']['Degree'];
        profileClg = jsonDecode(data1)['userdetail']['college'];
        profilePassingYear = jsonDecode(data1)['userdetail']['passyear'];
        profileJob = jsonDecode(data1)['userdetail']['Occupation'];
        profileGotra = jsonDecode(data1)['userdetail']['Gotra'];
        profileSakha = jsonDecode(data1)['userdetail']['Sakha'];

        userEditProfileImage1 = jsonDecode(data1)['userdetail']['ProfileImage'];
        print(
            " EditProfileImage1 in EditProfileScreen = $userEditProfileImage1");

        if (userEditProfileImage1 == "") {
          print("EditProfileImage1 is null");
        } else {
          print("EditProfileImage1 is not null");
          var stringToBase64Url = utf8.fuse(base64Url);
          toBase64EditProfile = stringToBase64Url.encode(userEditProfileImage1);
          resource = base64.decode(base64.normalize(userEditProfileImage1));
        }

        print("profileName = $profileName");
        print("profileSurname = $profileSurname");
        print("profileFatherName = $profileFatherName");
        print("profileMotherName = $profileMotherName");
        print("profileBirthDate = $profileBirthDate");
        print("profileMartialStatus = $profileMartialStatus");
        print("profileBloodGroupStatus = $profileBloodGroup");
        print("profileMobileNumber = $profileMobileNumber");
        print("profileEmail = $profileEmail");
        print("profileAddress = $profileAddress");
        print("profileDegree = $profileDegree");
        print("profileClg = $profileClg");
        print("profilePassingYear = $profilePassingYear");
        print("profileJob = $profileJob");
        print("FirstName = ${jsonDecode(data1)['userdetail']['FirstName']}");

        base64Image = userEditProfileImage1;
        print("base64ImageIn Get Function = $base64Image");

        editProfileNameController.text = profileName;
        editProfileSurnameController.text = profileSurname;
        editProfileFatherNameController.text = profileFatherName;
        editProfileMotherNameController.text = profileMotherName;
        editProfileBirthDateController.text = profileBirthDate;
        editProfileEmailController.text = profileEmail;
        editProfileAddressController.text = profileAddress;
        editProfileDegreeController.text = profileDegree;
        editProfileCollegeController.text = profileClg;
        editProfilePassingYearController.text = profilePassingYear;
        editProfileJobController.text = profileJob;
        editProfileMobileNumberController.text = profileMobileNumber.toString();

        if (profileMartialStatus == null) {
          print("profileMartialStatus = $profileMartialStatus");
        }
        if (profileMartialStatus != null) {
          print("profileMartialStatus = $profileMartialStatus");
          editProfileMaritalStatusController.text = profileMartialStatus;
        }

        if (editProfileBloodGropController == null) {
          print(
              "editProfileBloodGropController = $editProfileBloodGropController");
        }
        if (editProfileBloodGropController != null) {
          print(
              "editProfileBloodGropController = $editProfileBloodGropController");
          editProfileBloodGropController.text = profileBloodGroup;
        }

        //print("mobileNumberController.text = ${editProfileMobileNumberController.text}");
        /* print("email = ${jsonDecode(data1)['userdetail']['email']}");
        print("MobileNo = ${jsonDecode(data1)['userdetail']['MobileNo']}");
        print("data1 = ${jsonDecode(data1)['userdetail']['email']}"); */
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<AddFamilyMaritalStatus> _maritalStatusSimpleDialog(
      BuildContext context) async {
    return await showDialog<AddFamilyMaritalStatus>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Martial Status '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyMaritalStatus.Married);
                  editProfileMaritalStatusController.text = "Married";
                },
                child: const Text('Married'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyMaritalStatus.Unmarried);
                  editProfileMaritalStatusController.text = "Unmarried";
                },
                child: const Text('Unmarried'),
              ),
            ],
          );
        });
  }

  Future<AddFamilyBloodGroup> _bloodGroupSimpleDialog(
      BuildContext context) async {
    return await showDialog<AddFamilyBloodGroup>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Blood Group'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Apos);
                  editProfileBloodGropController.text = "A+";
                },
                child: const Text('A+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Bpos);
                  editProfileBloodGropController.text = "B+";
                },
                child: const Text('B+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Opos);
                  editProfileBloodGropController.text = "O+";
                },
                child: const Text('O+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.ABpos);
                  editProfileBloodGropController.text = "AB+";
                },
                child: const Text('AB+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Aneg);
                  editProfileBloodGropController.text = "A-";
                },
                child: const Text('A-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Bneg);
                  editProfileBloodGropController.text = "B-";
                },
                child: const Text('B-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Oneg);
                  editProfileBloodGropController.text = "O-";
                },
                child: const Text('O-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.ABneg);
                  editProfileBloodGropController.text = "AB-";
                },
                child: const Text('AB-'),
              ),
            ],
          );
        });
  }

  File imgFile;
  final imgPicker = ImagePicker();

  GlobalKey _Key = new GlobalKey();

  bool inside = false;
  Uint8List imageInMemory;

  String base64Image;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      inside = true;
      RenderRepaintBoundary boundary = _Key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      String bs64 = base64Encode(pngBytes);
      debugPrint("pngBytes = $pngBytes");
      debugPrint("bs64 $bs64");
      print('png done');
      setState(() {
        imageInMemory = pngBytes;
        inside = false;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      //openCamera();
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      //openGallery();
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  File _selectedFile;
  bool _inProcess = false;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      //log("_selectedFile = $_selectedFile");

      final bytes = _selectedFile.readAsBytesSync();
      String _img64 = base64Encode(bytes);

      //log("_img64 = $_img64");

      base64Image = userEditProfileImage1;

      print("base64ImageValue = $base64Image");

      base64Image = base64Encode(_selectedFile.readAsBytesSync());

      print("base64ImageValue By User = $base64Image");

      String fileName = _selectedFile.path.split("/").last;

      /* print("--------------------------------");
      //log("base64Image = $base64Image");
      print("--------------------------------");
      print("fileName = $fileName"); */
      //final byttes = Io.File('assets/images/ic_home.png').readAsBytesSync();

      return Stack(
        clipBehavior: Clip.none,
        children: [
          RepaintBoundary(
            key: _Key,
            child: CircleAvatar(
              radius: 60.0,
              child: ClipRRect(
                child: Image.file(_selectedFile),
                borderRadius: BorderRadius.circular(70.0),
              ),
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: () {
                print("camera image clicked");
                showOptionsDialog(context);
              },
              child: Image.asset(
                Images.ImgChangeUserProfile,
                scale: 0.1,
              ),
            ),
            right: 0,
            top: 92,
            bottom: 0,
            left: 1,
          ),
        ],
      );
    } else {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          //resource == null ? Text("resource null") : Text("resource not null"),
          //toBase64EditProfile != null ? Text("not null") : Text("null"),
          resource != null
              ? CircleAvatar(
                  radius: 60.0,
                  child: ClipRRect(
                    child: Image.memory(
                      resource,
                    ),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                )
              : CircleAvatar(
                  radius: 60.0,
                  backgroundImage: ExactAssetImage(Images.ImgNoUserProfileJpg),
                ),
          Positioned(
            child: InkWell(
              onTap: () {
                print("camera image clicked");
                showOptionsDialog(context);
              },
              /* child: CircleAvatar(
                radius: 160,
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ), */

              /* child: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ), */
              child: Image.asset(
                Images.ImgChangeUserProfile,
                scale: 0.2,
              ),
            ),
            right: 0,
            top: 92,
            bottom: 0,
            left: 1,
          ),
        ],
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.png,
          androidUiSettings: AndroidUiSettings(
            statusBarColor: Colors.black,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  UserEditProfileModel _user;

  final _formKeyEditProfile = new GlobalKey<FormState>();

  TextEditingController editProfileNameController = TextEditingController();
  TextEditingController editProfileSurnameController = TextEditingController();
  TextEditingController editProfileFatherNameController =
      TextEditingController();
  TextEditingController editProfileMotherNameController =
      TextEditingController();
  TextEditingController editProfileBirthDateController =
      TextEditingController();
  TextEditingController editProfileMaritalStatusController =
      TextEditingController();
  TextEditingController editProfileBloodGropController =
      TextEditingController();
  TextEditingController editProfileMobileNumberController =
      TextEditingController();
  TextEditingController editProfileEmailController = TextEditingController();
  TextEditingController editProfileAddressController = TextEditingController();
  TextEditingController editProfileDegreeController = TextEditingController();
  TextEditingController editProfileCollegeController = TextEditingController();
  TextEditingController editProfilePassingYearController =
      TextEditingController();
  TextEditingController editProfileJobController = TextEditingController();

  DateTime _birthDatePicker = DateTime(2020, 11, 17);
  String _birthDateStringValue = "YYYY-MM-DD";

  String editProfileBloodGroupValue = 'Not set';
  List<String> editProfileBloodGroupItems = [
    'Not set',
    'A+',
    'O+',
    'B+',
    'AB+',
    'A-',
    'O-',
    'B-',
    'AB-'
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
    print("------getUserData();IN EditProfileScreen------");
    getProfileDetails();
  }

  /* String editProfileMartialStatusValue = 'Not Set';
  List<String> editProfileMartialStatusItems = [
    'Not Set',
    'Married',
    'Unmarried'
  ];*/

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _birthDatePicker,
      firstDate: DateTime(1947, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _birthDatePicker = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 18.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.navigate_before,
                          size: 28,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 24,
                              fontFamily: 'Metropolis-ExtraBold'),
                        ),
                      ),
                    ],
                  ),
                ),
                profileEmail == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: AwesomeLoader(
                            loaderType: AwesomeLoader.AwesomeLoader3,
                            color: Colors.orange,
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 30.0, 20.0, 0.0),
                            child: getImageWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 14.0, 20.0, 0.0),
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                  color: new Color(0xff4A4B4D),
                                  fontSize: 20,
                                  fontFamily: 'Metropolis-Bold'),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ExpansionTile(
                            initiallyExpanded: true,
                            ////iconColor: Colors.black,
                            title: Text(
                              "Name Info.",
                              style: TextStyle(
                                  color: Color(0xff4A4B4D),
                                  fontFamily: 'Metropolis-Bold',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              Container(
                                color: Color(0xffF6F6F6),
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 10.0),
                                child: Form(
                                  key: _formKeyEditProfile,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: editProfileNameController,
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        validator: RequiredValidator(
                                            errorText: "*Required"),
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Name (Required)",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            editProfileSurnameController,
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Surname",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            editProfileFatherNameController,
                                        maxLength: 15,
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          suffixIcon: Image.asset(
                                            Images.IcEditPng,
                                            height: 14,
                                            width: 14,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Father / Husband Name",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            editProfileMotherNameController,
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Mother Name",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      /* TextField(
                                  onTap: _selectDate,
                                  style: TextStyle(
                                      color: new Color(0xff4A4B4D),
                                      fontSize: 14,
                                      fontFamily: 'Metropolis-Medium'),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: "$_date",
                                    suffixIcon: Image.asset(
                                      Images.IcCalendarPng,
                                      height: 14,
                                      width: 14,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Color(0xff4A4B4D))),
                                    labelText: "*Birth Date",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        color: new Color(0xff4A4B4D),
                                        fontSize: 14,
                                        fontFamily: 'Metropolis-Regular'),
                                  ),
                                ), */
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: TextFormField(
                                          controller:
                                              editProfileBirthDateController,
                                          enableInteractiveSelection: false,
                                          readOnly: true,
                                          validator: RequiredValidator(
                                              errorText: "*Required"),
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
                                              _birthDateStringValue =
                                                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                                              editProfileBirthDateController
                                                  .text = _birthDateStringValue;

                                              print(
                                                  "date = $_birthDateStringValue");

                                              print(
                                                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                                                      .toString()
                                                      .padLeft(2, '0'));
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.en);
                                          },
                                          style: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Medium'),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4.0),
                                            hintText: "$_birthDateStringValue",
                                            suffixIcon: Image.asset(
                                              Images.IcCalendarPng,
                                              height: 14,
                                              width: 14,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff4A4B4D))),
                                            labelText: "Birth Date (Required)",
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            labelStyle: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily:
                                                    'Metropolis-Regular'),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            editProfileMaritalStatusController,
                                        enableInteractiveSelection: false,
                                        readOnly: true,
                                        onTap: () {
                                          _maritalStatusSimpleDialog(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Marital Status",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            editProfileBloodGropController,
                                        enableInteractiveSelection: false,
                                        readOnly: true,
                                        onTap: () {
                                          _bloodGroupSimpleDialog(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        style: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Medium'),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          labelText: "Blood Group",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      /* Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "*Marital Status",
                                          style: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 11,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      Container(
                                        height: 26,
                                        padding: EdgeInsets.only(right: 6.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value:
                                                editProfileMartialStatusValue,
                                            icon: Icon(Icons.expand_more),
                                            iconSize: 30,
                                            style: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Regular'),
                                            onChanged: (String data) {
                                              setState(() {
                                                editProfileMartialStatusValue =
                                                    data;
                                                print(
                                                    "martialStatusValue = $editProfileMartialStatusValue");
                                                print(
                                                    "martialStatusItems = $editProfileMartialStatusValue");
                                              });
                                            },
                                            items: editProfileMartialStatusItems
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      /* Container(
                                  height: 26,
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: editProfileMartialStatusValue,
                                      icon: Icon(Icons.expand_more),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Roboto-Regular'),
                                      onChanged: (String data) {
                                        setState(() {
                                          editProfileMartialStatusValue = data;
                                        });
                                      },
                                      items: editProfileMartialStatusItems
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ), */
                                      Divider(
                                        color: Color(0xff707070),
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          "Blood Group",
                                          style: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 11,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      Container(
                                        height: 26,
                                        padding: EdgeInsets.only(right: 6.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: editProfileBloodGroupValue,
                                            icon: Icon(Icons.expand_more),
                                            iconSize: 30,
                                            style: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Regular'),
                                            onChanged: (String data) {
                                              setState(() {
                                                editProfileBloodGroupValue =
                                                    data;
                                              });
                                            },
                                            items: editProfileBloodGroupItems
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Color(0xff707070),
                                        thickness: 1,
                                      ),
                                    */
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            //iconColor: Colors.black,
                            title: Text(
                              "Contact Info.",
                              style: TextStyle(
                                  color: Color(0xff4A4B4D),
                                  fontFamily: 'Metropolis-Bold',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              Container(
                                color: Color(0xffF6F6F6),
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller:
                                          editProfileMobileNumberController,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator: RequiredValidator(
                                          errorText: "*Required"),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Mobile Number (Required)",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: editProfileEmailController,
                                      maxLength: 30,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      validator: RequiredValidator(
                                          errorText: "*Required"),
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: editProfileAddressController,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        suffixIcon: Image.asset(
                                          Images.IcEditPng,
                                          height: 14,
                                          width: 14,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Address",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            //iconColor: Colors.black,
                            title: Text(
                              "Education Info.",
                              style: TextStyle(
                                  color: Color(0xff4A4B4D),
                                  fontFamily: 'Metropolis-Bold',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              Container(
                                color: Color(0xffF6F6F6),
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: editProfileDegreeController,
                                      maxLength: 30,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Degree",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: editProfileCollegeController,
                                      maxLength: 30,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        suffixIcon: Image.asset(
                                          Images.IcEditPng,
                                          height: 14,
                                          width: 14,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "College / University",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    TextFormField(
                                      controller:
                                          editProfilePassingYearController,
                                      maxLength: 4,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Passing Year",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    /* Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: passingYearController,
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime(2000, 1, 1),
                                        maxTime: DateTime(2022, 12, 31),
                                        onConfirm: (date) {
                                      print('confirm $date');
                                      _passingYearDateStringValue =
                                          '${date.year}-${date.month}-${date.day}';
                                      setState(() {});
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  style: TextStyle(
                                      color: new Color(0xff4A4B4D),
                                      fontSize: 14,
                                      fontFamily: 'Metropolis-Medium'),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    hintText: "$_passingYearDateStringValue",
                                    suffixIcon: Image.asset(
                                      Images.IcCalendarPng,
                                      height: 14,
                                      width: 14,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff4A4B4D))),
                                    labelText: "Passing Year",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                        color: new Color(0xff4A4B4D),
                                        fontSize: 14,
                                        fontFamily: 'Metropolis-Regular'),
                                  ),
                                ),
                              ),
                             */
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            //iconColor: Colors.black,
                            title: Text(
                              "Occupation Info.",
                              style: TextStyle(
                                  color: Color(0xff4A4B4D),
                                  fontFamily: 'Metropolis-Bold',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: <Widget>[
                              Container(
                                color: Color(0xffF6F6F6),
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: editProfileJobController,
                                      maxLength: 20,
                                      textInputAction: TextInputAction.done,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Metropolis-Medium'),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff4A4B4D))),
                                        labelText: "Job",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          screenWidth < 320
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: TextButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 70.0, vertical: 20.0),
                                        child: Text(
                                          'Save Profile',
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
                                        final String birthDate =
                                            editProfileBirthDateController.text;
                                        /* String bloodGroup =
                                      editProfileBloodGroupValue; */
                                        final String bloodGroup =
                                            editProfileBloodGropController.text;
                                        final String currentHome =
                                            editProfileAddressController.text;
                                        final String degree =
                                            editProfileDegreeController.text;
                                        final String education = "";
                                        final String familySurname =
                                            editProfileSurnameController.text;
                                        final String fathername =
                                            editProfileFatherNameController
                                                .text;
                                        final String firstName =
                                            editProfileNameController.text;
                                        final String gender = "";
                                        final String gotra = profileGotra;
                                        final String imageType = ".png";
                                        //String maritialStatus = editProfileMartialStatusValue;
                                        String maritialStatus =
                                            editProfileMaritalStatusController
                                                .text;
                                        final String mobileNo =
                                            editProfileMobileNumberController
                                                .text;
                                        final String mothername =
                                            editProfileMotherNameController
                                                .text;
                                        final String occupation =
                                            editProfileJobController.text;
                                        final String officialSurname = "";
                                        final String otherInfo = "";
                                        String profileImage;

                                        print("base64Image = $base64Image");

                                        if (base64Image == null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is null");
                                          profileImage = "";
                                        }
                                        if (base64Image != null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is not null");
                                          profileImage = base64Image;
                                        }

                                        print(
                                            "gotraWhenSubmit = $profileGotra");
                                        print(
                                            "sakhaWhenSubmit = $profileSakha");

                                        final String sakha = profileSakha;
                                        final String village = "";
                                        final String college =
                                            editProfileCollegeController.text;
                                        final String passingYear =
                                            editProfilePassingYearController
                                                .text;
                                        final String email =
                                            editProfileEmailController.text;

                                        if (_formKeyEditProfile.currentState
                                            .validate()) {
                                          print("in if condition");

                                          final UserEditProfileModel user =
                                              await editProfileUser(
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
                                            passingYear,
                                            email,
                                          );

                                          setState(() {
                                            _user = user;
                                          });

                                          if (result == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Profile Updated Successfully"),
                                              backgroundColor: Colors.amber,
                                            ));

                                            Navigator.pop(context);
                                          }

                                          print("Edit Profile Successfully");
                                        } else {
                                          print("not valid");
                                        }
                                      }),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: TextButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 70.0, vertical: 20.0),
                                        child: Text(
                                          'Save Profile',
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
                                        final String birthDate =
                                            editProfileBirthDateController.text;
                                        /* String bloodGroup =
                                      editProfileBloodGroupValue; */
                                        final String bloodGroup =
                                            editProfileBloodGropController.text;
                                        final String currentHome =
                                            editProfileAddressController.text;
                                        final String degree =
                                            editProfileDegreeController.text;
                                        final String education = "";
                                        final String familySurname =
                                            editProfileSurnameController.text;
                                        final String fathername =
                                            editProfileFatherNameController
                                                .text;
                                        final String firstName =
                                            editProfileNameController.text;
                                        final String gender = "";
                                        final String gotra = profileGotra;
                                        final String imageType = ".png";
                                        //String maritialStatus = editProfileMartialStatusValue;
                                        String maritialStatus =
                                            editProfileMaritalStatusController
                                                .text;
                                        final String mobileNo =
                                            editProfileMobileNumberController
                                                .text;
                                        final String mothername =
                                            editProfileMotherNameController
                                                .text;
                                        final String occupation =
                                            editProfileJobController.text;
                                        final String officialSurname = "";
                                        final String otherInfo = "";

                                        String profileImage;
                                        
                                        if (base64Image != null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is not null");
                                          profileImage = base64Image;
                                        }

                                        print(
                                            "gotraWhenSubmit = $profileGotra");
                                        print(
                                            "sakhaWhenSubmit = $profileSakha");

                                        final String sakha = profileSakha;
                                        final String village = "";
                                        final String college =
                                            editProfileCollegeController.text;
                                        final String passingYear =
                                            editProfilePassingYearController
                                                .text;
                                        final String email =
                                            editProfileEmailController.text;

                                        if (_formKeyEditProfile.currentState
                                            .validate()) {
                                          print("in if condition");

                                          final UserEditProfileModel user =
                                              await editProfileUser(
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
                                            passingYear,
                                            email,
                                          );

                                          setState(() {
                                            _user = user;
                                          });

                                          if (result == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Profile Updated Successfully"),
                                              backgroundColor: Colors.amber,
                                            ));

                                            Navigator.pop(context);
                                          }

                                          print("Edit Profile Successfully");
                                        } else {
                                          print("not valid");
                                        }
                                      }),
                                ),
                          SizedBox(height: 30.0),
                        ],
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getUserData() async {
    final getUserData = await SharedPreferences.getInstance();

    userId = getUserData.getString("savedUserId");
    /* userName = getUserData.getString("savedUserName");
    useremail = getUserData.getString("savedUserEmail");
    userMobileNo = getUserData.getString("savedUserMobileNo");
    userGotra = getUserData.getString("savedUserGotra");
    userBirthdate = getUserData.getString("savedUserBirthDate");
    userSakha = getUserData.getString("savedUserSakha");
    userPassword = getUserData.getString("savedUserPassword"); */

    print("SavedUserId = $userId");
    /* print("SavedUserName = $userName");
    print("Saveduseremail = $useremail");
    print("SaveduserMobileNo = $userMobileNo");
    print("SaveduserGotra = $userGotra");
    print("SaveduserBirthdate = $userBirthdate");
    print("SaveduserSakha = $userSakha");
    print("SaveduserPassword = $userPassword");

    nameController.text = userName;
    birthDateController.text = userBirthdate;

    mobileNumberController.text = userMobileNo; */
  }
}
