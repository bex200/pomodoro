import 'dart:async';

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
      final isAuthProcess =
          state.uri.path == '/login' || state.uri.path == '/register' || state.uri.path == '/forgotPasswordEmail';
      final onboardingProcess =
          state.uri.path == '/welcome1' || state.uri.path == '/welcome2';
      
      final hasSeenOnboarding =
          await OnboardingRepository().hasSeenOnboarding();
      print(!isLoggedIn);
      print(!hasSeenOnboarding);
      print(state.uri.path);
      if (!isLoggedIn && state.path == '/home') {
        return '/login';
      }

      if (!isLoggedIn && !hasSeenOnboarding && authState is GoToAuthState && !onboardingProcess) {
        print('IM IN WLCOME');
        return '/welcome1';
      }
     
      if (!isLoggedIn && hasSeenOnboarding && authState is GoToAuthState && !isAuthProcess) {
        print('IM IN REGISTER');
        
        return '/register';
      }
      if (!isLoggedIn && hasSeenOnboarding && authState is AuthInitial && !isAuthProcess) {
        return '/login';
      }

      if (isLoggedIn && isAuthProcess) {
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
}
