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

    if (user == null) {
      return Authenticate();
    } else {
      return BottomNavigator();
    }
  }
}
