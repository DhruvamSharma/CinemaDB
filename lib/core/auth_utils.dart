import 'package:cinema_db/core/common_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthUtils {
  Future<bool> signIn();
  Future<bool> isSignedIn();
  String getProfilePicture();
}

class AuthUtilsImpl extends AuthUtils {
  @override
  Future<bool> signIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final currentUser = FirebaseAuth.instance.currentUser;

      // Once signed in, return the UserCredential
      return currentUser != null;
    } catch (ex) {
      return false;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    // Once signed in, return the UserCredential
    return currentUser != null;
  }

  @override
  String getProfilePicture() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.photoURL ?? CommonConstants.profileUrl;
    } else {
      return CommonConstants.profileUrl;
    }
  }
}
