import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'Phone_google_auth/LoginHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

  callActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('LoginDone');
    if(CheckValue){
      return HomeScreen();
    }
    else{
      prefs.setBool('LoginDone', false);
      return LoginHome();
    }
  }

  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 5),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => callActivity())));

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.lightGreen[700]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Lottie.asset("assets/lottiefile.json"),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "SmartC Box",
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                          color: Colors.grey[350]),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}