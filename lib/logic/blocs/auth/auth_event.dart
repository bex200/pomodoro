abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

// class Welcome1PassEvent extends AuthEvent {}

class Welcome2PassEvent extends AuthEvent {}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignInWithEmailEvent({required this.email, required this.password});
}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpWithEmailEvent({required this.email, required this.password});
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignInWithAppleEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  ForgotPasswordEvent({required this.email});
}

class SignOutEvent extends AuthEvent {}
