import 'package:firebase_database/firebase_database.dart';

class User{
  String uid;
  String firstname;
  String lastname;
  String img_url;
  String initials;

  User(DataSnapshot _snap) {
    Map map = _snap.value;
    firstname = map["prenom"];
    uid = map["uid"];
    lastname = map["nom"];
    img_url = map["img_url"];
    if (firstname != null && firstname.length > 0) {
      initials = firstname[0];
    }
    if (lastname != null && lastname.length > 0) {
      if (initials != null) {
        initials += lastname[0];
      } else {
        initials = lastname[0];
      }
    }
  }

  Map toMap(){
    return {
      'firstname':firstname,
      'lastname':lastname,
      'img_url':img_url,
      'uid':uid,
    };
  }
}