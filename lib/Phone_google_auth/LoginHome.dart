import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'VerifyPhone.dart';
import 'package:toast/toast.dart';
//import 'first_screen.dart';
import 'sign_in.dart';
import '../HomeScreen.dart';

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final _phoneController = TextEditingController();
  String phone_code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.teal[700],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    'assets/Complain-512.png',
                    height: 250,
                    width: 250,
                  ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Center(
                        child: CountryListPick(
                            theme: CountryTheme(
                                isShowFlag: true,
                                isShowTitle: false,
                                isShowCode: true,
                                isDownIcon: true,
                                showEnglishName: true),
                            initialSelection:
                                '+91', //inital selection, +672 for Antarctica,
                            onChanged: (CountryCode code) {
                              phone_code = code.code;
                              print(code.name);
                              print(code.code);
                              print(code.dialCode);
                              print(code.flagUri);
                            }),),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle:
                                TextStyle(fontSize: 16, letterSpacing: 2),
                          ),
                          onChanged: (value) {
                            // this.phoneNo=value;
                            print(value);
                          },
                          controller: _phoneController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  minWidth: double.maxFinite,
                  height: 60,
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                      fontSize: 18,
                        letterSpacing: 1.5
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    final mobile = "+91" + _phoneController.text.trim();
                    if(mobile.length == 13){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyPhone(mobile)));
                    }
                    else{
                      Toast.show("Phone number should be 10 digit", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
                    }

                  },
                ),
                SizedBox(height: 50),
                Row(children: <Widget>[
                  Expanded(child: Divider(color: Colors.grey[350])),
                  Text(
                    " OR ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey[350],
                  )),
                ]),
                SizedBox(
                  height: 50,
                ),
                _signInButton(),

              ],
            ),
          ),
        ),
      ),
    );
  }





  Widget _signInButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      child: OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator
                .of(context)
                .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
              return new HomeScreen();
            }));
          }
        });
      },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
            )
          ],
        ),
      ),
    ),);
  }
}
