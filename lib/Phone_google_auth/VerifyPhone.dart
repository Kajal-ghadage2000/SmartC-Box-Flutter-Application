import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import '../HomeScreen.dart';

class VerifyPhone extends StatefulWidget {
  String mobile;
  VerifyPhone(String mobile) {
    this.mobile = mobile;
  }

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  var phoneno;
  var globalKeyForForm = GlobalKey<FormState>();
  String verificationId1;
  TextEditingController otp = TextEditingController();

  Future registerUser(String mobile, BuildContext context) async {
    print("aaa$mobile");
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          _auth.signInWithCredential(credential).then((UserCredential result) {
            otp.text = "345678";
            showDialog(
              context: context,
              child: Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: Colors.teal[700]),
              ),
            );

            Timer(Duration(seconds: 15), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });
          }).catchError((e) {
            print("Exception 1");
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          verificationId1 = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
    print("dsdsdsds");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneno = widget.mobile;
    registerUser(widget.mobile, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Verify Phone",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(children: [
                Image.asset(
                  'assets/holding-phone.png',
                  height: 190,
                  width: 190,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 60),
                  child: Text(
                    "OTP Is Sent To $phoneno",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF818181),
                        letterSpacing: 2),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                PinCodeFields(
                  margin: EdgeInsets.all(4.0),
                  controller: otp,
                  length: 6,
                  fieldBorderStyle: FieldBorderStyle.Square,
                  responsive: false,
                  fieldHeight: 40.0,
                  fieldWidth: 40.0,
                  borderWidth: 2.0,
                  animationDuration: const Duration(milliseconds: 200),
                  animationCurve: Curves.easeInOut,
                  switchInAnimationCurve: Curves.easeIn,
                  switchOutAnimationCurve: Curves.easeOut,
                  animation: Animations.SlideInDown,
                  activeBorderColor: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                  keyboardType: TextInputType.phone,
                  autoHideKeyboard: false,
                  borderColor: Colors.teal,
                  textStyle: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (String value) {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId1, smsCode: value);
                    auth
                        .signInWithCredential(credential)
                        .then((UserCredential result) {
                      showDialog(
                          context: context,
                          child: Center(
                            child: Loading(
                                indicator: BallPulseIndicator(),
                                size: 100.0,
                                color: Colors.teal[700]),
                          ));
                      Timer(Duration(seconds: 15), () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't recieve the code? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerUser(widget.mobile, context);
                        },
                        child: Text(
                          "Resend Now ",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF818181)),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
