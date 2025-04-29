import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/logic/blocs/onboarding/splash/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          current is SplashNavigateToHome ||
          current is SplashNavigateToOnboarding,
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          print(state);
          context.go('/home');
        } else if (state is SplashNavigateToOnboarding) {
          print(state);

          context.go('/welcome1');
        }
      },
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/pomo-t-logo.png',
              width: 200,
              height: 200,
            ),
            Text(
              'Pomo',
              style: TextTheme.of(context).displayLarge,
            ),
          ],
        )),
      ),
    );
  }
}
