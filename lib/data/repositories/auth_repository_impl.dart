import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Failed to sign in with email: $e");
    }
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception("Failed to sign up with email: $e");
    }
  }

  @override
  Future<void> sendEmailVerification(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      final ActionCodeSettings acs = ActionCodeSettings(
        url:
            'https://pomodoro-21.firebaseapp.com/emailVerify', // ✅ Custom deep link
        handleCodeInApp: true,
        iOSBundleId: 'com.example.pomodoro',
        androidPackageName: 'com.example.pomodoro',
        androidInstallApp: true,
        androidMinimumVersion: '1',
      );

      await user.sendEmailVerification(acs);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Error signing in with Google: $e');
    }
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleIDCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleIDCredential.identityToken,
        accessToken: appleIDCredential.authorizationCode,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Error signing in with Apple: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut(); // Sign out from Firebase
      await _googleSignIn.signOut(); // Sign out from Google Sign-In
    } catch (e) {
      print("Error signing out: $e");
      throw Exception('Error signing out: $e');

      // Handle the error (e.g., show an error message)
    }
  }

  @override
  Future<bool> isSignedIn() async {
    User? user = _firebaseAuth.currentUser;
    return user != null;
  }

  @override
  Future<String?> getUserId() async {
    User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Failed to send password reset email: $e");
    }
  }
}
