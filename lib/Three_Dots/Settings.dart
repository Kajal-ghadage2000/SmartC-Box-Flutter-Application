import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import '../Phone_google_auth/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final firestoreInstance = Firestore.instance;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  var uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      backgroundColor: Colors.teal[700],
      body: Stack(
        children: <Widget>[
          Container(
                color: Colors.teal[700],
                height: 230,
                child: Padding(
                  padding:  EdgeInsets.only(left: 15.0, right: 15.0, top: 100),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            //color: Colors.red,
                            /*child: CircleAvatar(
                              radius: 80,
                              backgroundImage: Image.network(
                                'https://picsum.photos/250?image=9',
                              ),
                            ),*/
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                imageUrl))
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(name, style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                              ),
                                maxLines: 2,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      /*Image.asset(
                                        "assets/fb.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 20,),*/
                                      Text(email, style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 17,
                                      ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          )
                        ],
                      ),
                    ],
          ),),),

          Container(
            //_getDrawerItemWidget(_selectedDrawerIndex),
            child: Padding(
              padding:  EdgeInsets.only(top: 230),
              child: SettingsList(
              sections: [
                SettingsSection(
                  title: 'Account',
                  tiles: [
                    SettingsTile(
                      title: 'Change number',
                      leading: Icon(Icons.local_phone, color: Colors.teal[700]),
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Change Gmail',
                      leading: Icon(Icons.email, color: Colors.teal[700]),
                      onTap: () {

                        final FirebaseAuth _auth = FirebaseAuth.instance;

                        var myemail = email;
                        signOutGoogle();

                        signInWithGoogle().then((result) async{
                          if (result != null) {
                            FirebaseUser user = await _auth.currentUser;

                            firestoreInstance.collection("users").getDocuments().then((querySnapshot) {
                              querySnapshot.documents.forEach((result) {
                                print(result.data);
                                if(result['email'] == myemail){
                                  this.uid = result['uid'];
                                }
                              });
                            });

                            //var firebaseUser = FirebaseAuth.instance.currentUser;
                            firestoreInstance
                                .collection("users")
                                .document(user.uid)
                                .updateData({
                                      "name" : name,
                                      "email" : email,
                                      "notification" : false,
                                      "phone_num" : null,
                                      "profile": imageUrl,
                            });

                            Navigator.pop(context);
                            Navigator
                                .of(context)
                                .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                              return new HomeScreen();
                            }));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Settings()),
                            );


                          }
                        });

                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: 'Common Settings',
                  tiles: [
                    SettingsTile.switchTile(
                      title: 'Send Notification',
                      leading: Icon(Icons.add_alert, color: Colors.teal[700]),
                      switchValue: false,
                      onToggle: (bool value)  async{
                        /*Data.notification = value;
                        await _firestore
                            .collection('users')
                            .document(Data.docid)
                            .updateData({'notification': value});*/
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),),
        ],
      ),
    );
  }
}