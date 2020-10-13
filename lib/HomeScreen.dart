import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'ChatBot.dart';

import 'Tabs/Home.dart';
import 'Tabs/History.dart';

import 'Phone_google_auth/sign_in.dart';
import 'Phone_google_auth/LoginHome.dart';

import 'Three_Dots/Settings.dart';
import 'Three_Dots/Help.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  GifController controller;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Image.asset(
                  "assets/chatbot.gif",
                  height: 130,
                  width: 130,
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return new ChatBot();
                    },
                  ));
                },
            ),
            appBar: AppBar(
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Settings', 'Help', 'Logout'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
              backgroundColor: Colors.teal[700],
              title: Text("SmartC Box"),
              bottom: TabBar(
                  //isScrollable: true,
                  tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.history),
                  text: 'History',
                )
              ]),
            ),
          body: TabBarView(
            children: [
              Home(),
              History(),
            ],
          ),
        ));
  }

  void handleClick(String choice){
    if(choice == 'Settings'){
      print('Settings');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Settings()),
      );
    }
    else if(choice == 'Help'){
      print('Subscribe');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Help()),
      );
    }
    else if(choice == 'LogOut'){
      print('SignOut');
      signOutGoogle();
      Navigator
          .of(context)
          .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
        return new LoginHome();
      }));
    }
  }

}
