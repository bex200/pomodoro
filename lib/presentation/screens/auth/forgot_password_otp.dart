import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 52,
              right: 52),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset('assets/images/guard-icon.png'),
              const SizedBox(
                height: 30,
              ),
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.resetLinkSent,
                style: TextTheme.of(context).titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.resetLinkSentDescription,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.n600
                        : AppColors.n400),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      AppLocalizations.of(context)!.loginAgainButton,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
