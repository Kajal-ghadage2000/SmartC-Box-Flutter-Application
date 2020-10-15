import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../HomeScreen.dart';
import 'LoginHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in.dart';

class PhPersonalData extends StatefulWidget {
  @override
  _PhPersonalDataState createState() => _PhPersonalDataState();
}

class _PhPersonalDataState extends State<PhPersonalData> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext mycontext;

  String _email, _name;
  String _password;

  Color mycolor = null;

  bool _isButtonDisabled;

  final firestoreInstance = Firestore.instance;

  @override
  void initState() {
    _isButtonDisabled = true;

    signInWithGoogle().then((result) async {
      if (result != null) {
        final QuerySnapshot result = await firestoreInstance.collection("users")
            .where('email', isEqualTo: email)
            .getDocuments();
        final List <DocumentSnapshot> documents = result.documents;
        if (documents.length > 0) {
          //exists
        }
        else {
          //not exists
          firestoreInstance.collection("users").add(
              {
                "name": name,
                "email": email,
                "notification": false,
                "phone_num": Data.PhoneNum,
                "profile": imageUrl,
              }).then((value) {
            print(value.documentID);
          });
        }
        _isButtonDisabled = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('boolValue', true);


        Navigator.pop(mycontext);
        Navigator.pop(mycontext);
        Navigator.pushReplacement(
            mycontext,
            MaterialPageRoute(
                builder: (mycontext) => HomeScreen()));
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      if(_name.length >= 3  && EmailValidator.validate(_email, true)) {
        _isButtonDisabled = false;
      }
      else{
        _isButtonDisabled = true;
      }
    });
  }


  Widget _buildCounterButton(BuildContext context) {
    mycontext =context;
    return new Container(
      height: 47.0,
      width: 450.0,
      decoration: new BoxDecoration(
        color:  _isButtonDisabled ? Colors.grey[350] : Colors.teal[700],
        border: new Border.all(color: Colors.white, width: 2.0),
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: FlatButton(
      child: new Text(
        'Continue',
        style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
      ),
      onPressed:  _isButtonDisabled ? null : _submitCommand,
    ),);
  }




  void _submitCommand() async{
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _loginCommand();

      final QuerySnapshot result = await firestoreInstance.collection("users").where('email', isEqualTo: _email).getDocuments();
      final List <DocumentSnapshot> documents = result.documents;
      if (documents.length > 0) {
        //exists
        //then update data
      }
      else {
        //not exists
        firestoreInstance.collection("users").add(
            {
              "name" : _name,
              "email" : _email,
              "notification" : false,
              "phone_num" : Data.PhoneNum,
              "profile": imageUrl,
            }).then((value){
          print(value.documentID);
        });
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('boolValue', true);


      Navigator.pop(mycontext);
      Navigator.pop(mycontext);
      Navigator.pushReplacement(
          mycontext,
          MaterialPageRoute(
              builder: (mycontext) => HomeScreen()));


    }
  }

  void _loginCommand() {
    // This is just a demo, so no actual login here.
    final snackbar = SnackBar(
      content: Text('Email: $_email, name: $_name'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  checkTextFieldEmptyOrNot(){
    if(_name.length > 0  && EmailValidator.validate(_email, true)) {
      print('Text Field is empty, Please Fill All Data');
      setState(() {mycolor = Colors.black;});
    }
    else{
      print('Not Empty, All Text Input is Filled.');
      setState(() {mycolor = Colors.grey;});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
              /*Positioned(
                child: AppBar(
                  centerTitle: true,
                  title: Text("",
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  /*actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                      tooltip: 'Share',
                    ),
                  ],*/
                ),
              ),*/
                SizedBox(
                  height: 90.0,
                ),
                Text('Personal Details',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black,),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Tell us a bit more about yourself',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.black,),
                ),
              SizedBox(
                height: 33.0,
              ),
              TextFormField(
                style: GoogleFonts.inter(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: new TextStyle(color: Colors.green),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                /*validator: (val) =>
                val.length <= 0 ? 'Not a valid name.' : null,*/
                onSaved: (val) => _name = val,
                onChanged: (value) {
                  _name = value;
                  _incrementCounter();
                },
              ),
              SizedBox(
                height: 13.0,
              ),
              TextFormField(
                style: GoogleFonts.inter(
                    fontSize: 16,
                    letterSpacing: 2,
                    color: Colors.black),
                decoration: InputDecoration(labelText: 'Email',
                  labelStyle: new TextStyle(color: Colors.green),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),),
                /*validator: (val) => !EmailValidator.validate(val, true)
                    ? 'Not a valid email.'
                    : null,*/
                onSaved: (val) => _email = val,
                onChanged: (value) {
                  _email = value;
                  _incrementCounter();
                },
              ),
              SizedBox(
                height: 40.0,
              ),
                _buildCounterButton(context),
              /*new InkWell(
                onTap: _submitCommand,
                child: Container(
                  height: 47.0,
                //width: 450.0,
              decoration: new BoxDecoration(
                color: mycolor,
                border: new Border.all(color: Colors.white, width: 2.0),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Center(
                child: Text('Continue',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white),),
                  //color: Colors.teal[700],
                ),),),*/
            ],
          ),
        ),),
      ),
    );
  }
}
