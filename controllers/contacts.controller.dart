import 'package:flutter/material.dart';

class ContactsController extends StatefulWidget{
  String uid;

  @override
  State<StatefulWidget> createState() {
    return new _ContactsControllerState();
  }

  ContactsController(String _uid){
    this.uid = _uid;
  }
}

class _ContactsControllerState extends State<ContactsController>{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Contacts"),
    );
  }
}