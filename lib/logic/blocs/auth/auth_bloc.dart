import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/data/repositories/auth_repository.dart';
import 'package:pomodoro/data/repositories/onboarding/onboarding_repository.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    // on<Welcome1PassEvent>(_onWelcome1Passed);
    on<Welcome2PassEvent>(_onWelcome2Passed);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInWithAppleEvent>(_onSignInWithApple);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    print("AppStarted triggered");
    emit(AuthLoading());
    final isSignedIn = await _authRepository.isSignedIn();
    if (isSignedIn) {
      final userId = await _authRepository.getUserId();
      emit(AuthSuccess(userId!));
    } else {
      final onboardingRepository = OnboardingRepository();
      await onboardingRepository.markUnSeenOnboarding();
      print(
          'We are here after app started and we did the authentificate checkups');
      emit(GoToAuthState());
    }
  }

  // Future<void> _onWelcome1Passed(
  //     Welcome1PassEvent event, Emitter<AuthState> emit) async {
  //   try {
  //     emit(OnboardingState());
  //   } catch (e) {
  //     emit(AuthError("Onboarding Unexpected Error"));
  //   }
  // }

  Future<void> _onWelcome2Passed(
      Welcome2PassEvent event, Emitter<AuthState> emit) async {
    try {
      final onboardingRepository = OnboardingRepository();
      await onboardingRepository.markSeenOnboarding();
      emit(GoToAuthState());
    } catch (e) {
      emit(AuthError("Onboarding Unexpected Error"));
    }
  }

  Future<void> _onSignInWithEmail(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithEmail(event.email, event.password);
      final userId = await _authRepository.getUserId();
      emit(AuthSuccess(userId!));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getEmailSignInErrorMessage(e.code)));
    } catch (_) {
      emit(AuthError("Unexpected error. Please try again."));
    }
  }

  Future<void> _onSignUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Sign up the user with email and password
      await _authRepository.signUpWithEmail(event.email, event.password);

      // Send email verification
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        // Send email verification link
        await _authRepository.sendEmailVerification(event.email);
      }

      // Wait for the user to verify the email before proceeding
      emit(AuthEmailVerificationSent());

      // Optionally, you can guide the user to check their inbox
      // For now, we just emit that email verification is sent
      // You can use a separate state to notify that email is sent.
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getEmailSignUpErrorMessage(e.code)));
    } catch (_) {
      emit(AuthError("Unexpected error. Please try again."));
    }
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithGoogle();
      final userId = await _authRepository.getUserId();
      emit(AuthSuccess(userId!));
    } catch (_) {
      emit(AuthError("Error signing in with Google"));
    }
  }

  Future<void> _onSignInWithApple(
      SignInWithAppleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithApple();
      final userId = await _authRepository.getUserId();
      emit(AuthSuccess(userId!));
    } catch (_) {
      emit(AuthError("Error signing in with Apple"));
    }
  }

  Future<void> _onForgotPassword(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    print(event.email);
    emit(AuthLoading());
    try {
      await _authRepository.forgotPassword(event.email);
      emit(PasswordResetSentState());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          emit(AuthError("The email address is not valid."));
          break;
        case 'user-not-found':
          emit(AuthError("No user found with this email."));
          break;
        case 'missing-email':
          emit(AuthError("Please enter your email."));
          break;
        default:
          emit(AuthError("Something went wrong: ${e.message}"));
      }
    } catch (_) {
      emit(AuthError("Unexpected error occurred."));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository.signOut();
    emit(AuthInitial());
  }

  // Helpers
  String _getEmailSignInErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  String _getEmailSignUpErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'Password is too weak. Use a stronger one.';
      default:
        return 'Failed to sign up. Please try again.';
    }
  }
}
