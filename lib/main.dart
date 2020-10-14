import 'package:flutter/material.dart';
import 'MySplash.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [Locale('en', 'US')],
      localizationsDelegates: [CountryLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal[700],
      ),
      home: new MySplash(),
    );
  }
}

