import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyEmail = 'user_email';
  static const String _keyRole = 'user_role';

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Mock auth
    if (email.endsWith('@mareheadspa.com') && password == 'mare-private') {
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyRole, 'internal'); // Default role
      return true;
    }
    return false;
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRole);
  }

  Future<bool> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyEmail);
    prefs.remove(_keyRole);
    return true;
  }

  Future<bool> isSignedIn() async {
    final email = await getEmail();
    return email != null;
  }
}

