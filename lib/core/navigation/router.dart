import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentation/screens/auth/forget_password_email.dart';
import 'package:pomodoro/presentation/screens/auth/forgot_password_otp.dart';
import 'package:pomodoro/presentation/screens/auth/login_screen.dart';
import 'package:pomodoro/presentation/screens/auth/register_screen.dart';
import 'package:pomodoro/logic/blocs/onboarding/splash/splash_bloc.dart';
import 'package:pomodoro/presentation/screens/home_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/splash_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome1_screen.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome2_screen.dart';
import 'package:pomodoro/presentation/screens/projects/projects_home.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => BlocProvider(
        create: (_) => SplashBloc()..add(AppStarted()), // Trigger the event!
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/welcome1',
      builder: (context, state) => const Welcome1Screen(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const Welcome1Screen(), // Your new page screen
          transitionDuration:
              const Duration(milliseconds: 200), // Duration for smoothness
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var slideAnimation = Tween(
              begin: const Offset(1.0, 0.0), // Start from the right
              end: Offset.zero, // End at the normal position
            ).animate(animation);

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/welcome2',
      builder: (context, state) => const Welcome2Screen(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const Welcome2Screen(), // Your new page screen
          transitionDuration:
              const Duration(milliseconds: 200), // Duration for smoothness
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var slideAnimation = Tween(
              begin: const Offset(1.0, 0.0), // Start from the right
              end: Offset.zero, // End at the normal position
            ).animate(animation);

            return SlideTransition(
              position: slideAnimation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
        path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/forgotPasswordEmail',
        builder: (context, state) => const ForgotPasswordEmailScreen()),
    GoRoute(
        path: '/forgotPasswordOtp',
        builder: (context, state) => const ForgotPasswordOtpScreen()),
    GoRoute(
        path: '/home', builder: (context, state) => const HomeScreen()),

    // GoRoute(
    //   path: '/onboarding',
    //   builder: (context, state) => OnboardingScreen(),
    // ),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => HomeScreen(),
    // ),
  ],
);
