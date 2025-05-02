abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthEmailVerificationSent extends AuthState {}

class AuthSuccess extends AuthState {
  final String userId;
  AuthSuccess(this.userId);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class PasswordResetSentState extends AuthState {}

// class OnboardingState extends AuthState {}

class GoToAuthState extends AuthState {}
