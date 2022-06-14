import 'dart:async';
import 'dart:convert';

import 'package:ecarihesap/screens/giris_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'anasayfa.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key  key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  initState() {
    super.initState();
    this.initialAction();
  }

  initialAction() async {
    // SharedPreferences.setMockInitialValues({});

    var data = await SharedPreferences.getInstance();
    var accessToken = data.getString('access_token') ?? "";

    Timer(Duration(seconds: 2), () {
      if( accessToken.length > 0 ) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Anasayfa()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>GirisScreen()));
      }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xff7F3DFF),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo3.png", height: 120,),
            SizedBox(height: 20,),
           // CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
          ],
        ),

      ),);
  }
}
