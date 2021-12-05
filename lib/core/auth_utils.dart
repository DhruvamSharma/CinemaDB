import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthUtils {
  Future<String?> signIn();
}

class AuthUtilsImpl extends AuthUtils {
  @override
  Future<String?> signIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // Trigger the authentication flow
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();
    String? accessToken;
    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      accessToken = googleSignInAuthentication.accessToken;
    }

    return accessToken;
  }
}
