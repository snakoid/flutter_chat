import 'package:flutter/material.dart';
import 'package:flutter_chat/models/firebase.helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _LoginControllerState();
  }
}

class _LoginControllerState extends State<LoginController>{
  bool __log = true;
  String __email;
  String __password;
  String __firstname;
  String __lastname;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Login"
        ),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 2,
              child: new Card(
                elevation: 5.0,
                child:new Container(
                  margin: EdgeInsets.only(left:15.0, right:15.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: cardWidgets(),
                  ),
                )
              ),
            ),
            new RaisedButton(
              onPressed: (){
                _handleLog();
              },
              color: Colors.blue,
              child: new Text(
                (!__log ? "Log in" : "Sign in"),
                style: TextStyle(
                  color:Colors.white,
                  fontSize: 25.0
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> cardWidgets(){
    List<Widget> widgets = [];

    widgets.add(new TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
        hintText: "email"
      ),
      onChanged: (_str){
        setState(() {
          __email = _str;
        });
      },
    ));

    widgets.add(new TextField(
      obscureText: true,
      decoration: new InputDecoration(
        hintText: "password"
      ),
      onChanged: (_str){
        setState(() {
          __password = _str;
        });
      },
    ));

    if(__log){
      widgets.add(new TextField(
        decoration: new InputDecoration(
            hintText: "firstname"
        ),
        onChanged: (_str){
          setState(() {
            __firstname = _str;
          });
        },
      ));

      widgets.add(new TextField(
        decoration: new InputDecoration(
            hintText: "lastname"
        ),
        onChanged: (_str){
          setState(() {
            __lastname = _str;
          });
        },
      ));
    }

    widgets.add(new FlatButton(
        onPressed: (){
          setState(() {
            __log = !__log;
          });
        },
        child: new Text(
          (__log ? "If you don't have an account, go to signin" : "If you have an account, go to login"),
          style: new TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ))
    );

    return widgets;
  }

  _handleLog() {
    if(__email != null && __email != ""){
      if(__password != null && __password != ""){
        if(!__log){
          FirebaseHelper().handleSignIn(__email, __password).then((FirebaseUser user){
            print("we got a user");
          }).catchError((error){
            alertt(error.toString());
          });
        }
        else{
          if(__firstname != null && __firstname != ""){
            if(__lastname != null && __lastname != ""){
              FirebaseHelper().handleCreate(__email, __password, __firstname, __lastname).then((FirebaseUser user){
                print("we created a user");
              }).catchError((error){
                alertt(error.toString());
              });
            }
            else{
              alertt("Empty lastname");
            }
          }
          else{
            alertt("Empty firstname");
          }
        }
      }
      else{
        alertt("Empty password");
      }
    }
    else{
      alertt("Empty email");
    }
  }

  Future<void> alertt(String _err) async{
    Text title = new Text("We got an error");
    Text sub_stitle = new Text(_err);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _bc){
        return new AlertDialog(
         title: title,
         content: sub_stitle,
         actions: <Widget>[
           okButton(_bc)
         ], 
        ); 
      }
    );
  }

  FlatButton okButton(BuildContext _c){
    return new FlatButton(
      onPressed: (()=>{
        Navigator.of(_c).pop()
      }),
      child: new Text('OK')
    );
  }
}