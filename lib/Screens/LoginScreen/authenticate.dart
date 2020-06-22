import 'package:flutter/material.dart';
import 'package:voetbal_viewer/Screens/LoginScreen/log_in.dart';

class Authenticate extends StatefulWidget{

  @override 
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{
  @override 
  Widget build(BuildContext context){
    return Container(
      child: Signin(),
    );
  }
}