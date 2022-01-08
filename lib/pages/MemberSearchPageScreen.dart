import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/SearchResultPageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberSearchPageScreen extends StatefulWidget {
  @override
  _MyStateMemberSearchPageScreen createState() =>
      _MyStateMemberSearchPageScreen();
}

class _MyStateMemberSearchPageScreen extends State<MemberSearchPageScreen> {
  TextEditingController searchByNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                height: 60,
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
                  padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Text(
                          "Member Search",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Metropolis-Bold',
                            color: Color(0xff0B4328),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(),
                      ),
                      /* Expanded(
                        flex: 0,
                        child: Row(
                          children: [
                            Icon(Icons.search),
                          ],
                        ),
                      ), */
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Write only few characters of value \neg. Sure if your want to find",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Metropolis-Medium',
                  fontSize: 14.0,
                  color: Color(0xff7C7D7E),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Search by name",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 14.0,
                          color: Color(0xff979797),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.0),
                  TextFormField(
                    controller: searchByNameController,
                    maxLines: 1,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff0B4328), width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 35.0, 50.0, 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 20.0),
                              child: Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Metropolis-SemiBold'),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff0B4328)),
                            ),
                            onPressed: () async {
                              print(
                                  "searchByName ${searchByNameController.text}");

                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.setString(
                                  "searchValue", searchByNameController.text);

                              var string = pref.getString("searchValue");

                              print("getString value = $string");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchResultPageScreen(string)));

                              searchByNameController.text = "";
                            },
                          ),
                        ),
                        SizedBox(width: 15.0),
                        /* Expanded(
                          flex: 1,
                          child: TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Text(
                                'Reset',
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
                            onPressed: () {
                              print('TextButton Reset Pressed');
                            },
                          ),
                        ),
                       */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
