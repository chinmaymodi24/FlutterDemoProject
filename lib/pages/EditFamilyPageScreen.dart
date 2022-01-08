import 'dart:convert';
import 'dart:async';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo_project/pages/AddFamilyPageScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_demo_project/add_family_member_model.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditFamilyMemberPageScreen extends StatefulWidget {
  @override
  _MyStateAddFamilyMemberPageScreen createState() =>
      _MyStateAddFamilyMemberPageScreen();
}

class _MyStateAddFamilyMemberPageScreen
    extends State<EditFamilyMemberPageScreen> {
  var data;
  var langSelectLength;
  var totalFamilyMembersEditFamily;
  var familyId;
  var familyId1;
  //Uint8List bytes;
  List<int> resource;

  String toBase64;

  var result;

  String getFamilyIdd;
  var getFamilyMemberType;
  var getFamilyMemberName;
  var getFamilyMemberDegree;
  var getFamilyMemberUnivercity;
  var getFamilyMemberPassingYear;
  String getFamilyMemberProfileImage;
  var getFamilyMemberBirthDate;
  var getFamilyMemberMobileNo;
  var getFamilyMemberAddress;
  var getFamilyMemberMaritialStatus;
  var getFamilyMemberOccupation;
  var getFamilyMemberBloodGroup;
  var getTokenId;

  Future<AddFamilyMember> editFamilyMember(
    String address,
    String age,
    String birthdate,
    String bloodgroup,
    String degree,
    String fathername,
    String gender,
    String maritial,
    String mobile,
    String name,
    String occupation,
    String passyear,
    String type,
    String univercity,
    String profile,
    String imageType,
  ) async {
    print("editFamilyMember getFamilyIdd = $getFamilyIdd");
    print("editFamilyMember Token = bbf2baf4c0f9130640c26de1df6584d157581491");

    final String apiUrl =
        "https://helicoreraj.pythonanywhere.com/updatefamily/$getFamilyIdd/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "address": address,
        "age": age,
        "birthdate": birthdate,
        "bloodgroup": bloodgroup,
        "degree": degree,
        "fathername": fathername,
        "gender": gender,
        "maritial": maritial,
        "mobile": mobile,
        "name": name,
        "occupation": occupation,
        "passyear": passyear,
        "type": type,
        "univercity": univercity,
        "profile": profile,
        "ImageType": imageType,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $getTokenId',
      },
    );

    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      result = 200;
      final String responseString = response.body;
      print("Response = $responseString");

      /* var split = responseString.split(',');
      var token = split[1].split(':');
      createdUserToken = token[1].split('"');
      //print("finalToken[0] = ${createdUserToken[0]}");
      print("finalToken[1] = ${createdUserToken[1]}");
      createdUserToken1 = createdUserToken[1]; */

      return userModelFromJson(responseString);
    } else {
      return null;
    }
  }

  int familyMemberIndex;
  Future getfamilyMembers() async {
    var getUserData = await SharedPreferences.getInstance();
    getTokenId = getUserData.getString("savedUserId");
    var getFamilyMemberIndex = getUserData.getString("familyMemberIndex");
    familyMemberIndex = int.parse(getFamilyMemberIndex);
    print("indexx = $familyMemberIndex");
    print("GET TOKEN = $getTokenId");

    http.Response response = await http.get(
        Uri.parse("https://helicoreraj.pythonanywhere.com/familyview/"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $getTokenId',
        });

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      final pref = await SharedPreferences.getInstance();
      getFamilyIdd = pref.getString("FamilyId");
      print("getFamilyIdInEditFamilyPageScreen = $getFamilyIdd");

      setState(() {
        langSelectLength = jsonDecode(
            data)['familydetail']; //get all the data from json string

        totalFamilyMembersEditFamily = langSelectLength.length;

        print("totalFamilyMembers : $totalFamilyMembersEditFamily");

        print(
            "langSelectLength.length = ${langSelectLength.length}"); // just printed length of data
        familyId =
            jsonDecode(data)['familydetail'][familyMemberIndex]['FamilyID'];
        familyId1 =
            jsonDecode(data)['familydetail'][familyMemberIndex]['Family_ID'];

        getFamilyMemberName = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberName'];
        getFamilyMemberType = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberType'];
        getFamilyMemberDegree = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberDegree'];
        getFamilyMemberUnivercity = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberUnivercity'];
        getFamilyMemberPassingYear = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberPassingYear'];
        getFamilyMemberProfileImage = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberProfileImage'];
        getFamilyMemberBirthDate = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberBirthDate'];
        getFamilyMemberMobileNo = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberMobileNo'];
        getFamilyMemberAddress = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberAddress'];
        getFamilyMemberMaritialStatus = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberMaritialStatus'];
        getFamilyMemberOccupation = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberOccupation'];
        getFamilyMemberBloodGroup = jsonDecode(data)['familydetail']
            [familyMemberIndex]['FamilyMemberBloodGroup'];

        print("getFamilyMemberName = $getFamilyMemberName");
        print("getFamilyMemberDegree = $getFamilyMemberDegree");
        print("getFamilyMemberUnivercity = $getFamilyMemberUnivercity");
        print("getFamilyMemberPassingYear = $getFamilyMemberPassingYear");

        print(
            "getFamilyMemberProfileImage In EditFamilyProfileScreen = $getFamilyMemberProfileImage");

        print("getFamilyMemberbirthdate = $getFamilyMemberBirthDate");
        print("getFamilyMemberMobileNo = $getFamilyMemberMobileNo");
        print("getFamilyMemberAddress = $getFamilyMemberAddress");
        print("getFamilyMemberOccupation = $getFamilyMemberOccupation");

        base64Image = getFamilyMemberProfileImage;
        print("base64Image IN Get Function  = $base64Image");
        
        nameController.text = getFamilyMemberName;
        birthDateController.text = getFamilyMemberBirthDate;
        mobileNumberController.text = getFamilyMemberMobileNo;
        addressController.text = getFamilyMemberAddress;
        degreeController.text = getFamilyMemberDegree;
        collegeController.text = getFamilyMemberUnivercity;
        passingController.text = getFamilyMemberPassingYear;
        jobController.text = getFamilyMemberOccupation;

        if (getFamilyMemberProfileImage == "") {
          print("profilePicture is null");
        } else {
          var stringToBase64Url = utf8.fuse(base64Url);
          toBase64 = stringToBase64Url.encode(getFamilyMemberProfileImage);
          resource =
              base64.decode(base64.normalize(getFamilyMemberProfileImage));
        }

        if (getFamilyMemberMaritialStatus == null) {
          print(
              "getFamilyMemberMaritialStatus = $getFamilyMemberMaritialStatus");
          print("getFamilyMemberMaritialStatus == null");
        }
        if (getFamilyMemberMaritialStatus != null) {
          print(
              "getFamilyMemberMaritialStatus = $getFamilyMemberMaritialStatus");
          maritalStatusController.text = getFamilyMemberMaritialStatus;
        }

        if (getFamilyMemberBloodGroup == null) {
          print("getFamilyMemberBloodGroup = $getFamilyMemberBloodGroup");
          print("getFamilyMemberBloodGroup == null");
        }
        if (getFamilyMemberBloodGroup != null) {
          print("getFamilyMemberBloodGroup = $getFamilyMemberBloodGroup");
          bloodGroupController.text = getFamilyMemberBloodGroup;
        }

        if (getFamilyMemberType == null) {
          print("getFamilyMemberType = $getFamilyMemberType");
          print("getFamilyMemberType == null");
        }
        if (getFamilyMemberType != null) {
          print("getFamilyMemberType = $getFamilyMemberType");
          relationshipController.text = getFamilyMemberType;
        }

        print("getFamilyMemberMaritialStatus = $getFamilyMemberMaritialStatus");
        print("getFamilyMember = $getFamilyMemberBloodGroup");
        print("getFamilyMemberType = $getFamilyMemberType");
        print("martialStatusValue = ${maritalStatusController.text}");
        print("bloodGroupValue = ${bloodGroupController.text}");
        print("realtionShipValue = ${relationshipController.text}");
      });

      //var venam = jsonDecode(data)['subcaste'][0]['SubcasteName'];
      //print("subcaste =  $venam");

    } else {
      print(response.statusCode);
    }
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

      var finalBytes;

      if (finalBytes != null) {
        finalBytes = _selectedFile.readAsBytesSync();
        String _img64 = base64Encode(finalBytes);
      }

      //log("_img64 = $_img64");

      base64Image = base64Encode(_selectedFile.readAsBytesSync());

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
          /* CircleAvatar(
            radius: 60.0,
            backgroundImage: ExactAssetImage(Images.ImgNoUserProfileJpg),
          ), */
          toBase64 == null
              ? CircleAvatar(
                  radius: 60.0,
                  backgroundImage: ExactAssetImage(Images.ImgNoUserProfileJpg),
                )
              : CircleAvatar(
                  radius: 60.0,
                  child: ClipRRect(
                    child: Image.memory(
                      resource,
                    ),
                    borderRadius: BorderRadius.circular(60.0),
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
                scale: 0.2,
              ),
            ),
            right: 0,
            top: 92,
            bottom: 0,
            left: 0,
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

  AddFamilyMember _user;

  final _formKeyEditFamily = new GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController passingController = TextEditingController();
  TextEditingController jobController = TextEditingController();

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
                  maritalStatusController.text = "Married";
                },
                child: const Text('Married'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyMaritalStatus.Unmarried);
                  maritalStatusController.text = "Unmarried";
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
                  bloodGroupController.text = "A+";
                },
                child: const Text('A+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Bpos);
                  bloodGroupController.text = "B+";
                },
                child: const Text('B+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Opos);
                  bloodGroupController.text = "O+";
                },
                child: const Text('O+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.ABpos);
                  bloodGroupController.text = "AB+";
                },
                child: const Text('AB+'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Aneg);
                  bloodGroupController.text = "A-";
                },
                child: const Text('A-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Bneg);
                  bloodGroupController.text = "B-";
                },
                child: const Text('B-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.Oneg);
                  bloodGroupController.text = "O-";
                },
                child: const Text('O-'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyBloodGroup.ABneg);
                  bloodGroupController.text = "AB-";
                },
                child: const Text('AB-'),
              ),
            ],
          );
        });
  }

  Future<AddFamilyRelationship> _relationshipSimpleDialog(
      BuildContext context) async {
    return await showDialog<AddFamilyRelationship>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Relationship'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Father);
                  relationshipController.text = "Father";
                },
                child: const Text('Father'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Mother);
                  relationshipController.text = "Mother";
                },
                child: const Text('Mother'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Sister);
                  relationshipController.text = "Sister";
                },
                child: const Text('Sister'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Brother);
                  relationshipController.text = "Brother";
                },
                child: const Text('Brother'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Son);
                  relationshipController.text = "Son";
                },
                child: const Text('Son'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.Daughter);
                  relationshipController.text = "Daughter";
                },
                child: const Text('Daughter'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.GrandFather);
                  relationshipController.text = "GrandFather";
                },
                child: const Text('GrandFather'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AddFamilyRelationship.GrandMother);
                  relationshipController.text = "GrandMother";
                },
                child: const Text('GrandMother'),
              ),
            ],
          );
        });
  }

  String _date1;

  /* String bloodGroupValue = 'Not set';
  List<String> bloodGroupItems = [
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

  String realtionShipValue = 'Not set';
  List<String> realtionShipItems = [
    'Not set',
    'Father',
    'Mother',
    'Sister',
    'Brother',
    'Grand Father'
  ];

  String martialStatusValue = 'Not Set';
  List<String> martialStatusItems = ['Not Set', 'Married', 'Unmarried']; */

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
                          "Edit Family",
                          style: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 24,
                              fontFamily: 'Metropolis-ExtraBold'),
                        ),
                      ),
                    ],
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: ExactAssetImage(Images.ImgNoUserProfile),
                  ),
                ), */
                getFamilyMemberName == null
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
                            child: Column(
                              children: [
                                getImageWidget(),
                              ],
                            ),
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
                            //iconColor: Colors.black,
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
                                  key: _formKeyEditFamily,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        controller: nameController,
                                        textInputAction: TextInputAction.next,
                                        maxLines: 1,
                                        maxLength: 25,
                                        validator: RequiredValidator(
                                            errorText: "Required"),
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: TextFormField(
                                          controller: birthDateController,
                                          enableInteractiveSelection: false,
                                          readOnly: true,
                                          validator: RequiredValidator(
                                              errorText: "Required"),
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
                                                  birthDateController.text =
                                                      _date1;

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
                                          style: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Medium'),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4.0),
                                            hintText: _date1 != "$_date1"
                                                ? "DD/MM/YYYY"
                                                : "$_date1",
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
                                            value: martialStatusValue,
                                            icon: Icon(Icons.expand_more),
                                            iconSize: 30,
                                            style: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Regular'),
                                            onChanged: (String data) {
                                              setState(() {
                                                martialStatusValue = data;
                                                print(
                                                    "martialStatusValue = $martialStatusValue");
                                                print(
                                                    "martialStatusItems = $martialStatusItems");
                                              });
                                            },
                                            items: martialStatusItems
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
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
                                            value: bloodGroupValue,
                                            icon: Icon(Icons.expand_more),
                                            iconSize: 30,
                                            style: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Regular'),
                                            onChanged: (String data) {
                                              setState(() {
                                                bloodGroupValue = data;
                                              });
                                            },
                                            items: bloodGroupItems
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "Relationship",
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
                                            value: realtionShipValue,
                                            icon: Icon(Icons.expand_more),
                                            iconSize: 30,
                                            style: TextStyle(
                                                color: new Color(0xff4A4B4D),
                                                fontSize: 14,
                                                fontFamily: 'Roboto-Regular'),
                                            onChanged: (String data1) {
                                              setState(() {
                                                realtionShipValue = data1;
                                              });
                                            },
                                            items: realtionShipItems
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
                                      /* Container(
                                  height: 26,
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: martialStatusValue,
                                      icon: Icon(Icons.expand_more),
                                      iconSize: 30,
                                      style: TextStyle(
                                          color: new Color(0xff4A4B4D),
                                          fontSize: 14,
                                          fontFamily: 'Roboto-Regular'),
                                      onChanged: (String data) {
                                        setState(() {
                                          martialStatusValue = data;
                                          print(
                                              "martialStatusValue = $martialStatusValue");
                                          print(
                                              "martialStatusItems = $martialStatusItems");
                                        });
                                      },
                                      items: martialStatusItems
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
                                 */
                                      /* Divider(
                                  color: Color(0xff707070),
                                  thickness: 1,
                                ), */
                                      /* Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "Blood Group",
                                    style: TextStyle(
                                        color: new Color(0xff4A4B4D),
                                        fontSize: 11,
                                        fontFamily: 'Metropolis-Regular'),
                                  ),
                                ), */

                                      TextFormField(
                                        controller: maritalStatusController,
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
                                        controller: bloodGroupController,
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
                                      TextFormField(
                                        controller: relationshipController,
                                        enableInteractiveSelection: false,
                                        readOnly: true,
                                        onTap: () {
                                          _relationshipSimpleDialog(context);
                                        },
                                        textInputAction: TextInputAction.next,
                                        validator: RequiredValidator(
                                            errorText: "Required"),
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
                                          labelText: "Relationship (Required)",
                                          labelStyle: TextStyle(
                                              color: new Color(0xff4A4B4D),
                                              fontSize: 14,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
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
                                      controller: mobileNumberController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
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
                                        labelText: "Mobile Number",
                                        labelStyle: TextStyle(
                                            color: new Color(0xff4A4B4D),
                                            fontSize: 14,
                                            fontFamily: 'Metropolis-Regular'),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: addressController,
                                      textInputAction: TextInputAction.next,
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
                                      controller: degreeController,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 30,
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
                                      controller: collegeController,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 30,
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
                                      controller: passingController,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 4,
                                      keyboardType: TextInputType.number,
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
                                      controller: jobController,
                                      textInputAction: TextInputAction.done,
                                      maxLength: 20,
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
                                      print(
                                          "birthdate = ${birthDateController.text}");

                                      final String address =
                                          addressController.text;
                                      String age = "";
                                      String birthdate =
                                          birthDateController.text;
                                      //String bloodgroup = bloodGroupValue;
                                      String bloodgroup =
                                          bloodGroupController.text;
                                      String degree = degreeController.text;
                                      String fathername = "";
                                      String gender = "";
                                      //String maritial = martialStatusValue;
                                      String maritial =
                                          maritalStatusController.text;
                                      String mobile =
                                          mobileNumberController.text;
                                      String name = nameController.text;
                                      String occupation = jobController.text;
                                      String passyear = passingController.text;
                                      //String type = realtionShipValue;
                                      String type = relationshipController.text;
                                      String univercity =
                                          collegeController.text;

                                      String profile = base64Image;    

                                      print("base64Image = $base64Image");

                                        if (base64Image == null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is null");
                                          profile = "";
                                        }
                                        if (base64Image != null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is not null");
                                          profile = base64Image;
                                        }




                                      
                                      String imageType = ".png";

                                      if (_formKeyEditFamily.currentState
                                          .validate()) {
                                        final AddFamilyMember user =
                                            await editFamilyMember(
                                                address,
                                                age,
                                                birthdate,
                                                bloodgroup,
                                                degree,
                                                fathername,
                                                gender,
                                                maritial,
                                                mobile,
                                                name,
                                                occupation,
                                                passyear,
                                                type,
                                                univercity,
                                                profile,
                                                imageType);

                                        setState(() {
                                          _user = user;
                                          print("address = $address");
                                          print(
                                              "addressController = ${addressController.text}");
                                          print("bloodGroup = $bloodgroup");
                                          print(
                                              "bloodGroupController = ${bloodGroupController.text}");

                                          print("degree = $degree");
                                          print(
                                              "degreeController = ${degreeController.text}");
                                        });

                                        if (result == 200) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Family Member Updated Successfully"),
                                            backgroundColor: Colors.amber,
                                          ));

                                          Navigator.pop(context);
                                        }

                                        /* Route route = MaterialPageRoute(
                                    builder: (context) => ProfilePageScreen());
                                Navigator.pushReplacement(context, route); */

                                        print("Data Saved");
                                      } else {}
                                    },
                                  ),
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
                                      print(
                                          "birthdate = ${birthDateController.text}");

                                      final String address =
                                          addressController.text;
                                      String age = "";
                                      String birthdate =
                                          birthDateController.text;
                                      //String bloodgroup = bloodGroupValue;
                                      String bloodgroup =
                                          bloodGroupController.text;
                                      String degree = degreeController.text;
                                      String fathername = "";
                                      String gender = "";
                                      //String maritial = martialStatusValue;
                                      String maritial =
                                          maritalStatusController.text;
                                      String mobile =
                                          mobileNumberController.text;
                                      String name = nameController.text;
                                      String occupation = jobController.text;
                                      String passyear = passingController.text;
                                      //String type = realtionShipValue;
                                      String type = relationshipController.text;
                                      String univercity =
                                          collegeController.text;
                                      String profile = base64Image;    

                                      print("base64Image = $base64Image");

                                        if (base64Image == null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is null");
                                          profile = "";
                                        }
                                        if (base64Image != null) {
                                          print("base64Image = $base64Image");
                                          print("base64Image is not null");
                                          profile = base64Image;
                                        }
                                        
                                      String imageType = ".png";

                                      if (_formKeyEditFamily.currentState
                                          .validate()) {
                                        final AddFamilyMember user =
                                            await editFamilyMember(
                                                address,
                                                age,
                                                birthdate,
                                                bloodgroup,
                                                degree,
                                                fathername,
                                                gender,
                                                maritial,
                                                mobile,
                                                name,
                                                occupation,
                                                passyear,
                                                type,
                                                univercity,
                                                profile,
                                                imageType);

                                        setState(() {
                                          _user = user;
                                          print("address = $address");
                                          print(
                                              "addressController = ${addressController.text}");
                                          print("bloodGroup = $bloodgroup");
                                          print(
                                              "bloodGroupController = ${bloodGroupController.text}");

                                          print("degree = $degree");
                                          print(
                                              "degreeController = ${degreeController.text}");
                                        });

                                        if (result == 200) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Family Member Updated Successfully"),
                                            backgroundColor: Colors.amber,
                                          ));

                                          Navigator.pop(context);
                                        }

                                        /* Route route = MaterialPageRoute(
                                    builder: (context) => ProfilePageScreen());
                                Navigator.pushReplacement(context, route); */

                                        print("Data Saved");
                                      } else {}
                                    },
                                  ),
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

  @override
  void initState() {
    super.initState();
    //getFamilyDetails();
    print("--------called getfamilyMembers();---------");
    getfamilyMembers();
  }
}
