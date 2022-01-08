import 'package:flutter/material.dart';
import 'package:flutter_demo_project/pages/LoginPageScreen1.dart';
import '../images.dart';
import 'SignUpPageScreen2.dart';

class WelcomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 0.825 / 1,
                  child: Image.asset(
                    Images.ImgWelcome,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: Text(
                  "Akhil Bhartiya Nagar \nParishad Madhyasth",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: new Color(0xff4A4B4D),
                      fontSize: 28.0,
                      fontFamily: 'Metropolis-ExtraBold'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 18.0, 10.0, 0.0),
                child: Text(
                  "All India Nagar Parishad-Central \nmembership form",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: new Color(0xff7C7D7E),
                      fontSize: 13,
                      fontFamily: 'Metropolis-Medium'),
                ),
              ),
              screenWidth < 285
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 20.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: new Color(0xff0B4328),
                                fontSize: 16,
                                fontFamily: 'Metropolis-Medium'),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Color(0xff0B4328), width: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageScreen1()));
                          print('TextButton Pressed');
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 20.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: new Color(0xff0B4328),
                                fontSize: 16,
                                fontFamily: 'Metropolis-Medium'),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Color(0xff0B4328), width: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageScreen1()));
                          print('TextButton Pressed');
                        },
                      ),
                    ),
              screenWidth < 285
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          child: Text(
                            'Create an Account',
                            style: TextStyle(
                                color: new Color(0xff0B4328),
                                fontSize: 16,
                                fontFamily: 'Metropolis-Medium'),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Color(0xff0B4328), width: 1),
                        ),
                        onPressed: () {
                          print('TextButton Pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPageScreen2()));
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 20.0),
                          child: Text(
                            'Create an Account',
                            style: TextStyle(
                                color: new Color(0xff0B4328),
                                fontSize: 16,
                                fontFamily: 'Metropolis-Medium'),
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Color(0xff0B4328), width: 1),
                        ),
                        onPressed: () {
                          print('TextButton Pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPageScreen2()));
                        },
                      ),
                    ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  double newMethod(double screenWidth) => screenWidth;
}
