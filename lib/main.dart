import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pomodoro/core/navigation/router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/data/repositories/auth_repository_impl.dart';
import 'package:pomodoro/firebase_options.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependencies here
  final authRepository = AuthRepositoryImpl();
  final authBloc = AuthBloc(authRepository);
  authBloc.add(AppStarted());
  final AppRouter appRouter = AppRouter(authBloc: authBloc);

  runApp(PomoApp(authBloc: authBloc, appRouter: appRouter));
}

class PomoApp extends StatefulWidget {
  final AuthBloc authBloc;
  final AppRouter appRouter;

  const PomoApp({super.key, required this.authBloc, required this.appRouter});

  @override
  State<PomoApp> createState() => _PomoAppState();
}

class _PomoAppState extends State<PomoApp> {
  @override
  void initState() {
    super.initState();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // blend in
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // iOS
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: widget.authBloc,
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: Locale('en'),
        routerConfig: widget.appRouter.router,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('kk', 'KZ'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Pomodoro',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
