import 'package:flutter/material.dart';
import 'package:flutter_chat/models/user.model.dart';
import 'package:flutter_chat/models/firebase.helper.dart';

class ProfileController extends StatefulWidget{
  String uid;

  @override
  State<StatefulWidget> createState() {
    return new _ProfileControllerState();
  }

  ProfileController(String _uid){
    this.uid = _uid;
  }
}

class _ProfileControllerState extends State<ProfileController>{
  @override
  void initState() {
    super.initState();

    FirebaseHelper().getUser(widget.uid).then((User _user){
      print(_user.initials);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Profile"),
    );
  }
}