import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_onboarding/minimal_onboarding.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  List<OnboardingPageModel> onboardingPages = [
    OnboardingPageModel('assets/chatbot.gif', 'STEP 1',
        'Report a Complaints via SmartC Bot. Fill the all neccessary information asked by the Bot through voice input or text input.'),
    OnboardingPageModel('assets/track.png', 'STEP 2',
        'Track or Check the current status of all complaints register by you in history Tab '),
    OnboardingPageModel('assets/emergency.png', 'STEP 3',
        'If you feel you are in danger dial emergency number provided to you'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartC Box',
      home: MinimalOnboarding(
          color: Colors.teal,
          onboardingPages: onboardingPages,
          dotsDecoration: DotsDecorator(
            activeColor: Color(0xFF4E67EB),
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        onFinishButtonPressed: () => Navigator.pop(context),
        onSkipButtonPressed: () => Navigator.pop(context),),
    );
  }
}
