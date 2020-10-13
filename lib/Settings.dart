import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'Phone_google_auth/sign_in.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF8F8FA),
      body: Stack(
        children: <Widget>[
          Container(
                color: Colors.teal[700],
                height: 200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 15.0, right: 15.0, top: 80),
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
            padding: new EdgeInsets.only(top: 202),
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
          ),
        ],
      ),
    );
  }
}