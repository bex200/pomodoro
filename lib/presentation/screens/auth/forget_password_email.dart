import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.resetTitle,
                style: TextTheme.of(context).headlineMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                AppLocalizations.of(context)!.resetDescription,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.n600
                        : AppColors.n400),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: TextTheme.of(context).labelMedium,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextTheme.of(context).labelMedium,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide.none)),
                    ),
                  ])),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: () => {context.go('/forgotPasswordOtp')},
                    child: Text(
                      AppLocalizations.of(context)!.signinButton,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
