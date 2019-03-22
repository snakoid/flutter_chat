import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/models/firebase.helper.dart';
import 'contacts.controller.dart';
import 'messages.controller.dart';
import 'profile.controller.dart';

class HomeController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _HomeControllerState();
  }
}

class _HomeControllerState extends State<HomeController>{
  String uid;

  @override
  void initState() {
    super.initState();
    FirebaseHelper().myId().then((_uid){
      uid = _uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    Text title = new Text("Flutter Chat");
    return new FutureBuilder(
      future: FirebaseHelper().auth.currentUser(),
      builder: (BuildContext _c, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(Theme.of(context).platform == TargetPlatform.iOS){}
          else{
            new DefaultTabController(
              length: 3,
              child: new Scaffold(
                appBar: new AppBar(
                  title:title,
                  bottom: new TabBar(tabs: [
                    new Tab(
                      icon: new Icon(Icons.message),
                    ),
                    new Tab(
                      icon: new Icon(Icons.supervisor_account),
                    ),
                    new Tab(
                      icon: new Icon(Icons.account_circle),
                    )
                  ]),
                ),
                body: new TabBarView(children: controllers()),
              )
            );
          }
        }
        else{
          return new Scaffold(
            appBar: new AppBar(
              title : title
            ),
            body: new Center(
              child: new Text(
                "Loading ...",
                style: new TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  color:Colors.blue
                ),
              ),
            ),
          );
        }
      }
    );
  }

  List<Widget> controllers(){
    return [
      new MessagesController(uid),
      new ContactsController(uid),
      new ProfileController(uid)
    ];
  }
}