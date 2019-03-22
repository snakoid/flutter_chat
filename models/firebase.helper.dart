import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'user.model.dart';

class FirebaseHelper{
  final auth = FirebaseAuth.instance;

  //<editor-fold name="AUTH">
  Future<FirebaseUser> handleSignIn(String _mail, String _password) async {
    final FirebaseUser user = await auth.signInWithEmailAndPassword(email: _mail, password: _password);
    return user;
  }

  Future<FirebaseUser> handleCreate(String _mail, String _password, String _firstname, String _lastname) async {
    final FirebaseUser user = await auth.createUserWithEmailAndPassword(email: _mail, password: _password);
    String uid = user.uid;
    Map<String, String> map = {
      "uid":uid,
      "firstname":_firstname,
      "lastname":_lastname
    };
    addUser(uid, map);
    return user;
  }

  Future<bool> handleLogOut() async {
    await auth.signOut();
    return true;
  }

  Future<String> myId() async{
    FirebaseUser user = await auth.currentUser();
    return user.uid;
  }
  //</editor-fold>

  //<editor-fold name="DB">
  static final base = FirebaseDatabase.instance.reference();
  final base_user = base.child("users");

  addUser(String _id, Map _map){
    base_user.child(_id).set(_map);
  }

  Future<User> getUser(String _uid) async{
    DataSnapshot snap = await base_user.child(_uid).once();
    return new User(snap);
  }

  //</editor-fold>
}