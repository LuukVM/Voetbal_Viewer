import 'package:flutter/material.dart';
import 'package:voetbal_viewer/Services/auth.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0062A5),
      body: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Log In'),
          onPressed: () async {
            dynamic result = await _auth.signIn();
            if (result == null) {
              print('failed logged in');
            } else {
              print('signed in');
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
