// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voetbal_viewer/Services/auth.dart';
import 'package:voetbal_viewer/wrapper.dart';
import 'package:voetbal_viewer/Persons/user.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My app', // used by the OS task switcher
        home: Wrapper(),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//       seconds: 3,
//       navigateAfterSeconds: StreamProvider<User>.value(
//         value: AuthService().user,
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'My app', // used by the OS task switcher
//           home: Wrapper(),
//         ),
//       ),
//       title: new Text(
//         'Voor de beste coaches \n van sv Hillegom',
//         textAlign: TextAlign.center,
//         style: new TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//             color: Color(0xFF0062A5)),
//       ),
//       image: new Image.asset(
//         'fonts/splashscreen_icon.png',
//         height: MediaQuery.of(context).size.height * 0.4,
//         width: MediaQuery.of(context).size.width * 0.2,
//       ),
//       backgroundColor: Colors.white,
//       loadingText:
//           Text('Laden...', style: new TextStyle(color: Color(0xFF0062A5))),
//       photoSize: 100.0,
//       loaderColor: Color(0xFF0062A5),
//     );
//   }
// }
