import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restapi_matriomony/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashBoard.dart';
import 'loginScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    whereToGo();
  }

  void whereToGo() async{
      var sharedPref=await SharedPreferences.getInstance();
      var isLoggedIn=sharedPref.getBool(KEYLOGIN);
      Timer(Duration(seconds: 2), () {
        if(isLoggedIn != null){
          if(isLoggedIn) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()));
          }
          else{
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginscreen()));
          }
        }
        else{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Loginscreen()));
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginscreen()));
      },);
    }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: Lottie.asset(
              'assets/animation/animation_1.json'
          ),
        ),
        nextScreen: Loginscreen(),
      splashIconSize: 200,
      // duration: 3000,
    );
  }
}
