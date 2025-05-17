import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashBoard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen6State();
}

class _SplashScreen6State extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => (DashBoard())),
      );
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/couple_4.png'),
            fit: BoxFit.cover,
          ),
        ),
        // child: Center(child: Text('Find yours',style: TextStyle(fontSize:25,color: Colors.black),)),
      ),
    );
  }
}
