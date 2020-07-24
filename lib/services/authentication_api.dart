import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationApi {
  /// Used to retrieve loggedin user's UID
  ///
  /// Returns null if no user is logged in else returns the user's UID
  Future<String> getCurrentUser();

  Future<AuthResult> signInWithCredential(AuthCredential credential);
}
