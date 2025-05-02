abstract class AuthRepository {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(String email, String password);
  Future<void> sendEmailVerification(String email);
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String?> getUserId();
  Future<void> forgotPassword(String email); 
}
