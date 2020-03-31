import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:voetbal_viewer/Persons/user.dart';
import 'package:voetbal_viewer/Screens/LoginScreen/authenticate.dart';
import 'package:voetbal_viewer/Screens/MainScreen/BottomNavigator.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // dynamic returnScreen(){
    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavigator();
    }
    //}
    
    // return new SplashScreen(
    //   seconds: 3,
    //   navigateAfterSeconds: returnScreen(),
    //   title: new Text(
    //     'Voor de beste coaches \n van sv Hillegom',
    //     textAlign: TextAlign.center,
    //     style: new TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 20.0,
    //         color: Color(0xFF0062A5)),
    //   ),
    //   image: new Image.asset(
    //     'fonts/splashscreen_icon.png',
    //     height: MediaQuery.of(context).size.height * 0.4,
    //     width: MediaQuery.of(context).size.width * 0.2,
    //   ),
    //   backgroundColor: Colors.white,
    //   loadingText:
    //       Text('Laden...', style: new TextStyle(color: Color(0xFF0062A5))),
    //   photoSize: 100.0,
    //   loaderColor: Color(0xFF0062A5),
    // );
  }
}
