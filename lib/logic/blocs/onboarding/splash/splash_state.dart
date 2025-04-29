part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToHome extends SplashState {}

class SplashNavigateToOnboarding extends SplashState {}

class SplashError extends SplashState {
  final String message;
  SplashError(this.message);
}
