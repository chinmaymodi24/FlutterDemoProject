import 'dart:convert';
import 'dart:developer';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/AddFamilyPageScreen.dart';
import 'package:flutter_demo_project/pages/EditFamilyPageScreen.dart';
import 'package:flutter_demo_project/pages/EditProfileScreen.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageScreen extends StatefulWidget {
  @override
  _MyStateProfilePageScreen createState() => _MyStateProfilePageScreen();
}

class _MyStateProfilePageScreen extends State<ProfilePageScreen> {
  List<int> userProfileResource;
  var number;
  var familyid;
  var getTokenId;
  var familyIdForDelete;
  var data;
  var data1;
  var langSelectLength;
  var lengthOfUserDetails;
  var totalFamilyMembers;
  var username;
  var getFamilyMemberProfilePicture;
  var getUserProfilePicture;
  List<int> resource;
  int index = 0;

  bool flag = false;

  var toBase64Profile;
  var toBase64FamilyMember;

  var userEmail;

  deleteFamilyMember() async {
    print("editFamilyMember familyIdForDelete = $familyIdForDelete");
    print("editFamilyMember Token = $getTokenId");

    final String apiUrl =
        "https://helicoreraj.pythonanywhere.com/deletefamily/$number/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $getTokenId',
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

  getfamilyMembers() async {
    final getUserData = await SharedPreferences.getInstance();

    getTokenId = getUserData.getString("savedUserId");
    //print("GET TOKEN = $getTokenId");

    //final pref = await SharedPreferences.getInstance();
    //userProfileImage = pref.getString("UserProfileImage");
    //print("userProfileImage in ProfilePageScreen = $userProfileImage");

    http.Response response = await http.get(
        Uri.parse("https://helicoreraj.pythonanywhere.com/familyview/"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $getTokenId',
        });

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      //print("response = $data");

      setState(() {
        langSelectLength = jsonDecode(
            data)['familydetail']; //get all the data from json string

        print("langSelectLength = $langSelectLength");

        totalFamilyMembers = langSelectLength.length;

        print("totalFamilyMembers ProfilePage = $totalFamilyMembers");

        print(
            "langSelectLength.length = ${langSelectLength.length}"); // just printed length of data
        familyid = jsonDecode(data)['familydetail'][index]['Family_ID'];

        print("lengthOfUserDetails : $lengthOfUserDetails");
        print("${jsonDecode(data)['userdetail']['email']}");
        print("Data = ${jsonDecode(data)['userdetail']['FamilySurname']}");
        print("Data = ${jsonDecode(data)['userdetail']['email']}");

        /* profilePicture =
            jsonDecode(data)['familydetail'][index]['FamilyMemberProfileImage'];

        print("FamilyID = $familyId");

        //log("profilePicture = $profilePicture");

        var stringToBase64Url = utf8.fuse(base64Url);

        print("stringToBase64UrlInProfilePicture = $stringToBase64Url");

        var data1 = stringToBase64Url.encode(profilePicture);
        resource = base64.decode(base64.normalize(profilePicture)); */
      });
    } else {
      print(response.statusCode);
    }
  }

  getProfileDetails1() async {
    final getUserData = await SharedPreferences.getInstance();

    getTokenId = getUserData.getString("savedUserId");
    print("GET TOKEN = $getTokenId");

    //final pref = await SharedPreferences.getInstance();
    //userProfileImage = pref.getString("UserProfileImage");
    //print("userProfileImage in ProfilePageScreen = $userProfileImage");

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

        //print("lengthOfUserDetails = $lengthOfUserDetails");
        userEmail = jsonDecode(data1)['userdetail']['email'];
        //print("userEmail = $userEmail");
        username = jsonDecode(data1)['userdetail']['FirstName'];
        //print("username = $username");

        getUserProfilePicture = jsonDecode(data1)['userdetail']['ProfileImage'];

        //getUserProfilePicture = jsonDecode(data1)['userdetail']['ProfileImage'];

        print("getUserProfilePicture = $getUserProfilePicture");

        /* var stringToBase64Url = utf8.fuse(base64Url);
        toBase64Profile = stringToBase64Url.encode(getUserProfilePicture);
        userProfileResource =
            base64.decode(base64.normalize(getUserProfilePicture));
        print("userProfileResource = $userProfileResource"); */

        if (getUserProfilePicture == "") {
          print("image is null");
        } else {
          var stringToBase64Url = utf8.fuse(base64Url);
          toBase64Profile = stringToBase64Url.encode(getUserProfilePicture);
          userProfileResource =
              base64.decode(base64.normalize(getUserProfilePicture));
          print("image is not null");
        }

        /*if (getUserProfilePicture != "") {
          var stringToBase64Url = utf8.fuse(base64Url);
          toBase64Profile = stringToBase64Url.encode(getUserProfilePicture);
          userProfileResource =
              base64.decode(base64.normalize(getUserProfilePicture));
          print("image is not null");
        } else {
          print("image is null");
        } */

        //var userProfileImage = jsonDecode(data1)['userdetail']['ProfileImage'];
        //log("UserProfileImage in ProfilePageScreen = $userProfileImage");
        /* var stringToBase64Url = utf8.fuse(base64Url);
          toBase64 = stringToBase64Url.encode(userProfileImage);
          userProfileResource =
              base64.decode(base64.normalize(userProfileImage)); */

        //print("toBase64 = $toBase64Profile");

        /* if (toBase64Profile == "") {
          print("toBase64 is null");
        }

        if (toBase64Profile != "") {
          print("toBase64 is not null");
        } */

        /* var stringToBase64Url = utf8.fuse(base64Url);
        var encode = stringToBase64Url.encode(userProfileImage);
        userProfileResource = base64.decode(base64.normalize(userProfileImage)); */
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    print("__________getProfileDetails______________");
    getProfileDetails1();
    print("__________getFamilyMembers______________");
    getfamilyMembers();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 18.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "My Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: new Color(0xff4A4B4D),
                          fontSize: 24,
                          fontFamily: 'Metropolis-ExtraBold'),
                    ),
                  ),
                ],
              ),
            ),
            userEmail == null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AwesomeLoader(
                      loaderType: AwesomeLoader.AwesomeLoader3,
                      color: Colors.orange,
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                        child: Column(
                          children: [
                            /* getUserProfilePicture == ""
                                ? Text("null")
                                : Text("not null"), */
                            /* userProfileResource == null
                                ? Text("null")
                                : Text("not null"),
                            userProfileResource != null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    child: ClipRRect(
                                      child: Image.memory(userProfileResource),
                                      borderRadius: BorderRadius.circular(70.0),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: ExactAssetImage(
                                        Images.ImgNoUserProfileJpg),
                                  ), */
                            toBase64Profile != null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    child: ClipRRect(
                                      child: Image.memory(userProfileResource),
                                      borderRadius: BorderRadius.circular(70.0),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: ExactAssetImage(
                                        Images.ImgNoUserProfileJpg),
                                  ),
                            /* getUserProfilePicture == null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: ExactAssetImage(
                                        Images.ImgNoUserProfileJpg),
                                  )
                                : CircleAvatar(
                                    radius: 60.0,
                                    child: ClipRRect(
                                      child: Image.memory(userProfileResource),
                                      borderRadius: BorderRadius.circular(70.0),
                                    ),
                                  ), */
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 0.0),
                        child: Text(
                          "$username",
                          style: TextStyle(
                              color: new Color(0xff4A4B4D),
                              fontSize: 20,
                              fontFamily: 'Metropolis-Bold'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                        child: Container(
                          height: 38,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Family Info.",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Bold',
                                      color: Color(0xff0B4328),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfilePageScreen()));
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.IcEdit,
                                          height: 14,
                                          width: 14,
                                        ),
                                        SizedBox(width: 6.0),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-Regular',
                                            color: Color(0xff0B4328),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
                        color: Color(0xffF6F6F6),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 6.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Family Id",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 40.0,
                                ),
                                familyid != null
                                    ? Text(
                                        ": ${jsonDecode(data)['familydetail'][index]['Family_ID']}",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      )
                                    : Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Surname",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 40.0,
                                ),
                                data1 != null
                                    ? Text(
                                        ": ${jsonDecode(data1)['userdetail']['FamilySurname']}",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      )
                                    : Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            screenWidth < 360
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "NameFold",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                                      data1 != null
                                          ? Expanded(
                                              flex: 3,
                                              child: Text(
                                                "${jsonDecode(data1)['userdetail']['FirstName']}",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 3,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            ),
                                    ],
                                  )
                                : FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                        SizedBox(
                                          width: 59.0,
                                        ),
                                        Text(
                                          ": ",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                        data1 != null
                                            ? Text(
                                                "${jsonDecode(data1)['userdetail']['FirstName']}",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Father Name",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 14.0,
                                ),
                                data1 != null
                                    ? Text(
                                        ": ${jsonDecode(data1)['userdetail']['Fathername']}",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      )
                                    : Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            FittedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Mother Name",
                                    style: TextStyle(
                                        color: Color(0xff0B4328),
                                        fontSize: 13.0,
                                        fontFamily: 'Metropolis-Regular'),
                                  ),
                                  SizedBox(
                                    width: 11.0,
                                  ),
                                  data1 != null
                                      ? Text(
                                          ": ${jsonDecode(data1)['userdetail']['Mothername']}",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        )
                                      : Text(
                                          ": ",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Gotra",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 61.0,
                                ),
                                data1 != null
                                    ? Text(
                                        ": ${jsonDecode(data1)['userdetail']['Gotra']}",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      )
                                    : Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            screenWidth < 360
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Sakha",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                                      data1 != null
                                          ? Expanded(
                                              flex: 3,
                                              child: Text(
                                                "${jsonDecode(data1)['userdetail']['Sakha']}",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 3,
                                              child: Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            ),
                                    ],
                                  )
                                : FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Sakha",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                        SizedBox(
                                          width: 59.8,
                                        ),
                                        Text(
                                          ": ",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                        data1 != null
                                            ? Text(
                                                "${jsonDecode(data1)['userdetail']['Sakha']}",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                      ],
                                    ),
                                  ),
                            /* Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Shakha",
                            style: TextStyle(
                                color: Color(0xff0B4328),
                                fontSize: 13.0,
                                fontFamily: 'Metropolis-Regular'),
                          ),
                          SizedBox(
                            width: 51.0,
                          ),
                          Text(
                            ": Vadnagar Nagar Brahmin",
                            style: TextStyle(
                                color: Color(0xff0B4328),
                                fontSize: 13.0,
                                fontFamily: 'Metropolis-SemiBold'),
                          ),
                        ],
                      ), */
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                        child: Container(
                          height: 38,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Family Contact Info.",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Bold',
                                      color: Color(0xff0B4328),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilePageScreen()));
                                  },
                                  child: Expanded(
                                    flex: 0,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.IcEdit,
                                          height: 14,
                                          width: 14,
                                        ),
                                        SizedBox(width: 6.0),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-Regular',
                                            color: Color(0xff0B4328),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
                        color: Color(0xffF6F6F6),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            screenWidth < 360
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30.0,
                                      ),
                                      Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                                      data1 != null
                                          ? Expanded(
                                              flex: 3,
                                              child: Text(
                                                "${jsonDecode(data1)['userdetail']['email']}",
                                                //"userEmail = $userEmail",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 3,
                                              child: Text(
                                                " ",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                            ),
                                    ],
                                  )
                                : FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily: 'Metropolis-Regular'),
                                        ),
                                        SizedBox(
                                          width: 44.4,
                                        ),
                                        Text(
                                          ": ",
                                          style: TextStyle(
                                              color: Color(0xff0B4328),
                                              fontSize: 13.0,
                                              fontFamily:
                                                  'Metropolis-SemiBold'),
                                        ),
                                        data1 != null
                                            ? Text(
                                                "${jsonDecode(data1)['userdetail']['email']}",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff0B4328),
                                                    fontSize: 13.0,
                                                    fontFamily:
                                                        'Metropolis-SemiBold'),
                                              ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Mobile",
                                  style: TextStyle(
                                      color: Color(0xff0B4328),
                                      fontSize: 13.0,
                                      fontFamily: 'Metropolis-Regular'),
                                ),
                                SizedBox(
                                  width: 38.0,
                                ),
                                data1 != null
                                    ? Text(
                                        ": ${jsonDecode(data1)['userdetail']['MobileNo']}",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      )
                                    : Text(
                                        ": ",
                                        style: TextStyle(
                                            color: Color(0xff0B4328),
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-SemiBold'),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
                        child: Container(
                          height: 38,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: totalFamilyMembers != null
                                      ? Text(
                                          "Family Member ($totalFamilyMembers)",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-Bold',
                                            color: Color(0xff0B4328),
                                          ),
                                        )
                                      : Text(
                                          "Family Member (0)",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-Bold',
                                            color: Color(0xff0B4328),
                                          ),
                                        ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFamilyMemberPageScreen()));
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images.IcEdit,
                                          height: 14,
                                          width: 14,
                                        ),
                                        SizedBox(width: 6.0),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Metropolis-Regular',
                                            color: Color(0xff0B4328),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      getHomePageBody(context),
                      SizedBox(height: 20.0)
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  getHomePageBody(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: langSelectLength == null ? 0 : langSelectLength.length,
            itemBuilder: (BuildContext context, int index) {
              getFamilyMemberProfilePicture = jsonDecode(data)['familydetail']
                  [index]['FamilyMemberProfileImage'];
              //log("profilePicture = $profilePicture");

              print(
                  "getFamilyMemberProfilePicture = $getFamilyMemberProfilePicture");

              if (getFamilyMemberProfilePicture == "") {
                print("profilePicture is null");
                toBase64FamilyMember = null;
              } else {
                var stringToBase64Url = utf8.fuse(base64Url);
                toBase64FamilyMember =
                    stringToBase64Url.encode(getFamilyMemberProfilePicture);
                resource = base64
                    .decode(base64.normalize(getFamilyMemberProfilePicture));
              }

              return Container(
                padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
                color: Color(0xffF6F6F6),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                toBase64FamilyMember == null
                                    ? CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: ExactAssetImage(
                                            Images.ImgNoUserProfileJpg),
                                      )
                                    : CircleAvatar(
                                        radius: 35.0,
                                        child: ClipRRect(
                                          child: Image.memory(resource),
                                          borderRadius:
                                              BorderRadius.circular(70.0),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        InkWell(
                          onTap: () async {
                            print(
                                "FamilyID = ${jsonDecode(data)['familydetail'][index]['FamilyID']}");

                            final pref = await SharedPreferences.getInstance();
                            pref.setString("FamilyId",
                                "${jsonDecode(data)['familydetail'][index]['FamilyID']}");
                            String getFamilyId = pref.getString("FamilyId");
                            print("getFamilyId = $getFamilyId");

                            pref.setString("familyMemberIndex", "$index");

                            var getFamilyMemberIndex =
                                pref.getString("familyMemberIndex");

                            print(
                                "getFamilyMemberIndex = $getFamilyMemberIndex");
                            print("Index = $index");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditFamilyMemberPageScreen()));
                          },
                          child: Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                screenWidth < 358
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-Regular'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 24.0,
                                          ),
                                          Text(
                                            ": ",
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-SemiBold'),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              jsonDecode(data)['familydetail']
                                                  [index]['FamilyMemberName'],
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                          ),
                                        ],
                                      )
                                    : FittedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Name",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-Regular'),
                                            ),
                                            SizedBox(
                                              width: 32.0,
                                            ),
                                            Text(
                                              ": ",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                            Text(
                                              jsonDecode(data)['familydetail']
                                                  [index]['FamilyMemberName'],
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 6.0),
                                screenWidth < 358
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Marital",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-Regular'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 24.0,
                                          ),
                                          Text(
                                            ": ",
                                            style: TextStyle(
                                                color: Color(0xff0B4328),
                                                fontSize: 13.0,
                                                fontFamily:
                                                    'Metropolis-SemiBold'),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              jsonDecode(data)['familydetail']
                                                      [index][
                                                  'FamilyMemberMaritialStatus'],
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                          ),
                                        ],
                                      )
                                    : FittedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Relation",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-Regular'),
                                            ),
                                            SizedBox(
                                              width: 18.0,
                                            ),
                                            Text(
                                              ": ",
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                            Text(
                                              jsonDecode(data)['familydetail']
                                                  [index]['FamilyMemberType'],
                                              style: TextStyle(
                                                  color: Color(0xff0B4328),
                                                  fontSize: 13.0,
                                                  fontFamily:
                                                      'Metropolis-SemiBold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 6.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Marital",
                                      style: TextStyle(
                                          color: Color(0xff0B4328),
                                          fontSize: 13.0,
                                          fontFamily: 'Metropolis-Regular'),
                                    ),
                                    SizedBox(
                                      width: 27.0,
                                    ),
                                    Text(
                                      ": ${jsonDecode(data)['familydetail'][index]['FamilyMemberMaritialStatus']}",
                                      style: TextStyle(
                                          color: Color(0xff0B4328),
                                          fontSize: 13.0,
                                          fontFamily: 'Metropolis-SemiBold'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Activity",
                                      style: TextStyle(
                                          color: Color(0xff0B4328),
                                          fontSize: 13.0,
                                          fontFamily: 'Metropolis-Regular'),
                                    ),
                                    SizedBox(
                                      width: 21.0,
                                    ),
                                    Text(
                                      ": ${jsonDecode(data)['familydetail'][index]['FamilyMemberOccupation']}",
                                      style: TextStyle(
                                          color: Color(0xff0B4328),
                                          fontSize: 13.0,
                                          fontFamily: 'Metropolis-SemiBold'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              print("Delete Button Pressed");

                              number = jsonDecode(data)['familydetail'][index]
                                  ['FamilyID'];

                              _asyncConfirmDialog(context);
                              print("Number = $number");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            padding: EdgeInsets.all(0.0),
          ),
        ],
      ),
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
            'Are you sure you want to delete?',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              onPressed: () {
                deleteFamilyMember();
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
              },
            )
          ],
        );
      },
    );
  }

  /* Future getUserDataProfile() async {
    final getUserData = await SharedPreferences.getInstance();
    userIdProfilePage = getUserData.getString("savedUserId");
    userNameProfilePage = getUserData.getString("savedUserName");
    userEmailProfilePage = getUserData.getString("savedUserEmail");
    userMobileProfilePage = getUserData.getString("savedUserMobileNo");
    userGotra = getUserData.getString("savedUserGotra");
    userBirthdate = getUserData.getString("savedUserBirthDate");
    userSakha = getUserData.getString("savedUserSakha");
    userPassword = getUserData.getString("savedUserPassword");

    print("SavedUserIdProfilePage = $userIdProfilePage");
    print("SavedUserNameProfilePage = $userNameProfilePage");
    print("SaveduseremailProfilePage = $userEmailProfilePage");
    print("SaveduserMobileNoProfilePage = $userMobileProfilePage");
    print("SaveduserGotraProfilePage = $userGotra");
    print("SaveduserBirthdateProfilePage = $userBirthdate");
    print("SaveduserSakhaProfilePage = $userSakha");
    print("SaveduserPasswordProfilePage = $userPassword");
  } */
}

enum ConfirmAction { Cancel, Accept }
