import 'package:firebase_auth/firebase_auth.dart';
import 'package:prdip/model/UserModel.dart' as u;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<bool> saveUser({required u.User user}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('user', user.userToString());
    return Future.value(true);
  }

  Future<u.User> fetchUser() async {
    final SharedPreferences prefs = await _prefs;
    String userString = prefs.getString('user') ?? '';
    if (userString.isNotEmpty) {
      return u.userFromMap(userString);
    } else {
      return Future.value(null);
    }
  }

  Future<bool> logout() async {
    bool out = true;
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString('user', '');
      _firebaseAuth.signOut();
    } catch (e) {
      out = false;
    }
    return Future.value(out);
  }
}
