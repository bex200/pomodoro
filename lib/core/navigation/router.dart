import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/navigation/page_transition.dart';
import 'package:pomodoro/data/repositories/onboarding/onboarding_repository.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';
import 'package:pomodoro/presentation/screens/auth/forget_password_email.dart';
import 'package:pomodoro/presentation/screens/auth/forgot_password_otp.dart';
import 'package:pomodoro/presentation/screens/auth/login_screen.dart';
import 'package:pomodoro/presentation/screens/auth/register_screen.dart';
import 'package:pomodoro/presentation/screens/auth/verify_email_page.dart';
import 'package:pomodoro/presentation/screens/auth/verify_handler_page.dart';
import 'package:pomodoro/presentation/screens/home_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/splash_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome1_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome2_screen.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshNotifier(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final router = GoRouter(
    // initialLocation: '/splash',
    refreshListenable: GoRouterRefreshNotifier(authBloc.stream),
    redirect: (context, state) async {
      final authState = authBloc.state;
      print(authState);

      // final isSplash = state.path == '/splash';
      final isLoggedIn = authState is AuthSuccess;
      final isAuthProcess = state.uri.path == '/login' ||
          state.uri.path == '/register' ||
          state.uri.path == '/forgotPasswordEmail';
      final isVerifyProcess = state.uri.path == '/emailVerify';
      final onboardingProcess =
          state.uri.path == '/welcome1' || state.uri.path == '/welcome2';

      final hasSeenOnboarding =
          await OnboardingRepository().hasSeenOnboarding();
      print(!isLoggedIn);
      print(!hasSeenOnboarding);
      print(state.uri.path);
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload(); //
      await OnboardingRepository().markSeenOnboarding();
      final isEmailVerify = state.uri.path == '/emailVerify';

      if (!isLoggedIn && isEmailVerify) {
        return null; // Let it through
      }
      if (user == null && state.uri.path == '/home') {
        return '/login';
      }

      if (!isLoggedIn &&
          !hasSeenOnboarding &&
          authState is GoToAuthState &&
          !onboardingProcess) {
        return '/welcome1';
      }

      if (!isLoggedIn &&
          hasSeenOnboarding &&
          authState is GoToAuthState &&
          !isAuthProcess) {
        return '/register';
      }

      if (isLoggedIn && !user!.emailVerified) {
        // This means the user has not verified their email yet
        return '/register'; // Stay on the register screen
      }

      if (!isLoggedIn &&
          hasSeenOnboarding &&
          authState is AuthInitial &&
          !isAuthProcess) {
        return '/login';
      }
      print(authState);
      print((user?.emailVerified) ?? "No user yet");
      if (isLoggedIn && isAuthProcess ||
          isLoggedIn && state.uri.path == '/' ||
          authState is AuthEmailVerificationSent && user!.emailVerified) {
        return '/home';
      }

      return null;
    },
    routes: [
      // GoRoute(
      //   path: '/splash',
      //   builder: (context, state) => const SplashScreen(),
      // ),
      GoRoute(
        path: '/welcome1',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const Welcome1Screen()),
      ),
      GoRoute(
        path: '/welcome2',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const Welcome2Screen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const LoginScreen()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const RegisterScreen()),
      ),
      GoRoute(
        path: '/verifyPage',
        name: 'verifyPage',
        builder: (context, state) {
          return const VerifyEmailPromptPage();
        },
      ),
      GoRoute(
        path: '/emailVerify',
        name: 'emailVerify',
        builder: (context, state) {
          final oobCode = state.uri.queryParameters['oobCode'];
          return EmailVerificationHandlerPage(oobCode: oobCode);
        },
      ),

      GoRoute(
        path: '/forgotPasswordEmail',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const ForgotPasswordEmailScreen()),
      ),
      GoRoute(
        path: '/forgotPasswordOtp',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const ForgotPasswordOtpScreen()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            buildPageWithTransition(const HomeScreen()),
      ),
    ],
  );
  void listenToDynamicLinks(BuildContext context) {
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri != null && uri.path == '/emailVerify') {
        final user = FirebaseAuth.instance.currentUser;
        await user?.reload(); // Reload user data from Firebase

        if (user != null && user.emailVerified) {
          // If user is verified, navigate to home
          context.go('/home'); // GoRouter navigation
        } else {
          // Show error message or notification
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Email not verified yet. Please try again.")));
        }
      }
    });
  }
}
