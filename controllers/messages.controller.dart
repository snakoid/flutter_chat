import 'package:flutter/material.dart';

class MessagesController extends StatefulWidget{
  String uid;

  @override
  State<StatefulWidget> createState() {
    return new _MessagesControllerState();
  }

  MessagesController(String _uid){
    this.uid = _uid;
  }
}

class _MessagesControllerState extends State<MessagesController>{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Messages"),
    );
  }
}