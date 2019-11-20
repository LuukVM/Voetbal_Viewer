// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'BottomNavigator.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voetbal_viewer/football_icons.dart';
import 'package:voetbal_viewer/test.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:voetbal_viewer/example_1.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new BottomNavigator(),
      title: new Text(
        'Voor de beste coaches \n van sv Hillegom',
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Color(0xFF0062A5)),
      ),
      image: new Image.asset('fonts/splashscreen_icon.png'),
      backgroundColor: Colors.white,
      loadingText:
          Text('Laden...', style: new TextStyle(color: Color(0xFF0062A5))),
      photoSize: 100.0,
      loaderColor: Color(0xFF0062A5),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    //home: ExampleVeld(),
    home: MyApp(),
    // home: new StaggeredGridView.countBuilder(
    //   crossAxisCount: 4,
    //   itemCount: 9,
    //   itemBuilder: (BuildContext context, int index) => new Container(
    //       color: Colors.blue,
    //       child: new Center(
    //         child: new CircleAvatar(
    //           backgroundColor: Colors.white,
    //           child: new Text('$index'),
    //         ),
    //       )),
    //   staggeredTileBuilder: (int index) =>
    //       new StaggeredTile.count(2, index.isEven ? 2 : 1),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    // ),
  ));
}
