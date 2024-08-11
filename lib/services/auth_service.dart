import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static UserModel? _user;
  static UserModel? get user => _user;

  static void initialize() {
    _auth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _user = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email.toString(),
          name: firebaseUser.email!.split("@")[0],
        );
      } else {
        _user = null;
      }
    });
  }

  static Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email.toString(),
          name: email.split("@")[0]);
      return true;
    } catch (e) {
      return false;
      print(e);
    }
  }

  static Future<bool> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email.toString(),
          name: email.split("@")[0]);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future signOut() async {
    await _auth.signOut();
    _user = null;
  }
}
