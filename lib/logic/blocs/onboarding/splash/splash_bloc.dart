import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(
        milliseconds: 1500)); // Simulate loading or logo animation

    // Replace this logic with your real auth check, etc
    final isLoggedIn = await _checkIfUserIsLoggedIn();

    if (isLoggedIn) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToOnboarding());
    }
  }

  Future<bool> _checkIfUserIsLoggedIn() async {
    // Your logic here (SharedPreferences, token check, etc)
    return true; // Just for example
  }
}
