import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/data/repositories/onboarding/onboarding_repository.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome1_screen.dart';
import 'package:pomodoro/presentation/widgets/common/page_indicators.dart';

class Welcome2Screen extends StatelessWidget {
  const Welcome2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    final size = MediaQuery.of(context).size;

    List<Widget> pages = [Welcome1Screen(), Welcome2Screen()];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.pastelYellowBright
                  : AppColors.pastelYellowDark,
            ),
            Positioned(
              bottom: -size.height * 0.20, // how much it peeks out
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: Container(
                  // decoration: BoxDecoration(
                  //     border:
                  //         Border.all(color: AppColors.green500, width: 5)),
                  child: Image.asset(
                    'assets/images/welcome2-bg.png',
                    // height: size.height * 0.40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 310,
                child: Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.welcome2Title,
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 350,
                  child: Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.welcome2Description,
                    style: TextTheme.of(context).labelMedium!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.n600
                            : AppColors.n400),
                  )),
              const SizedBox(
                height: 45,
              ),
              PageIndicators(currentPage: currentPage, count: pages.length),
            ],
          ),
          Container(
            width: double.infinity,
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: ElevatedButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(Welcome2PassEvent());
                },
                child: Text(
                  AppLocalizations.of(context)!.readyButton,
                  style: TextTheme.of(context).labelLarge,
                )),
          )
        ],
      ),
    );
  }
}
