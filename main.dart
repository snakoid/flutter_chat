import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'controllers/login.controller.dart';
import 'controllers/home.controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _handleAuth(),
    );
  }

  Widget _handleAuth(){
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder:(BuildContext context, snapshot){
          if(snapshot.hasData){
            return new HomeController();
          }
          else{
            return new LoginController();
          }
        }
    );
  }
}