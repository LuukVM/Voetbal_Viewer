import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:voetbal_viewer/Screens/PlayerScreen/PlayerWidget.dart';
import 'package:voetbal_viewer/Services/auth.dart';
import 'package:voetbal_viewer/Shared/constants.dart';
import 'package:voetbal_viewer/Shared/loading.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 80.0),
                        SizedBox(
                            child: new Image.asset('fonts/app_icon.png'),
                            height: 150.0),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Vul een email in' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) =>
                                val.isEmpty ? 'Vul een password in' : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            color: Color(0xFF0062A5),
                            child: Text('Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            onPressed: () async {
                              Vibration.vibrate(duration: 50, amplitude: 125);
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Login gegevens niet herkent';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0)),
                        SizedBox(height: 130.0),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height * 0.9),
                        ),
                        child: RaisedButton(
                          color: Color(0xFF0062A5),
                          child: Container(
                            alignment: Alignment.center,
                            width: 200.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Spelers',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Vibration.vibrate(duration: 50, amplitude: 125);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => PlayerPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
