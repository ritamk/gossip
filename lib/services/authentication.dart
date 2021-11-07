import 'package:firebase_auth/firebase_auth.dart';
import 'package:gossip/models/user.dart';
import 'package:gossip/services/database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel? _userFromFirebase(User? user) {
    return (user != null) ? UserModel(uid: user.uid) : null;
  }

  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithMailPass(String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithMailPass(String name, String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      User? user = userCredential.user;

      await DatabaseService(uid: user!.uid).setUserData(ExtendedUserData(
        uid: user.uid,
        name: name,
        email: user.email,
        phone: "",
        adLine: "",
        city: "",
        state: "",
        pin: "",
      ));

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }
}
