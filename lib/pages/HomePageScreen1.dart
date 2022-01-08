import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/images.dart';
import 'package:flutter_demo_project/pages/AboutUsPageScreen.dart';
import 'package:flutter_demo_project/pages/GotraDirectoryPageScreen.dart';
import 'package:flutter_demo_project/pages/HelplinePageScreen.dart';
import 'package:flutter_demo_project/pages/MemberSearchPageScreen.dart';
import 'package:flutter_demo_project/pages/NewsPageScreen1.dart';
import 'package:flutter_demo_project/pages/ProfilePageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'WelcomePageScreen.dart';

class HomePageScreen1 extends StatefulWidget {
  @override
  _HomePageScreen1State createState() => _HomePageScreen1State();
}

class _HomePageScreen1State extends State<HomePageScreen1> {
  var data1;
  String getTokenId;
  var lengthOfUserDetails;
  var userProfileName;
  var userProfileImageHome;
  String toBase64HomePage;
  List<int> resource;

  List<Widget> _widgetOptions = <Widget>[
    NewsPageScreen1(),
    MemberSearchPageScreen(),
    NewsPageScreen1(),
    ProfilePageScreen(),
    GotraDirectoryPageScreen(),
  ];
  int _currentSelected = 2;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 0
        ? _drawerKey.currentState.openDrawer()
        : setState(() {
            _currentSelected = index;
          });
  }

  Future getProfileData() async {
    final getUserData = await SharedPreferences.getInstance();

    getTokenId = getUserData.getString("savedUserId");
    print("GET TOKEN = $getTokenId");

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

        userProfileName = jsonDecode(data1)['userdetail']['FirstName'];

        print("userProfileName = $userProfileName");

        userProfileImageHome = jsonDecode(data1)['userdetail']['ProfileImage'];

        //log(" userProfileImageHome in HomePageScreen1 = $userProfileImageHome");

        if (userProfileImageHome == "") {
          print("userProfileImageHome is null");
        } else {
          var stringToBase64Url = utf8.fuse(base64Url);
          toBase64HomePage = stringToBase64Url.encode(userProfileImageHome);
          resource = base64.decode(base64.normalize(userProfileImageHome));
        }

        print("profileName = $userProfileImageHome");
        print("FirstName = ${jsonDecode(data1)['userdetail']['FirstName']}");
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _drawerKey,
        body: _widgetOptions.elementAt(_currentSelected),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage(Images.ImgNavigationHeader),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //toBase64HomePage == null ? Text("null") : Text("not null"),
                    toBase64HomePage == null
                        ? CircleAvatar(
                            radius: 38.0,
                            backgroundImage:
                                ExactAssetImage(Images.ImgNoUserProfileJpg),
                          )
                        : CircleAvatar(
                            radius: 38.0,
                            child: ClipRRect(
                              child: Image.memory(resource),
                              borderRadius: BorderRadius.circular(70.0),
                            ),
                          ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0B4328),
                              fontSize: 14.0,
                              fontFamily: 'Metropolis-ExtraBold'),
                        ),
                        SizedBox(height: 10.0),
                        userProfileName == null
                            ? Text(
                                '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0B4328),
                                    fontSize: 14.0,
                                    fontFamily: 'Metropolis-ExtraBold'),
                              )
                            : Text(
                                '$userProfileName',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0B4328),
                                    fontSize: 14.0,
                                    fontFamily: 'Metropolis-ExtraBold'),
                              )
                      ],
                    ),
                  ],
                ),
              ),
              new ListTile(
                title: Text(
                  "My Profile",
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff4A4B4D),
                      fontFamily: 'Metropolis-Bold'),
                ),
                trailing: Icon(
                  Icons.person_outline,
                  color: Color(0xff0B4328),
                ),
                onTap: () => {
                  print("clicked"),
                },
              ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              new ListTile(
                  title: Text(
                    "Directory",
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xff4A4B4D),
                        fontFamily: 'Metropolis-Bold'),
                  ),
                  onTap: () {
                    print("directory clicked");
                    print("elementAt = ${_widgetOptions.elementAt(4)}");

                    //Navigator.push
                    //Navigator.pop(_drawerKey.currentContext);
                  },
                  trailing: IconButton(
                    padding: EdgeInsets.only(left: 16.0),
                    icon: SvgPicture.asset(
                      Images.IcBook,
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {},
                  )
                  /* Icon(
                  Icons.book,
                  color: Color(0xff0B4328),
                ), */
                  ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              new ListTile(
                title: Text(
                  "Search Member",
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff4A4B4D),
                      fontFamily: 'Metropolis-Bold'),
                ),
                trailing: Icon(
                  Icons.search,
                  color: Color(0xff0B4328),
                ),
                onTap: () => {
                  print("Search Member"),
                  Navigator.pop(_drawerKey.currentContext)
                },
              ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              new ListTile(
                title: Text(
                  "About Us",
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff4A4B4D),
                      fontFamily: 'Metropolis-Bold'),
                ),
                trailing: Icon(
                  Icons.person_outline,
                  color: Color(0xff0B4328),
                ),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsPageScreen())),
                  Navigator.pop(_drawerKey.currentContext)
                },
              ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              new ListTile(
                title: Text(
                  "Helpline Us",
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff4A4B4D),
                      fontFamily: 'Metropolis-Bold'),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff0B4328),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HelplinePageScreen(),
                    ),
                  ),
                  Navigator.pop(_drawerKey.currentContext)
                },
              ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              new ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff4A4B4D),
                      fontFamily: 'Metropolis-Bold'),
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Color(0xff0B4328),
                ),
                onTap: () => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomePageScreen()),
                      (route) => false),
                  removeToken(),
                },
              ),
              Divider(
                thickness: 0.1,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          currentIndex: _currentSelected,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey[800],
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.IcMenuSvg,
                width: 17,
                height: 17,
                color: Colors.black,
              ),
              title: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Metropolis-Medium'),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.IcSearchSvg,
                width: 17,
                height: 17,
                color: Colors.black,
              ),
              title: Text(
                'Search',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Metropolis-Medium'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 38,
                    )),
              ),
              title: Text(
                '',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Metropolis-Medium'),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.IcProfileSvg,
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Metropolis-Medium'),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Images.IcDirectorySvg,
                color: Colors.black,
              ),
              title: Text(
                'Directory',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Metropolis-Medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future removeToken() async {
  final getUserData = await SharedPreferences.getInstance();
  var userId = getUserData.getString("savedUserId");
  print("userId : $userId");

  final pref = await SharedPreferences.getInstance();
  pref.setString("savedUserId", "");
  final removeUserData = await SharedPreferences.getInstance();
  var removeUserdata = removeUserData.getString("savedUserId");
  print("removeUserData = $removeUserdata");
}

class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
