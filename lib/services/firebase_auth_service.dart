import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone_app/services/authentication_api.dart';

class FirebaseAuthService extends AuthenticationApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCredential signInWithOtp(String verificationId, String smsCode) {
    return PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
  }

  @override
  Future<AuthResult> signInWithCredential(AuthCredential credential) async {
    AuthResult result = await _auth.signInWithCredential(credential);
    return result;
  }

  @override
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      return user.uid;
    }
    return null;
  }
}
