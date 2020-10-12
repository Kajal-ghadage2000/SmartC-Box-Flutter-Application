import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'VerifyPhone.dart';

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
      backgroundColor: Colors.teal[700],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/Complain-512.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
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
                            }),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle:
                                TextStyle(fontSize: 14, letterSpacing: 2),
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
                  height: 15,
                ),
                MaterialButton(
                  minWidth: double.maxFinite,
                  height: 40,
                  child: Text(
                    "Send OTP",
                    style: TextStyle(letterSpacing: 1.5),
                  ),
                  textColor: Colors.white,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  onPressed: () {
                    final mobile = "+91" + _phoneController.text.trim();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhone(mobile)));
                  },
                ),
                SizedBox(height: 25),
                Row(children: <Widget>[
                  Expanded(child: Divider(color: Colors.grey[350])),
                  Text(
                    " OR ",
                    style: TextStyle(
                      fontSize: 15,
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
                  height: 10,
                ),
                SizedBox(
                  height: 15,
                ),

                GoogleSignInButton(
                  borderRadius: 7,
                  text: "Continue with Goggle",
                  textStyle: TextStyle(
                      color: Colors.grey[95],
                      fontSize: 15,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                  onPressed: () {/* ... */},
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
