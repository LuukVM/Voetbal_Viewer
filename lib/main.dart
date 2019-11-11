// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'BottomNavigator.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'package:voetbal_viewer/test.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new BottomNavigator(),
      title: new Text('Voor de beste coaches \n van sv Hillegom',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Color(0xFF0062A5)
      ),),
      image: new Image.asset('fonts/splashscreen_icon.png'),
      backgroundColor: Colors.white,
      loadingText: Text('Laden...', 
        style: new TextStyle(
          color: Color(0xFF0062A5))),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Color(0xFF0062A5),
    );
   // return MaterialApp(
   //   home: BottomNavigator(),
   // );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: MyApp(),
  ));
}
