import 'package:flutter/material.dart';
import 'package:pomodoro/core/themes/app_theme.dart';

class AuthHeaderContainerWidget extends StatelessWidget {
  final Map<String, Color> containerColors;
  final Map<String, String> containerTexts;

  const AuthHeaderContainerWidget(
      {super.key, required this.containerColors, required this.containerTexts});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      alignment: AlignmentDirectional.bottomStart,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? containerColors['lightBgColor']
              : containerColors['darkBgColor'],
          // ? AppColors.pastelPurpleLight
          // : AppColors.pastelPurpleDark,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // AppLocalizations.of(context)!.welcomeBack,
            containerTexts['title']!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // AppLocalizations.of(context)!.enterLogin,
            containerTexts['description']!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.n800
                    : AppColors.n200),
          ),
        ],
      ),
    );
  }
}
