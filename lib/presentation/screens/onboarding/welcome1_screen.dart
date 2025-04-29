import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pomodoro/presentation/screens/onboarding/welcome2_screen.dart';
import 'package:pomodoro/presentation/widgets/common/page_indicators.dart';

class Welcome1Screen extends StatelessWidget {
  const Welcome1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPage = 0;
    List<Widget> pages = [const Welcome1Screen(), const Welcome2Screen()];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stack only the top section (background + image)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.pastelBlueLight
                    : AppColors.pastelBlueDark,
              ),
              Positioned(
                bottom: -size.height * 0.25, // how much it peeks out
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border:
                    //         Border.all(color: AppColors.green500, width: 5)),
                    child: Image.asset(
                      'assets/images/welcome1-bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          
          // Title & Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome1Title,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).headlineSmall,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.welcome1Description,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).labelMedium!.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.n600
                          : AppColors.n400),
                ),
                const SizedBox(height: 30),
                PageIndicators(currentPage: currentPage, count: pages.length),
              ],
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/welcome2'),
                child: Text(
                  AppLocalizations.of(context)!.nextButton,
                  style: TextTheme.of(context).labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
