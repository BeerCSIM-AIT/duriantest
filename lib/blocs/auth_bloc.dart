import 'package:duriantest/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthService();
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<User?> get currentUser => authService.currentUser;

  loginGooble() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      //Firebase
      final result = await authService.signInWithCrediential(credential);
      print('${result.user!.displayName}');
    } catch (e) {
      print(e);
    }
  }

  logout() {
    authService.logout();
  }
}
